# Why checking `package/Actions.roc` is slow and huge, and what to do about it

Analysis of the compile-time cost of the **original, unrefactored**
`package/Actions.roc` (and, as it turned out, `Node.roc` and `Check.roc`) in
the Roc compiler's type checker, with measured attributions, root causes,
validated experiments, and prioritized recommendations for both the compiler
and the C→Roc translator. Everything here was measured on the unmodified
package; no production compiler change was made. Supporting fixtures live in
`docs/actions-performance-analysis/` (see §13).

## 0. Headline findings

1. **97% of the 40,091,111 type variables that checking Actions creates are
   copies of the `Node` declaration's backing type**, which has 224 tags, 222
   payload records and 999 record fields (2,453 type variables). Every
   `Node.X(...)` constructor expression (5,024 of them, including 292
   `Node.Null`) instantiates that whole 2,453-variable graph **three times**
   (once to type the constructor, once as "expected shape" context for the
   payload, once for the absent-constructor exhaustiveness analysis), plus
   ~370 two-variable micro-openings of `List`/`Try` per constructor while
   deciding whether each of the other 223 payloads is inhabited. The program's
   own types account for ≈1.0M variables.
2. Those copies also inflate everything downstream: 12.4M of the variables
   are reachable from published roots (so the settled-row validator, the
   generalizer and the checked-artifact publisher all walk them), the
   serialized `ModuleEnv` is 2.12 GB (97% type store), publication takes
   5.6 s, and the cache entry is 2,187,247,697 bytes.
3. **`Node.roc` itself is the slowest module in the package** (15.7–19.9 s to
   check, hidden from the earlier measurements because it was cache-hot), and
   `Check.roc` takes 6.2–7.8 s for only 330k variables. Both are a separate,
   *cubic* pathology in exhaustiveness checking: inhabitedness of each
   constructor's payload is recomputed from scratch (fresh `seen` set, no
   memo) at every matrix level of every `match`, each recomputation walking the
   whole 2,453-node `Node` graph.
4. The 2,300-branch integer `match rule` in `Actions.run` is **not** a
   material cost: 57,475 variables (25 per branch, 0.14% of the total) and
   ~30 ms, linear in branch count.
5. An env-var-gated experimental patch (not production code, included as
   `compiler-experiment.patch`) that (a) memoizes inhabitedness per
   exhaustiveness entry point, (b) walks ground declaration templates
   read-only instead of copying them, (c) skips the whole-union
   expected-shape copy, and (d) opens a nominal constructor **projected to the
   one tag being constructed** reduces Actions to **1,104,286 variables,
   0.50 s check, 0.44 s publish, 161 MB cache entry** (from 40.09M / 9.06 s /
   5.77 s / 2.19 GB), `Node.roc` to 0.60 s and `Check.roc` to 0.21 s, with
   **byte-identical diagnostics and types** on the roc-pg package, a set of
   deliberately ill-typed constructions, and all 433 compiler snapshot tests
   (only type-variable numbers in CIR dumps differ), and no debug-mode
   invariant failures.
6. For the translator, under the **current** compiler the metric to minimize
   is simply the number of nominal constructor expressions (`Node.X(...)`,
   `Node.Null`) in each module: each costs ≈7,760 type variables, ≈1.7 ms of
   checking, ≈1.1 ms of publication and ≈400 KB of cache. Building the payload
   record first and wrapping once collapses 3,367 of Actions' 4,732
   constructors; a shared `Node.null` constant removes the 292 `Node.Null`
   constructors (200× cheaper per use); `var` vs immutable bindings makes no
   difference to the checker.
7. After the checker is fixed, `roc check` of the package/app is dominated by
   the post-check compile-time-evaluation pipeline (~23 s of Monotype
   lowering, SpecConstr, ARC and native codegen), which this analysis did not
   investigate beyond measuring it.

## 1. Baseline identity and environment

| Item | Value |
|---|---|
| `package/Actions.roc` | 30,381 lines, 1,156,582 bytes, sha256 `cdd2d59be288ecce0cbadebd0d703f575aae9bdc359a6ceb4ad697ef89b79120` |
| `package/Node.roc` | 3,865 lines, 178,237 bytes; `Node` union: 224 tags, 222 payload records, 999 fields (228 `List(Node)`, 139 `Node.Text`, 237 `Node`); 226 `match` expressions |
| Compiler | Roc `release-fast-e79b7f85` built from the parent thread's worktree state (including its temporary `ROC_PROFILE_CACHE` instrumentation), `zig build roc -j2 -Doptimize=ReleaseFast -Dstrip=false`, Zig 0.16.0 |
| Host | macOS 26.6.2, Apple Silicon (10 cores), 32 GB; machine ~85% idle during runs, load average 3–5 from unrelated processes |
| Worker count | every `roc` invocation used `-j2`; every `zig build` used `-j2` |
| Cache | isolated `ROC_CACHE_DIR` under the analysis worktree; `XDG_CACHE_HOME` pointed under the worktree while building the compiler (the build step clears the Roc cache) |
| Actions cache entry (baseline) | `<cache>/release-fast-e79b7f85/mod/8c/ad4b41de40376e83f5feee969cb78cba989f641fd63bae0addec84e40169d1`, 2,187,247,697 bytes — identical size to the parent thread's measurement, confirming the same baseline |

No file of the roc-pg package was modified for any measurement. Synthetic
experiments used generated packages in scratch directories.

## 2. Methodology and caveats

* **Timers**: the parent's `ROC_PROFILE_CACHE=1` instrumentation prints, per
  module, `check_ms` (wall time of `Check.checkFile`), `publish_ms`
  (checked-artifact publication), and `vars` (`types.len()` after checking).
  I added one more line in my experimental builds only:
  `settled_reachable_vars` (variables reachable from published roots, counted
  inside `validateSettledValueRows`).
* **Counters**: the parent's `CACHE_OPEN category=… vars=…` lines (one per
  nominal opening / expected-shape copy, filtered to >2 vars in
  `exhaustive.zig`) were aggregated with a script. List/Try micro-opening
  counts are taken from the parent's `actions-open-profile.log` (same binary
  semantics; my runs filtered them out to reduce logging overhead).
* **CPU profiles**: macOS `sample` at 1 ms, parsed with
  `sample_inclusive.py` (inclusive samples per function, recursion counted
  once). Sample proportions have roughly ±10% jitter; absolute sample counts
  do not map 1:1 to milliseconds because `sample` cannot sustain 1 kHz.
* **Noise**: baseline Actions `check_ms` across six runs: 8,224–9,466 ms;
  `publish_ms`: 5,535–6,482 ms. Differences below ~10% are not significant.
  Variable counts are deterministic.
* **Scenarios**: (a) `roc check --no-cache -j2 package/main.roc` (whole
  package, every module built) and (b) `roc check -j2 examples/small/main.roc`
  with only the Actions cache entry evicted (the user's "edit Actions"
  scenario). I did not run `roc build` end to end (the parent has those
  numbers; nothing here changes the post-check pipeline).
* **Experiments are toggles, not fixes.** The experimental patch over- or
  under-approximates the recommended fixes in ways called out in §7; it exists
  to measure the payoff and to check that the semantics the fixes rely on hold
  across the test corpus.
* `ReleaseFast` was used for every timing. One Debug build was used only to
  check invariants (§7.3).

## 3. Baseline measurements

### 3.1 Whole package, cold (`roc check --no-cache -j2 package/main.roc`)

| Module | check (s) | publish (s) | vars after check | reachable from published roots |
|---|---:|---:|---:|---:|
| Node | 15.7–19.9 | 0.38 | 1,965,212 | 603,842 |
| Actions | 8.2–9.5 | 5.6–6.5 | 40,091,111 | 12,404,013 |
| Check | 6.2–7.8 | 0.02 | 330,278 | 10,315 |
| Catalog | 0.36–0.46 | 0.005 | 103,209 | 1,922 |
| Rt | 0.04 | 0.003 | 59,042 | 732 |
| all 29 others | < 0.05 each | | | |
| **wall** | **68–72 s** | | | |

Summed type checking is ≈36.7 s; the remaining ≈23 s of wall time is the
post-check compile-time finalization (§11). Peak RSS 8.9 GB.

### 3.2 App, warm except Actions (`roc check --time --verbose -j2 examples/small/main.roc`, 60/61 cached)

* wall 67.6 s; `type checking: 14,030 ms` (= Actions check 8.4 s + publish
  5.6 s); peak RSS 12.7 GB; cache entry written: 2,187,247,697 bytes.
* Actions enters `checkFile` with 2,585 variables and leaves with 40,091,111.
* Serialized `ModuleEnv` 2,120,557,276 bytes, of which type store
  2,112,012,360: descs 1,203 MB, slots 321 MB, record_fields 176 MB,
  root_metas 160 MB, tags 122 MB, vars 87 MB, union_ranks 40 MB. NodeStore
  (the CIR) is 6.07 MB. The `CheckedModuleArtifact` is 66.7 MB.

## 4. Where the 40M type variables come from (measured)

Aggregated from the per-opening counters for the Actions check:

| Source | Calls | Vars per call | Total vars | Share |
|---|---:|---:|---:|---:|
| `Check.openNominalBackingForApp` for `Node` (every `Node.X(…)` / `Node.Null` expression) | 5,024 | 2,453 | 12,323,872 | 30.7% |
| `exhaustive.openNominalBacking` for `Node` (absent-constructor payload analysis after every `var`/reassign/decl whose RHS is a constructor) | 4,743 | 2,453 | 11,634,579 | 29.0% |
| `Check.copyExpectedShape` of the opened backing, via `projectExpectedAggregateShape` for the payload tag | 4,732 | 2,454 | 11,611,128 | 29.0% |
| `exhaustive.openNominalBacking` for `List` (one per `List(Node)` field of each absent payload: 228 per sweep) | 1,079,576 | 2 | 2,159,152 | 5.4% |
| `exhaustive.openNominalBacking` for `Try` (one per `Node.Text` field: 139 per sweep) | 654,439 | 2 | 1,308,878 | 3.3% |
| small expected-shape copies, `Bool`/`Try` openings in the check path | ~1,400 | 2–9 | ~7,300 | 0.02% |
| cross-module copies (`copyVarWithSourceSubstitutions`) | 607 | — | 9,502 | 0.02% |
| **everything else — the program's own types** | | | **≈1,034,000** | **2.6%** |

The three big rows are exact: 5,024 ≈ 4,732 `Node.X(` + 292 `Node.Null`;
4,743 is the number of those constructions that sit directly on the right of
a `var`, reassignment, `decl` or lambda tail (`closeAbsentConstructedPayloadVars`
is invoked at each of those statement forms); 4,732 is every constructor with a
payload. The List/Try counts are 227.6 and 138.0 per sweep, matching the 228
`List(Node)` and 139 `Node.Text` fields of the `Node` payload records.

Of the 40.09M variables, **12,404,013 are reachable from published roots**
(the check-path openings, which get unified into the backing expressions'
types) and ~27.7M are unreachable scratch (the exhaustiveness openings and the
expected-shape copies). In `Rt`, `Catalog` and `Check` the unreachable share is
97–99%.

## 5. Where the time goes (measured, CPU samples)

### 5.1 Actions `checkFile` (baseline, 4,012 samples inside `checkFileInternal`)

| Function (inclusive) | Samples | Share | Driven by |
|---|---:|---:|---|
| `validateSettledValueRows` | 1,204 | 30% | walks the 12.4M reachable vars with a hash set |
| `collectAbsentCtorPayloadBlockers` (→ `exhaustive.openNominalBacking`, `isKnownAbsentCtorPayloadTypeInhabited`) | 1,075 | 27% | one `Node` opening + 367 micro-openings + payload walks per statement |
| `Generalizer.generalize` | 405 | 10% | every opened/copied var is registered in the rank pool |
| `pruneSelectedHoistedRootsAfterSolving` | 353 | 9% | 264 of them in `__bzero`: see §6.5 |
| `prepareNominalTypeUsage` → `openNominalBackingForApp` → `instantiateVarWithSubs` | 352 | 9% | the check-path copy |
| `projectExpectedAggregateShape` → `copyExpectedShape` | 280 | 7% | the expected-shape copy |
| `checkMatchExpr` (15 matches incl. the 2,300-branch one) | 199 | 5% | mostly exhaustiveness inhabitedness |
| `unify` | 73 | 2% | — |

Unification itself is negligible; the cost is in copying and in walking
copies.

### 5.2 Actions publication (4,507 samples)

`publishFromTypedModule` → `CheckedTypeStore.fromModule` = 95% (structural
copy/hash-consing of the 12.4M reachable vars into the 66.7 MB artifact);
serialization and hashing of the 2.1 GB `ModuleEnv` is the remainder.

### 5.3 `Node.roc` (9,941 samples) and `Check.roc`

97% in `checkMatchExpr` → `exhaustive.checkExhaustiveSketched` →
`isTypeInhabitedWithKnownEmpty` (→ `recurseIntoAllCtors`, hash-set
`getOrPut`, `openNominalBacking`). `Check.roc` (158 matches, many over `Node`)
shows the same profile.

## 6. Root causes

All of the above reduce to one rule the checker currently follows and two
consequences of it.

### 6.1 A nominal declaration's backing is a *generalized template that is deep-copied at every use*, even when it is ground

`Instantiator.requestVar` (`src/types/instantiate.zig`) shares every
non-generalized var and copies every generalized one. Declaration backings are
stored at generalized rank so that formals can be substituted, so for `Node`
(zero formals, fully ground backing) every "opening" copies all 2,453 nodes
although nothing in the copy can ever differ from the template. Four call
sites open backings this way:

1. `Check.openNominalBackingForApp` (constructor expressions `Node.X(…)` and
   nominal patterns): needed for the mutable relation of the written payload
   against the declared one, but it copies 2,453 nodes to relate ~5.
2. `Check.projectExpectedAggregateShape` → `copyExpectedShape`
   (`rank_behavior = .ignore_rank`): copies the *entire* expected union a
   second time just to find the payload slots of one tag, then probes
   `[X(fresh…), ext]` against the copy.
3. `exhaustive.openNominalBacking`, called by
   `collectAbsentCtorPayloadBlockersForConstructedTags` (after each statement
   whose RHS is a constructor) and by every `match`/destructure analysis:
   read-only analysis that nevertheless instantiates into the persistent
   `TypeStore`. The per-entry-point `NominalOpenCache` dedups within one
   analysis only; the vars stay in the store forever and get serialized.
4. `unify.zig`'s `openNominalBacking` (tag-union-vs-nominal lift, e.g. a plain
   `XmlSerialize(r)` pattern against a `Node` scrutinee). This one already
   has a *persistent opening memo for "openings made of structure alone"*
   within a generalization scope — an existing precedent that sharing a
   ground opening across relations is acceptable in this codebase.

### 6.2 Absent-constructor analysis is run for a type whose answer is static

`closeAbsentConstructedPayloadVars` exists to close payload variables of
constructors that a value provably never carries (e.g. the `Err` of a `Try`
that is only ever `Ok`). Its result can only be non-empty when an unresolved
flex/rigid variable is reachable through an absent payload. For a declaration
with no formals the opened backing contains no such variables, so the 4,743
analyses of `Node` targets in Actions do 23M variables of work with a
guaranteed empty result. (Experimentally confirmed: skipping the analysis for
zero-formal nominal targets changes nothing — §7.)

### 6.3 Inhabitedness is recomputed per constructor per matrix level with no memo

`isTypeInhabitedWithKnownEmpty` allocates a fresh `seen` set per call and is
called by `recurseIntoAllCtors`/the missing-constructor loop once per
constructor alternative at every specialization level. For a `match` over
`Node`, each of the 224 payload records reaches `Node` through its fields, so
each call walks the whole 2,453-node graph: a 2-branch
`match n { X(r) => r, _ => crash }` costs 223 × 2,453 node visits with hash-set
inserts (~70 ms), the two-column `is_eq`/`equal` matches cost
224 × 224 × 2,453, and `Node.roc` has 222 such accessors plus `tag`, `is_eq`,
`equal`. The synthetic K-tag experiment (§8) confirms cubic growth: K=100 →
1.9 s, K=250 → 27 s. There are three separate inhabitedness walkers in
`exhaustive.zig` (`isTypeInhabitedWithKnownEmpty`, `isCtorPayloadTypeInhabited`,
`isKnownAbsentCtorPayloadTypeInhabited`) with slightly different leaf policies
and no shared memo.

### 6.4 The copies are reachable, so every later pass pays for them

The check-path opening is unified with the constructor's backing expression,
so the 2,453-node copy becomes reachable from that expression's type. That
makes `validateSettledValueRows` (30% of check), the generalizer (10%), and
`CheckedTypeStore.fromModule` (95% of publication) proportional to
5,024 × 2,453 instead of to the program.

### 6.5 A derivative: shared `var_set` scratch inflated to 16.7M slots

`validateSettledValueRows` grows `self.var_set` to 16,777,216 slots; it runs
before `pruneSelectedHoistedRootsAfterSolving`, whose per-root
`varIsConcreteHoistedConstType` calls `var_set.clearRetainingCapacity()` —
a 16 MB memset each time. That is the 264 `__bzero` samples (~6% of check).
This disappears when the reachable graph is small, but it is also a one-line
fix on its own (dedicated small scratch set, or shrink after the big walk).

## 7. Experiments: what each candidate fix buys

All toggles are env-var gated (`std.c.getenv`, Release builds) and live in
`docs/actions-performance-analysis/compiler-experiment.patch` against
`src/check/Check.zig` and `src/check/exhaustive.zig`. They were built into
separate binaries so the baseline binary stayed untouched.

| Toggle | What it simulates | Approximation vs. the real fix |
|---|---|---|
| `ROC_EXP_EXH_MEMO` | memoize inhabitedness per resolved var within one exhaustiveness entry point (first build: top-level results only; second build: every sub-result via a `record_memo` work item) | real fix also memoizes ground results across entry points |
| `ROC_EXP_EXH_SHARE_GROUND` | `exhaustive.openNominalBacking` returns the template itself for zero-formal declarations | real fix walks any template read-only with a formal→arg substitution |
| `ROC_EXP_SKIP_ABSENT_GROUND` | skip `collectAbsentCtorPayloadBlockers` when the target is a zero-formal nominal | real fix computes the (static) answer once per declaration |
| `ROC_EXP_SKIP_TAG_PROJECTION` | disable the `e_tag` expected-shape projection entirely | real fix (§9, F3) keeps the projection but copies only the tag's arg slots |
| `ROC_EXP_PROJECT_OPEN` | for `e_nominal`/`e_nominal_external` whose backing is a tag, open the declaration *projected to that tag*: copy only its payload, build a fresh closed union whose other tags share the template's payload vars read-only | candidate real fix (§9, F2); patterns and the unifier path not covered |

### 7.1 Results (`roc check --no-cache -j2 package/main.roc`, ReleaseFast)

| Configuration | Node check | Actions check | Actions publish | Actions vars | Actions reachable | Check check | wall |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 19.9 s | 9.06 s | 5.77 s | 40,091,111 | 12,404,013 | 7.83 s | 71.8 s |
| MEMO (top-level only) | 7.13 | 8.98 | 5.60 | 40,091,111 | 12,404,013 | 1.84 | 48.7 |
| SHARE_GROUND | 19.3 | 7.96 | 5.59 | 28,446,762 | 12,404,013 | 7.90 | 65.9 |
| MEMO + SHARE_GROUND | 7.04 | 8.00 | 5.57 | 28,446,762 | 12,404,013 | 1.86 | 47.6 |
| SKIP_TAG_PROJECTION | 19.3 | 7.41 | 5.58 | 28,449,219 | 12,404,013 | 7.83 | 65.3 |
| SKIP_ABSENT_GROUND | 19.3 | 5.25 | 5.57 | 25,001,089 | 12,404,013 | 7.82 | 63.1 |
| all four (top-level memo) | 7.06 | 3.80 | 5.56 | 13,341,994 | 12,404,013 | 1.87 | 43.6 |
| all four (full memo) | **0.68** | 3.59 | 5.54 | 13,341,994 | 12,404,013 | **0.21** | 38.6 |
| all four + PROJECT_OPEN | **0.60** | **0.50** | **0.44** | **1,104,286** | **168,757** | **0.21** | **30.0** |

Readings:

* Each of the three big copies is worth ≈11.6M vars, exactly as attributed.
* Memory-only toggles (SHARE_GROUND, SKIP_TAG_PROJECTION) buy little *time*
  on their own; the time is in the walks (`collectAbsentCtorPayloadBlockers`,
  `validateSettledValueRows`, `fromModule`) and only drops when the walked
  graph shrinks.
* Publication does not move at all until the check-path opening is
  projected, because publication is proportional to the *reachable* graph.
* With everything applied, the Actions check is 18× faster, publication 13×,
  and the remaining 30 s of package wall time is the post-check pipeline.

### 7.2 App scenario with all toggles (Actions entry evicted)

`type checking: 949 ms` (baseline 14,031 ms); Actions cache entry
161,283,233 bytes (baseline 2,187,247,697; serialized `ModuleEnv` 94.6 MB);
peak RSS 6.7 GB (baseline 12.7 GB); wall 53.6 s (baseline 67.6 s) — the rest
is compile-time evaluation.

### 7.3 Correctness evidence for the experimental semantics

* The package checks with **no diagnostics** under every configuration.
* A synthetic module with a wrong payload type, an unknown tag, a wrong field
  type, a wrong arity and a non-exhaustive match produces **identical
  diagnostics** (5 errors, same kinds, same positions) with the baseline
  binary and with all toggles.
* A **Debug** build with all toggles checks the package and the error cases
  with no assertion or invariant failure (`debugAssertArraysInSync`,
  exhaustiveness invariants, etc.).
* `zig build run-check-snapshots -j2` with all toggles: **433 snapshots, 170
  changed lines, all of them type-variable renumbering** (`constraint-fn-var N`,
  `(var N)`) in CIR dumps — zero changes to TYPES or PROBLEMS sections. (The
  snapshot files were regenerated afterwards with the baseline binary and
  verified byte-identical to the parent worktree's.)
* Noteworthy by itself: disabling the `e_tag` expected-shape projection
  changed nothing observable anywhere in the corpus. Either the projection is
  redundant or its effect is not covered by tests; see judgment calls (§12).

## 8. Cost model from synthetic packages

`gen_nominal.py K M STYLE` generates a `Node`-like nominal with K tags (8-field
payload records containing `List(Node)`, `Node.Text`, `Node`) and M functions
that construct it. Baseline binary, `--no-cache -j2`:

| K | M | style | Node module check | Acts check | Acts vars | vars / constructor |
|---:|---:|---|---:|---:|---:|---:|
| 10 | 200 | updates (5 constructors each) | 5 ms | 143 ms | 775,784 | 776 |
| 50 | 200 | updates | 257 ms | 601 ms | 3,618,704 | 3,619 |
| 100 | 200 | updates | 1,889 ms | 1,155 ms | 7,172,354 | 7,172 |
| 250 | 200 | updates | **27,062 ms** | 3,024 ms | 17,830,704 | 17,831 |
| 250 | 200 | single constructor per function | — | 559 ms | 3,586,304 | 17,931 |
| 250 | 200 | updates with immutable bindings instead of `var` | — | 2,984 ms | 17,831,504 | 17,832 |
| 250 | 200 | `Node.Null` only | — | 461 ms | 2,515,103 | 12,576 |
| 250 | 200 | `Node.null` constant lookup only | — | 2 ms | 12,104 | 60 |

* Cost per constructor is linear in the backing size (≈3× backing + 2 ×
  (#List + #Try fields)), independent of whether the payload is a literal or a
  record update, and independent of `var` vs. immutable bindings.
* The `Node` module's own check time is cubic in K (exhaustiveness, §6.3).
* A zero-argument constructor costs almost as much as a full one; a value
  lookup costs nothing.

`gen_match.py N` generates a `U64` match with N integer-literal branches
calling N distinct functions: 2,300 branches cost 57,475 vars (25 per branch)
and ~30 ms; the 2,300 callee functions cost 267k vars. Both are linear.

For the real Actions, dividing the measured deltas by 5,024 constructors:
**≈7,760 vars, ≈1.7 ms check, ≈1.06 ms publish, ≈403 KB of cache per
constructor expression** (baseline minus the all-toggles configuration).

## 9. Compiler recommendations (prioritized)

The common principle: **work per use must be proportional to what was
written, not to the size of the declared type; share what is only read, copy
only what is unified.** The experiment shows the whole 36× reduction follows
from applying that principle at the four opening sites plus one memo.

### F1 — Exhaustiveness: memoized inhabitedness over a read-only template view (highest value per risk)

* **What**: one inhabitedness oracle for `exhaustive.zig`, replacing the three
  walkers' independent recomputation. Per entry point, memoize by resolved
  var (and by leaf policy, since the three walkers differ in how they treat
  flex/rigid/ignored leaves). Results for *ground* subgraphs (no flex/rigid
  reachable) do not depend on the `known_empty` list or the policy and can be
  memoized at module scope, keyed by declaration + constructor for declaration
  templates (never unified, so never invalidated). Open declarations for
  analysis as a **view**: walk `decl.backing` directly, mapping formal rigids
  to the application's actual arg vars via a substitution environment. This is
  the pattern `varIsConcreteHoistedConstTypeInternal(.decl_template)` and
  `nominalDeclBackingTemplate` already use for hoisted-constant queries.
* **Why it is safe**: the exhaustiveness code never unifies (the doc comments
  and the `NominalOpenCache` rationale state this); blockers it reports must be
  actual-arg variables, which the substitution environment yields directly
  instead of via a copied formal. `closeExhaustiveVars` only touches flex
  vars, which a ground template has none of.
* **Constraints to preserve**: optimistic treatment of recursion (a cycle is
  inhabited); the `known_empty` interaction (memo hits must be keyed by, or
  invalidated on, growth of `payload_vars_to_close`); the `active_nominals`
  non-regular-recursion convergence; distinct leaf policies.
* **Measured effect**: Node.roc 19.9 → 0.68 s, Check.roc 7.8 → 0.21 s,
  Actions −11.6M vars −3.5M micro-open vars and −27% check time (toggles
  MEMO+SHARE_GROUND+SKIP_ABSENT_GROUND).
* **Tests**: unit tests for `Try(a, [])`-style payload closing through the
  view; a recursive nominal (`T := [A(T)]`, mutually recursive pair); a
  `match` over a tuple of two 200-tag nominals asserting the analysis stays
  under a variable *budget* (e.g. `types.len()` delta per match ≤ a few hundred)
  — budget assertions are the only way to make this class of regression
  visible, since results are unchanged.

### F2 — Constructor checking: open the declaration *projected to the constructed tag*

* **What** (the experiment's `openNominalBackingForAppProjected`): when the
  backing expression is a tag `X` and the template is a closed tag union,
  copy only X's payload (with formal substitution), and build a fresh closed
  union `[…, X(copied payload), …]` whose other tags reference the template's
  payload vars. `finishNominalTypeUsage` then relates exactly as today, so the
  backing expression's checked type has the same shape as now (full union).
  Apply the same to nominal *patterns* (`checkNominalTypeUsage` from
  `checkPattern`) — not covered by the experiment.
* **Why it is safe**: the actual side has a single tag, so the unifier never
  descends into the shared tags; `poisonOnMismatch` poisons only the
  top-level operands (the fresh union and the actual), never template vars;
  `union_`'s rank-min merge only touches merged roots. The remaining
  exposure is read-only passes meeting generalized-rank vars under a rank-N
  structure; the Debug run and the snapshot corpus did not object, but this
  must be argued against the generalizer's invariants by whoever implements it.
  "Invalid nominal tag" diagnostics are produced from the template lookup and
  were identical in the error-case test.
* **Measured effect** (on top of F1/F3): Actions vars 13.3M → 1.10M,
  reachable 12.4M → 169k, check 3.6 → 0.50 s, publish 5.5 → 0.44 s, cache
  783 MB → 161 MB.
* **Bigger variant (F2b, hypothesis)**: do not materialize the full union in
  the backing expression's type at all. Monotype lowering derives the backing
  type from the declaration (`nominalConstructionLayer`,
  `lowerNominalBackingType`) and relates the backing *expression* structurally
  (`relateNominalExprAtNode` → `relateExprAtNode` by tag name), so it may not
  need the full union — but every consumer of that checked type (publication,
  evidence lookup, LSP hover, docs) must be audited first. F2 as experimented
  needs no such audit.
* **Also**: extend the unifier's existing "persistable opening made of
  structure alone" memo (`unify.zig`, per generalization scope) to module scope
  for zero-formal declarations, or project there too; Node.roc's 222 tag
  patterns against `Node` go through that path (≈545k of its remaining 825k
  vars).

### F3 — Expected-shape projection: borrow the tag's slots, copy only them

* **What**: mirror `borrowExpectedRecordField` for tags: find tag X in the
  expected union (following aliases, extension chain, nominal via F1's view),
  take its arg vars, and `copyExpectedShape` *those* (a few vars) instead of
  the whole union; probe/rollback semantics unchanged. If X is absent or the
  arity differs, return null as today.
* **Measured effect**: −11.6M vars (toggle SKIP_TAG_PROJECTION, which is the
  upper bound since it removes the projection entirely).
* **Open question** (§12): no test observes the projection at all.

### F4 — `var_set` scratch isolation (trivial)

Give `validateSettledValueRows` its own set or shrink `var_set` after it;
~6% of the baseline Actions check is memset of a 16 MB metadata array.

### F5 — Publication and cache (mostly solved by F1–F3)

`CheckedTypeStore.fromModule` and serialization are proportional to the
reachable/raw store respectively; after F1–F3 both are ~40× smaller. A
publication-time compaction of unreachable vars would alone have cut the 2.19
GB entry to ~0.78 GB but is not needed once the garbage is not produced; a
cheap guard is a **regression budget**: fail a test if checking a fixture with
a 200-tag nominal and 200 constructors creates more than, say, 50 vars per
constructor.

### F6 — Literal-branch representation (user idea 1): not recommended as a priority

Measured: 25 vars per literal branch (pattern literal var with its conversion
constraint, the branch's call, the callee scheme instantiation, four argument
lookups, branch/result vars), fully linear, 0.14% of Actions' vars and
~0.4% of its check time. A shared literal-family var per match would save at
most ~40k vars here and must still keep per-literal regions for diagnostics
and per-site dispatch plans for literal conversions. The *general* form of the
intuition — do not pay per use for the size of the declared type — is exactly
F1–F3. One related small win (hypothesis from the 25-vars-per-branch figure,
not separately measured): a scheme with no quantified variables (every
`rule_N`) appears to be copied per use by `instantiateTypeScheme` because its
root is at generalized rank; sharing ground schemes would remove a few tens of
thousands of vars across Actions.

## 10. Translator / source recommendations (for the current compiler)

Under the current compiler the cost of a module is, to first order,

> vars ≈ program + (#nominal constructor expressions) × (3 × |backing| + 2 × #List/Try fields in the backing)

and `Node.roc`'s check time ≈ (#matches over `Node`) × (#tags)² × |backing|
for two-column matches. Static counts for `Actions.roc` (`actions_stats.py`):

| Count | Value |
|---|---:|
| top-level functions / `rule_N` functions | 2,347 / 2,279 |
| `Node.X(` constructors / `Node.Null` | 4,732 / 292 |
| `var $n = Node.X(Node.x_default)` locals | 830 |
| same-variant updates `$n = Node.X({ ..Node.x_of($n), f: v })` of such locals | **3,367** (collapsible) |
| same-variant updates of incoming nodes (e.g. `rule_5`'s `nnames`) | 374 |
| constructors remaining if locals are built as records and wrapped once | **1,365** |
| distinct `rule_N` bodies modulo integer literals | 1,046 of 2,279 (1,465 functions in 232 duplicate groups) |
| constructors saved by sharing duplicate bodies (before collapsing) | 1,126 |

Recommendations, with the generalizable safety rule for each:

1. **Build the payload record, wrap once** (user idea 4, generalized). For a
   C local declared with a concrete node struct type and only ever assigned
   by `makeNode`/field writes, keep a Roc local of the *record* type
   (`var $n_rec = Node.a_array_expr_default`, `$n_rec = { ..$n_rec, elements:
   …, location: …, list_start: …, list_end: … }` — multiple fields in one
   update) and construct `Node.AArrayExpr($n_rec)` only at escape points
   (return, argument to a `Node`-typed call, storing into another node's
   field). Value semantics are preserved because the current translation
   already rebinds `$n` rather than mutating in place; if a variable is
   reassigned to a different variant or to a call result, keep the current
   form. Expected under the current compiler: 4,732 → ~1,365 constructors, i.e.
   Actions ≈ 11.7M vars, ≈2.8 s check, ≈1.9 s publish, ≈0.7 GB cache (model
   projection, not measured). The synthetic `single` style measured 4.97× fewer
   vars for 5 → 1 constructors, confirming the model.
2. **A shared `Node.null` constant** instead of 292 `Node.Null` constructor
   expressions (and the 239 in `Node.roc`'s defaults): measured 200× fewer
   vars per use. Generalizes to any zero-argument tag of a big nominal
   (`Rt.no_cell`-style constants already exist in `Rt.roc`).
   This measures checking, not whole-build performance. Subsequent controlled
   builds rejected shared null values in Actions because they increased
   Monotype lowering from ~15 s to ~87 s; the final generator keeps them only
   in record defaults (see `actions-refactor-validation.md`, “Null controls”).
   Both qualified `Node.Null` and the annotated binding have outer type `Node`.
   The constructor checks a fresh structural backing and opens the nominal
   declaration at each occurrence; a lookup reuses the checked binding. The
   distinction is construction versus lookup, not an open outer type caused
   by annotation polarity.
3. **Share duplicate rule bodies** (user idea 2): 232 groups / 1,465 functions
   differ only in integer literals; a shared helper with an explicit parameter
   removes up to 1,126 constructors (overlapping with item 1). Guard: the
   literals must have the same C type and the bodies must be identical after
   substitution; the generator can hash normalized bodies.
4. **`var` → immutable bindings** (user idea 3): no effect on the checker
   (identical var counts and times); worth doing for readability and because
   it lets item 1 apply more often, but it is not a performance lever.
5. **Avoid unnecessary wrap/unwrap operations when a payload record is
   already available.** Keep the record during construction rather than wrap
   it as `Node.X` solely to immediately call `Node.x_of` again. Genuine
   variant-dependent operations still need real matches; no unsafe casts or
   weakened exhaustiveness checks are recommended. The measured ~70 ms per
   `_of` accessor and seconds for `is_eq`/`equal`/`tag` are the costs of
   **checking their definitions**, not runtime call costs. Reducing call sites
   does not eliminate those definition-checking costs while the helpers remain
   in Node.roc. Fixing the compiler's exhaustiveness analysis is the general
   solution; Node.roc being cache-hot only hides the cost in ordinary edits.
6. Things that do **not** matter for checking: record update vs. record
   literal, numeric-literal suffixes, `Rt.*` helper calls, `?`/`Ok` wrapping
   (`Try`'s backing is 2 vars), the big integer `match`.

## 11. Secondary finding: post-check compile-time evaluation dominates `roc check` once checking is fixed

With all toggles, `roc check --no-cache package/main.roc` is 30 s wall of
which type checking is ~5 s. The rest is
`compile_time_finalization.finalizeProgram` → `monotype.lower.run`
(`drainPendingSpecJobs`, ~20k specialization tasks), SpecConstr, LIR, ARC and
native codegen — the pipeline the parent's early-object-cache work targets.
Source review establishes that developer-owned test roots include local-path
dependencies, and parser expectations provide paths through
`Parse.parse → Actions.run`. Their exact share of the measured work remains
unprofiled. Derived constants such as
`translate_bytes = translate_text.to_utf8()` are also constant roots, but this
particular conversion does not itself call the SQL parser. Including test
bodies for required compile-time processing is distinct from running test
assertions and returning their outcomes.

Completed constant values are persisted in finalized checked artifacts.
Compiled closed specializations belong in object packs, which normal cached
commands can read; currently native builds publish these packs. `roc test`
also has a separate outcome/transcript cache. These mechanisms do not make the
existing late object lookup skip earlier Monotype body lowering. The warm app
check (61/61 checked modules cached) still spends roughly 27 s in the shared
lowering/compile-time pipeline in the original measurements.

## 12. Facts, hypotheses, judgment calls

**Measured facts**: §3–§8 (var attributions, timings, toggle results, snapshot
equivalence, synthetic scaling, static counts).

**Hypotheses** (not measured): the F2b consumer audit (§9); the model
projections for translator cleanups (§10, items 1–3 extrapolate the measured
per-constructor cost); the CTFE driver (§11); that the F1 "view" walk needs no
changes to the unifier's `persistentOpening` logic.

**Judgment calls**:

* Scenario choice: `--no-cache` package checks and the evicted-Actions app
  check are treated as representative of "the compiler must handle the current
  source"; `roc build` was not re-measured.
* Ranking Node.roc/Check.roc's exhaustiveness blowup as a top-priority
  compiler fix although it is cache-hot in the Actions edit loop: it is the
  same mechanism, dominates cold checks, and is the cheapest fix.
* Treating the experimental toggles as *evidence of payoff and of semantic
  safety*, not as the fixes: SKIP_TAG_PROJECTION removes a feature whose value
  no test observes; SKIP_ABSENT_GROUND/SHARE_GROUND special-case zero-formal
  declarations where the real fixes should handle formals via substitution.
* The expected-shape projection finding (no observable effect in 433
  snapshots or the package) is reported rather than acted on: it may be
  load-bearing for untested programs (literal defaulting order inside tag
  payloads, where-dispatch ordering).
* The 2,300-branch match is declared immaterial on the basis of 0.14% of vars
  and ~0.4% of time; a compact literal-family representation remains a valid
  but low-yield idea.

## 13. Reproduction kit

All paths are on the analysis machine; binaries are ~350 MB each and live in
the analysis worktree's git-ignored `.tmp/`, so they may not outlive it — the
build commands and the patch reproduce them in ~12–15 min each.

| Artifact | Path |
|---|---|
| baseline compiler (parent's instrumentation only; semantics identical to the parent's compiler) | `/Users/rtfeldman/code/roc/.delta/worktrees/w0bxep5v818j/roc/.tmp/roc-profile-rf` |
| experimental compiler (all toggles; off by default = baseline semantics plus the `settled_reachable_vars` profile line) | `…/.tmp/roc-exp3-rf` (ReleaseFast), `…/.tmp/roc-exp3-debug` (Debug) |
| isolated cache dir, restored to baseline content (Actions entry 2,187,247,697 B) | `…/.tmp/roc-cache` ; Actions entry: `release-fast-e79b7f85/mod/8c/ad4b41de40376e83f5feee969cb78cba989f641fd63bae0addec84e40169d1` |
| raw logs and CPU samples | `…/.tmp/analysis-logs/` |
| experimental patch | `docs/actions-performance-analysis/compiler-experiment.patch` (apply to `src/check/Check.zig`, `src/check/exhaustive.zig`) |
| scripts | `docs/actions-performance-analysis/gen_nominal.py`, `gen_match.py`, `actions_stats.py`, `sample_inclusive.py`, `run_toggles.sh` |

Commands (always `-j2`):

```sh
# build (set XDG_CACHE_HOME under the worktree: the build step clears the Roc cache)
XDG_CACHE_HOME=$PWD/.tmp/xdg zig build roc -j2 -Doptimize=ReleaseFast -Dstrip=false

# whole package, every module built; per-module check/publish/vars on stderr
ROC_CACHE_DIR=… ROC_PROFILE_CACHE=1 roc check --no-cache -j2 package/main.roc

# app with only Actions evicted (the edit-Actions scenario)
rm $ROC_CACHE_DIR/release-fast-e79b7f85/mod/8c/ad4b41de40376e83f5feee969cb78cba989f641fd63bae0addec84e40169d1
ROC_PROFILE_CACHE=1 roc check --time --verbose -j2 examples/small/main.roc

# experimental semantics (any subset of toggles)
ROC_EXP_EXH_MEMO=1 ROC_EXP_EXH_SHARE_GROUND=1 ROC_EXP_SKIP_ABSENT_GROUND=1 \
ROC_EXP_SKIP_TAG_PROJECTION=1 ROC_EXP_PROJECT_OPEN=1 roc-exp3-rf check --no-cache -j2 package/main.roc

# CPU sample of a run
roc check … & sleep 0.5; sample $! 13 1 -mayDie -file out.txt; python3 sample_inclusive.py out.txt <thread-line> checkFileInternal

# static counts over Actions.roc
python3 docs/actions-performance-analysis/actions_stats.py package/Actions.roc
```

For before/after measurement of translator cleanups, compare
`CACHE_PROFILE Actions … check_ms / publish_ms / vars` and the Actions cache
entry size using the **baseline** binary; the `vars` figure is deterministic
and is the most sensitive indicator (expect ≈7,760 fewer vars per removed
constructor expression).
