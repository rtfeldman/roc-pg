# Actions performance investigation and generator cleanup

This report separates two goals: make Roc handle the **original generated
source** efficiently, and improve roc-pg's generated source **without waiting
for compiler optimizations**. Claude Fable 5.1 completed the first investigation
before any generator refactoring began. It had exclusive use of this thread's
build and timing workload.

The detailed original-source investigation is in
[actions-performance-analysis.md](actions-performance-analysis.md).
The final validation and paired measurements are in
[actions-refactor-validation.md](actions-refactor-validation.md).

## Executive summary

- The original `Actions.roc` produced **40,091,111 type variables during
  checking**, before Monotype specialization. Repeated opening/copying of its
  large `Node` type—not the size of the integer dispatcher—explains almost all
  that growth.
- The compiler's cache-write failure is fixed: a 2.19 GB artifact is written in
  bounded, host-specific chunks and loads successfully on the next build.
  That eliminated approximately 14 seconds of recurring checking/publication
  work on an unchanged build.
- The generator now shares equivalent rule bodies, combines independent node
  field updates, removes unnecessary mutation and parameter aliases, and
  shares the immutable null node. These are source refactors, not changes to
  SQL parsing behavior or compiler optimization policy.
- The generated file shrank from **30,381 to 18,541 lines**, and from
  **1,156,582 to 764,639 bytes**. It now has **1,051 shared rule bodies**
  instead of 2,279 and **1,761 qualified payload constructions** instead of 4,732.
- The experimental compiler optimizations remain **experiments**, not
  production changes. Temporary profiling instrumentation was removed from
  the compiler sources after measurement.

### Final paired measurements

These use the **same baseline compiler**, without the experimental compiler
optimizations, with two compiler workers and sequential timing runs.

| Metric | Original sources | Selected cleanup |
|---|---:|---:|
| Actions type variables | 40,091,111 | **14,887,510** |
| Actions checked cache entry | 2.187 GB | **0.832 GB** |
| Cold package check (`--no-cache`) | 61.43 s | **43.02 s** |
| Cold package check peak RSS | 8.863 GB | **5.337 GB** |
| Warm small dev build, verified 61/61 checked-cache hits | 32.07 s | **19.34 s** |
| Warm small dev build peak RSS | 11.011 GB | **6.337 GB** |
| Shared Monotype lowering in that warm build | 26.612 s | **15.422 s** |

That is approximately **63% fewer Actions type variables**, **30% faster cold
checking**, **40% lower cold-check peak RSS**, and **40% faster warm dev builds**.
These are paired runs, not statistically controlled benchmark medians; the
allocation counts and serialized sizes are the deterministic evidence.
Earlier no-verbose paired runs measured 31.10 s versus 17.58 s warm, consistent
with the improvement but illustrating wall-time variation.

Final validation passed:

- 28 translator tests and 36 template tests (the suites include some shared
  imported tests, so their counts should not be summed as unique test cases).
- All 383 package tests.
- All eight example/test-program checks.
- All 21 expected compile-time SQL rejections with their expected messages.
- Live PostgreSQL integration, including MD5/SCRAM authentication and typed queries.
- 300 concurrent requests at concurrency 40, completing in 278 ms.
- Byte-identical before/after parse output for all 40,107 corpus inputs.
- Byte-identical output on a second generator run.

## 1. What Fable found in the original source

### The 2.19 GB cache entry was mostly the checker environment

| Serialized component | Bytes |
|---|---:|
| Cache envelope | 97 |
| `ModuleEnv` | 2,120,559,844 |
| Post-check `CheckedModuleArtifact` | 66,687,756 |
| Total | **2,187,247,697** |

The environment's type-store arrays alone occupied 2,112,012,360 bytes.
This was real retained type data, not spare allocator capacity being serialized.
The live heap could be larger because of capacity and temporary structures.

The original `Node` backing contains 224 tags, 222 payload records, 999 record
fields, and 2,453 type variables. The checker repeatedly materialized that
whole graph for operations involving just one constructor:

- 5,024 checker openings: **12,323,872 variables**.
- Roughly 4,743 whole-union expected-shape copies: another **11.6 million**.
- 4,743 exhaustiveness openings: **11,634,579 variables**.
- Associated `List`/`Try` openings: approximately **3.5 million** more.

About 97% of the variables were attributable to this construction/analysis
expansion rather than distinct program syntax. Cross-module import copying
accounted for only 9,502 variables and was ruled out as the main cause.

The "Type Inference" timing was not exclusively constraint solving: representative
runs spent roughly **8–9 seconds checking** and **5.6–5.8 seconds constructing the
checked artifact**. Approximately 12.4 million variables were reachable from
published roots; the rest still occupied the raw store and its cache.

### The numeric `match` was not the expensive part

The user proposed a compact representation for the large group of literal
branches in `Actions.run`, with broader applicability beyond numbers.
Fable measured this explicitly:

- approximately **57,475 variables**, or **25 per branch**;
- approximately **30 ms**;
- **0.14%** of the module's variables, with linear growth.

A compact literal-family representation may still be useful, but it is not the
right first optimization here. The broader principle behind the suggestion is
exactly right: **using one value of a declared type should not repeatedly cost
the size of the entire declaration**. Constructor payloads and read-only
exhaustiveness analysis are the high-impact places to apply it.

### There is a second exhaustiveness pathology

Cold-cache checking also exposed substantial costs hidden by earlier cache hits:

- `Node.roc`: approximately **15.7–19.9 seconds**.
- `Check.roc`: approximately **6.2–7.8 seconds**.

Fable traced these to repeated inhabitedness computation for every constructor
at multiple pattern-matrix levels, with fresh traversal state each time. Its
synthetic tests showed cubic growth for the relevant shapes. Memoization within
one stable analysis is a promising, separate improvement.

### Compiler experiments demonstrate the opportunity

Fable tested combinations of memoized inhabitedness, read-only ground-template
traversal, avoiding whole-union expected-shape copies, and projecting nominal
opening to the tag being constructed. In its combined experiment:

| Original-source Actions metric | Baseline | Experiment |
|---|---:|---:|
| Type variables | 40.09 million | 1.10 million |
| Checking | 9.06 s | 0.50 s |
| Publication | 5.77 s | 0.44 s |
| Cache entry | 2.19 GB | 161 MB |

It reported unchanged diagnostics across the package, deliberate error cases,
and 433 snapshots, with variable renumbering in some snapshots. This is evidence
of potential payoff, **not a proof that the experimental patch is ready to land**.
One toggle removes an expected-shape projection entirely; a production solution
must preserve its intended semantics even if existing tests do not observe it.
The patch and synthetic fixtures are retained under
[`actions-performance-analysis/`](actions-performance-analysis/).

## 2. What changed in roc-pg

### Share grammar-action bodies

The generator translates each rule to a structured template, retaining the
body, parameters, and literal arguments separately. Equivalent templates share
one explicitly typed helper; dispatcher arms call it directly, without adding
per-rule wrappers. Original grammar labels remain beside the dispatch arms.

Extraction is based on the translator's known C/Roc types, not a regular
expression replacing numbers in generated text. Numeric literals, character
constants, and resolved unshadowed integer constants can become `I64` parameters
only in explicitly integer contexts. Strings, variable names, switch patterns,
structural stack offsets, pointer contexts, and string-encoded `T_*` node tags
are not treated as numeric slots.

Implementation: [`RuleBodies.roc`](../tools/RuleBodies.roc#L1),
[`Translate.roc`](../tools/Translate.roc#L38), and the
[`actions.roc` emission loop](../tools/actions.roc#L158).

### Combine independent node updates

Straight-line runs such as a `makeNode` initialization followed by independent
field assignments become one record update and one `Node` construction. The
same treatment applies to independent adjacent updates of an incoming node.

This is driven by the parsed C statements and the translator's alias model.
Batching stops at observable reads of the target, arbitrary calls, repeated
fields, alias writebacks, variant changes, and control-flow boundaries.
Consequently it does not reorder potentially observable computations.

The broader "keep a payload record through an entire function and wrap only at
escape points" transformation was deliberately not implemented. It needs
explicit escape/alias analysis across those boundaries. Local batching gives
substantial savings with a smaller correctness argument.

### Remove unnecessary mutation

[`CleanLocals.roc`](../tools/CleanLocals.roc#L1) runs after C aliases and inout
writebacks have been lowered:

- Never-reassigned locals become ordinary immutable bindings.
- Immutable copies of function parameters are replaced by the parameters.
- Names cannot capture existing locals or parameters.
- Unused initializers are still evaluated; the pass does not silently discard
  a potentially failing or otherwise significant expression.
- Literal string contents remain untouched, while identifiers inside nested
  `${...}` interpolation expressions are correctly renamed.

Fable measured no checker-performance improvement from `var` removal alone.
This part is for readability and a simpler generated program.

### Share null in record defaults, but not in Actions

The Node generator declares `null : Node` once for its generated record
defaults. **Actions deliberately emits inline `Null` expressions**, whose
`Node` type is established by the surrounding typed code.
Patterns and the unrelated `Null` error tag retain their original meaning.

This differs from the initial recommendation because measuring the entire
compiler pipeline revealed a serious tradeoff:

| Same compiler, warm small dev build | Wall time | Monotype lowering | Peak RSS |
|---|---:|---:|---:|
| Original sources | 31.10 s | 26.915 s | 10.85 GB |
| Cleanups with shared null values in Actions | 89.09 s | 87.002 s | 6.00 GB |
| Cleanups with inline null values in Actions | 17.58 s | 15.367 s | 6.27 GB |
| Cleanups with a null-producing function | 17.64 s | 15.449 s | 6.28 GB |

The shared value was cheaper to check but much more expensive to lower.
The factory and inline variants were effectively tied, so the simpler inline
form was selected. This is why checker variable counts alone were not used
as the acceptance criterion. The regression and its isolation should also
be useful to the compiler team.

### Add repeatable validation tools

- Generator regressions in
  [`TranslateTests.roc`](../tools/TranslateTests.roc#L1) and
  [`RuleTemplates.roc`](../tools/RuleTemplates.roc#L1).
- [`parser_corpus.roc`](../tests/parser_corpus.roc#L1), which writes parse trees
  or errors for JSONL SQL inputs, and
  [`parser_corpus.py`](../tools/parser_corpus.py#L1), which constructs the corpus.
- [`test-cli.sh`](../tools/test-cli.sh#L1), an optional one-shot adapter for
  compilers whose default dev `run` watches files.

Before changing the generator, regeneration with PostgreSQL 18.6 and bison 3.8.2
reproduced the original `Actions.roc` and `Node.roc` byte-for-byte.
Generated files are regenerated, not hand-maintained.

## 3. Correctness issues found and addressed during the refactor

1. The first immutable-renaming pass skipped entire strings, including generated
   interpolation expressions. That left references to renamed `$variables`.
   The scanner now distinguishes literal text, escapes, interpolation braces,
   and nested strings, with regressions for each.
2. Independent review found that conditional-alias metadata lowered an expression
   but discarded its updated literal-parameter state. A later parameter could
   capture the guard's name and silently change a comparison from `1` to `7`.
   Metadata expressions now retain constants inline rather than allocate
   undeclared parameters. The same rule covers saved list-read expressions.
3. `T_*` node-tag constants have a string representation in this translator.
   They are explicitly excluded from `I64` slot extraction, even if the
   constant table contains an integer value for the name.

These were fixed before final validation. The conditional-alias regression
checks silent capture, not merely an undefined-name error.

## 4. Validation, measurements, and judgment calls

The [validation report](actions-refactor-validation.md) is the authoritative
record of final test counts, source hashes, command lines, and paired timings.
Validation includes accepted parse trees **and rejected-input errors**, not just
successful compilation.

The differential corpus was constructed from 235 PostgreSQL regression/example
SQL files: 40,107 distinct inputs, including 39,550 accepted inputs and 557
rejections in the baseline. This is a refactor-equivalence test, not a claim of
complete grammar coverage or equivalence to every PostgreSQL behavior.

Judgment calls made without needing the sleeping user:

- Build bison 3.8.2 and PostgreSQL 18.6 inside ignored `local/` directories because
  the machine's default bison was 2.3 and suitable server tools were not on PATH.
  No system installation or existing database was changed.
- Use the same baseline compiler for before/after source measurements. The
  experimental compiler toggles are not used to claim refactor improvements.
- Use LLVM `speed` builds for live database integration. The dev backend
  aborted during MD5/SCRAM authentication both with the refactored sources and
  with an original-source control. A speed build passed that integration
  program. This compiler/backend issue remains separate from the refactor.
- Use fresh executable paths for one-shot tests after observing macOS kill an
  overwritten dev executable despite successful on-disk signature verification;
  copying it to a fresh inode allowed it to run.
- When the parent Delta checkout repeatedly failed materialization, move final
  validation into a fresh isolated worktree containing the latest virtual-file
  state. Running commands in the stale parent checkout was not accepted as
  final validation.
- Keep optimization barriers conservative rather than force every C pattern
  into a shared helper or combined update.
- Reject the shared-null-value variant despite its lower checker/memory cost:
  it nearly tripled warm build time. Keep inline null expressions in Actions;
  the factory variant did not show a meaningful win over that simpler choice.

No pull request was opened and no changes were published to an external service.

## 5. Recommended next steps

### Roc compiler

1. **Stop allocating permanent type graphs for read-only nominal analysis.**
   Traverse immutable backing templates through explicit argument-substitution
   views. Exhaustiveness, payload inhabitedness, and constructor discovery should
   not inflate the serializable type store. Preserve recursive-type termination
   and substitution identity in the view's seen sets.
2. **Memoize inhabitedness within a stable exhaustiveness analysis.**
   Do not reuse results across solver mutations without an explicit validity rule.
3. **Project expected shapes and nominal openings to the relevant payload.**
   Preserve the enclosing constructor's full type relation and diagnostics.
   Do not blindly share mutable template nodes between applications.
4. **Add representation-growth regressions.**
   Cover wide recursive nominals and many constructors, and assert that
   read-only analysis does not allocate persistent type variables. Retain
   negative typing, exhaustiveness, and literal-defaulting tests.
5. **Reuse eligible parser objects before Monotype lowering.**
   Unchanged builds still repeat substantial post-check work. Existing pack
   filters already exclude literal-converting closures and uncarried
   program-local dependencies; earlier claims that all such dependencies
   require new metadata were too broad. The existing compile-time
   exhaustiveness-observation guard must also gate early hits, which otherwise
   bypass the later lookup guard. Validate an early-hit change with both
   successful parser reuse and diagnostic-preservation tests before landing it.
6. Investigate the dev-backend MD5/SCRAM heap corruption separately.

### roc-pg

1. Keep the cleanup in the generator and rerun the generator tests whenever it
   changes; do not edit the generated rules by hand.
2. Keep the parse-tree/error differential corpus in the refactor workflow.
3. Consider a typed payload-record representation across whole functions only
   after adding explicit alias/escape handling and corresponding negative tests.
4. Remaining repeated record updates, mutable return accumulators, and pure
   helper calls may offer further source simplification. Prioritize reductions
   in nominal construction, rather than cosmetic mutation removal, for current
   compiler performance.
5. Remeasure after compiler fixes: source cleanup and compiler representation
   improvements address complementary costs, and neither substitutes for the other.
