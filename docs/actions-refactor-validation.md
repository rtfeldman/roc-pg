# Actions refactor: final validation and paired measurements

## Outcome

The final generator preserves parser behavior and improves cold checking and
warm application builds with the existing compiler. One feature was rejected:
shared `Node.null` references in actions increased warm builds from about 31
seconds to 89 seconds. Actions now emit inline `Null`; record defaults retain
their shared constant. A null factory offered no advantage over inline null.

Independent-write batching, immutable-local/copy elision, exact typed-body
sharing, and I64 parameters remain. Saved conditional aliases and list
metadata remain outside parameterization. No compiler optimization,
experimental compiler flag, or compiler rebuild was used.

## Environment

```sh
ROOT=/Users/rtfeldman/code/roc-pg/.delta/worktrees/9g3vmbn2qc0m/roc-pg
PARENT=/Users/rtfeldman/code/roc-pg/.delta/worktrees/w64q0023902x/roc-pg
ROC=/Users/rtfeldman/code/roc/.delta/worktrees/w0bxep5v818j/roc/.tmp/roc-profile-rf
cd "$ROOT"
export ROC_CACHE_DIR="$ROOT/local/cache"
```

Compiler: `release-fast-e79b7f85`, SHA-256
`0cdc72d4240438ef29c6b7c2f53a1880dad3ade8b155bff242bf17074c32db0e`.
The isolated disk checkout was verified to contain the latest speed adapter,
unique executable paths, and retained-expression guard/list-read fixes.
Upstream PostgreSQL sources/compiler were read from supplied locations; all
caches, logs, executables, and the database were private to this worktree.

The baseline copies the current package, replacing only Actions/Node with the
supplied originals. Its complete `examples/small` copy preserves relative
imports under `local/baseline/examples/small`. Baseline Actions SHA-256:
`cdd2d59be288ecce0cbadebd0d703f575aae9bdc359a6ceb4ad697ef89b79120`.

All commands used two compiler jobs. Paired runs used identical compiler,
backend and flags; the parent ran no heavy builds. This is a small sequential
measurement series, not a statistical benchmark. Wall time and RSS are
`/usr/bin/time -l` real seconds and maximum resident bytes. Phase times are
compiler `--timings` output. Logs remain under `local/validation`.

## Final correctness

| Check | Result |
| --- | --- |
| TranslateTests | 28 passed, including inline-null regression |
| RuleTemplates | 36 passed |
| Generator | 2,279 actions, 1,051 bodies, 51 helpers, 222 node types, zero problems |
| Idempotence | Repeated generation SHA-identical |
| Package | All 383 tests passed |
| Corpus | All 40,107 inputs byte-identical to baseline output |
| Examples/test checks | All eight passed; 60 warnings only in downloaded basic-webserver |
| Negative compilation | All 21 queries rejected with expected messages |
| Integration | Passed, including MD5/SCRAM and iteration-count cases |
| Typed integration | All five groups passed |
| Concurrency | 300 requests, 40 at once, 278 ms (sequential minimum 6,000 ms) |
| Complete harness | `all tests passed` |

```sh
"$ROC" test tools/TranslateTests.roc --jobs=2
"$ROC" test tools/RuleTemplates.roc --jobs=2
"$ROC" build tools/actions.roc --opt=dev --jobs=2 \
  --output="$ROOT/local/validation/generator-final"
local/validation/generator-final
shasum -a 256 package/Actions.roc package/Node.roc tests/NodeJson.roc
local/validation/generator-final
shasum -a 256 package/Actions.roc package/Node.roc tests/NodeJson.roc
"$ROC" build tests/parser_corpus.roc --opt=dev --jobs=2 \
  --output="$ROOT/local/validation/parser-final"
local/validation/parser-final "$PARENT/.ctfe-investigation/parser-corpus.jsonl" \
  >local/validation/parser-final-results.txt
cmp "$PARENT/.ctfe-investigation/parser-results-before.txt" \
  local/validation/parser-final-results.txt

export ROC_BASELINE="$ROC" ROC_PG_ROOT="$ROOT" ROC_TEST_OPT=speed
cp tools/test-cli.sh local/test-bin/roc
chmod +x local/test-bin/roc
export PATH="$ROOT/local/test-bin:$PARENT/local/postgres-install/bin:$PATH"
"$ROC" build tests.roc --opt=dev --jobs=2 \
  --output="$ROOT/local/validation/harness-1"
local/validation/harness-1
```

The generator was rebuilt as `generator-final-typed` after replacing an
intermediate default-value string comparison with a CType match. Generated
hashes stayed identical. The last added translator test also leaves package
output unchanged. No existing test was weakened.

Compare corpus bytes, not Python `splitlines`: output has 40,108 LF-delimited
lines for 40,107 inputs. Baseline acceptance totals were 39,550 accepted and
557 rejected. Exact comparison covers complete trees and diagnostics/locations.

The included `tools/parser_corpus.py` reproduction helper was also verified
with pinned sqlparse 0.5.3: it regenerates 40,107 distinct inputs from 235 files,
with every SQL string identical to the original corpus in the same order.
Its tested SHA-256 is
`7ea0df25cc32399f3a4b2eec7301485a85e2e8b18acbf075542d8361a746b297`.

Integration executables used LLVM speed. The parent had already reproduced
dev-backend MD5/SCRAM heap corruption on original Actions/Node; that supplied
control was not repeated here. The dev harness/corpus helpers ran successfully.
PostgreSQL used only this worktree's `.pg-test-db` on 5499 and was stopped;
the unrelated 5432 server was untouched.

An initial 200-second terminal limit interrupted the harness during checks;
the unbounded complete rerun succeeded, as did another full run after inline
null was selected. One factory-generator launch was killed by macOS and
succeeded on retry. Experimental text substitution initially also replaced
the prefix of `Node.null_test_*`, causing type errors; those invalid runs
were discarded. The final generator has no text-substitution pass.

## Cold package check, cache disabled

```sh
/usr/bin/time -l "$ROC" check local/baseline/package/main.roc \
  --no-cache --jobs=2 --timings
/usr/bin/time -l "$ROC" check package/main.roc \
  --no-cache --jobs=2 --timings
```

| Metric | Original | Final |
| --- | ---: | ---: |
| Wall time | 61.43 s | 43.02 s |
| Maximum RSS | 8,863,465,472 | 5,336,760,320 |
| Type Checking phase | 61.403 s | 43.036 s |
| Shared Monotype Lowering | 16.960 s | 9.706 s |

**30% less wall time, 40% less RSS.** Both checks succeeded without diagnostics.
Cache publication is excluded here and measured separately below.

## Warm native small application

First builds populated caches. The final paired commands verify that both
read 61 cached modules, with zero built/canonicalized/stored:

```sh
/usr/bin/time -l "$ROC" build local/baseline/examples/small/main.roc \
  --opt=dev --jobs=2 --timings --verbose \
  --output="$ROOT/local/validation/before-final-small"
/usr/bin/time -l "$ROC" build examples/small/main.roc \
  --opt=dev --jobs=2 --timings --verbose \
  --output="$ROOT/local/validation/final-final-small"
```

| Metric | Original | Final |
| --- | ---: | ---: |
| Wall time | 32.07 s | 19.34 s |
| Maximum RSS | 11,010,916,352 | 6,336,577,536 |
| Type Checking phase | 31.872 s | 18.566 s |
| Shared Monotype Lowering | 26.612 s | 15.422 s |
| Cached modules | 61/61 | 61/61 |

**40% less wall time, 42% less RSS.** Earlier warm runs were 31.10 s original
and 17.58 s inline-null; another original run was 29.77 s. The Type Checking
label includes shared lowering/compile-time work, not just type inference.

### Null controls

| Warm variant | Wall | Shared Monotype | Maximum RSS |
| --- | ---: | ---: | ---: |
| Original | 31.10 s | 26.915 s | 10,852,630,528 |
| Shared constant in actions | 89.09 s | 87.002 s | 5,999,427,584 |
| Inline null in actions | 17.58 s | 15.367 s | 6,268,026,880 |
| Null factory in actions | 17.64 s | 15.449 s | 6,275,481,600 |

The refactor controls changed only action null emission and, for the factory,
added a monomorphic `{} -> Node` helper. Defaults retained the shared constant.
Inline/factory are tied; inline is simpler. The shared constant's attractive
cold check (43.31 s) and memory results did not justify its warm regression.

## Actions checking, publication, and cache size

Fresh private caches force checked-module misses:

```sh
ROC_PROFILE_CACHE=1 ROC_CACHE_DIR="$ROOT/local/profile-before-cache-2" \
  /usr/bin/time -l "$ROC" check local/baseline/package/main.roc \
  --jobs=2 --timings --verbose
ROC_PROFILE_CACHE=1 ROC_CACHE_DIR="$ROOT/local/profile-cache" \
  /usr/bin/time -l "$ROC" check package/main.roc \
  --jobs=2 --timings --verbose
```

Both report 34 modules built, zero cached. Profile records appear on checking
and serialization, not already-cached warm builds. Times below include logging
overhead and are separate from the headline uninstrumented comparisons.

| Actions metric | Original | Final |
| --- | ---: | ---: |
| Variables before check | 2,585 | 2,576 |
| Variables after check | 40,091,111 | 14,887,510 |
| Instrumented check | 8,344 ms | 2,925 ms |
| Instrumented publication | 5,576 ms | 2,019 ms |
| Logged serialized env end | 2,120,557,292 | 790,144,132 |
| ModuleEnv envelope bytes | 2,120,559,860 | 790,146,700 |
| Checked artifact bytes | 66,687,756 | 41,670,248 |
| Complete cache file bytes | 2,187,247,713 | 831,817,045 |

**62.9% fewer variables; 62.0% smaller cache entry.** File lengths were read
from fresh `release-fast-e79b7f85/mod` entries. The 97-byte
`roc-mod-cache-v11` header ends with little-endian U64 envelope/artifact
lengths; these plus 97 equal file length. The earlier logged `env_end`
precedes final envelope bookkeeping. Tiny differences from older measurements
can reflect serialized path/context metadata.

## Final generated identity

| Actions statistic | Original | Final |
| --- | ---: | ---: |
| Lines | 30,381 | 18,541 |
| Bytes | 1,156,582 | 764,639 |
| Rule definitions | 2,279 | 1,051 |
| Qualified payload constructors (`Node.X(`) | 4,732 | 1,761 |

SHA-256:

```text
d04e9915ab6971f52932a088202cf5500781855ed4c689f88ee22740ea2536c8  package/Actions.roc
f1bf21d8ec43fe8d5d4a0a049d77caad34f6579c0eac53fc48e9a734369f0603  package/Node.roc
009918814d1f700d311f09fc6444e0a7b925f5eefc963a0d7a18d97679165acf  tests/NodeJson.roc
```

Grammar was not regenerated. Large logs and caches are local, not source
changes. No PR, commit, compiler change, or experimental compiler patch was
made during this validation.
Temporary executable outputs were removed after validation; `pg_ctl status`
confirmed no test server was running.
