# Guidelines for generating efficient, maintainable Roc

Use these guidelines when translating or regenerating large bodies of code.
The goal is less redundant work for the compiler and the resulting program,
not merely fewer lines.

**Generate the operations the program means, not a line-for-line transcript of
the source language's implementation details.** Put improvements in the generator
so regeneration preserves them.

## 1. Build a concrete payload, then wrap it once

When the variant is known, work with its concrete payload. Wrap it at a boundary
that needs the nominal value, rather than repeatedly wrapping, extracting, and
updating it. Intermediate immutable records are fine; one giant expression is
not required. Unknown variants still need checked dispatch, never unsafe casts.

**Why:** redundant conversions add type relationships, specialization work,
dispatch, and intermediate values. Backend optimization cannot recover time
already spent checking and lowering unnecessary source operations.

## 2. Combine updates only when their ordering is immaterial

Adjacent independent writes to different fields can become one record update.
Preserve intervening reads, alias writebacks, control flow, and the order and
number of failing or effectful operations. Repeated writes need explicit
treatment, not automatic removal.

**Why:** source pointers and Roc values have different update semantics.
Intermediate state, errors, and alias visibility are observable behavior.
Safe local batching does not prove a whole-function transformation safe.

## 3. Share repeated algorithms through explicitly typed helpers

Emit a common body once when rules differ only in values. Pass the differences
as typed parameters and retain source-rule labels at dispatch sites. Establish
equivalence from semantic structure, not textual resemblance; preserve binding,
literal types, ownership, and control flow.

**Why:** duplicated bodies repeat work throughout compilation. Typed templates
avoid confusing ordinary values with pattern labels, structural offsets, or
text that merely looks like a parameter.

## 4. Keep helper interfaces as precise as their job

Use the concrete argument and result types already known to the generator.
Preserve necessary polymorphism, but do not introduce a generic framework solely
to maximize textual reuse or weaken type safety to reduce size.

**Why:** source sharing does not guarantee compiler sharing. Generic helpers can
still require many specializations; precise interfaces make reuse and diagnostics
more predictable.

## 5. Express immutable dataflow directly

After accounting for aliases and inout operations, use immutable bindings for
locals that never change. Remove unnecessary parameter copies, but retain copies
that capture mutable snapshots and initializers whose evaluation matters.

**Why:** accidental mutation inherited from another language complicates reasoning
and later transformations. This is primarily a clarity improvement, not a
guaranteed compilation speedup.

## 6. Measure repeated-value sharing and dispatch

Compare inline expressions, shared constants, and small helpers when large or
recursive types are involved. Keep straightforward dispatch unless measurement
shows it is costly; a large `match` does not inherently need indirect machinery.

**Why:** textual size is a poor proxy for semantic cost. Sharing `Node.null`
reduced checking work but worsened later lowering in the measured compiler;
the large numeric dispatcher was comparatively cheap. These are compiler-specific
tradeoffs, not permanent rules against constants or large matches.

## 7. Transform semantic structure and preserve generator state

Prefer the parsed source AST or a typed generator IR for batching, helper
extraction, and alias handling; render afterward. Retain every returned state
update, including names, parameters, imports, and obligations. Text-level cleanup
must distinguish identifiers, literal strings, and interpolation expressions.

**Why:** discarded registrations or textual substitution can silently capture
variables and change behavior, even when the generated code still compiles.

## 8. Make regeneration deterministic and preserve provenance

Use stable ordering and names; retain source-rule labels, versions, and licenses.
Exclude timestamps and machine-specific paths. Change the generator, regenerate,
and verify that a second run produces identical bytes.

**Why:** stable output improves review, reproducibility, and cache reuse.
Unrelated churn hides regressions and needlessly invalidates caches.

## 9. Verify equivalence, including failures

Test transformation opportunities and barriers, compare original and regenerated
behavior on broad inputs, and retain integration coverage. For parsers, compare
complete trees and errors with their locations, not just acceptance.

**Why:** successful compilation and happy-path tests do not establish equivalence.
Aliasing, diagnostic behavior, and evaluation order need explicit coverage.

## 10. Measure the whole compilation pipeline

Compare cold checks, unchanged and app-only warm builds, lowering, compile-time
execution, backend work, memory, and artifact size. Keep compiler, backend,
workers, inputs, and cache conditions consistent; avoid competing heavy runs.

**Why:** an optimization can move cost between phases, and caches can hide it.
Fewer lines or checker variables are evidence, not acceptance criteria. Document
measurement limitations and rejected alternatives.

## Handoff checklist

- [ ] Improvements survive deterministic regeneration and preserve provenance.
- [ ] Type safety, alias semantics, and evaluation order/count are unchanged.
- [ ] Payload construction, typed sharing, and immutable dataflow avoid redundancy.
- [ ] Names, strings/interpolation, and generator-state updates remain correct.
- [ ] Transformation-boundary, differential, and integration tests pass.
- [ ] Cold/warm measurements support claims; compiler-specific tradeoffs are documented.

See [the refactor report](actions-refactor-report.md),
[validation and measurements](actions-refactor-validation.md), and
[the original compiler analysis](actions-performance-analysis.md) for evidence.
