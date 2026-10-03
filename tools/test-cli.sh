#!/bin/sh
# Optional adapter for tests.roc with a compiler whose dev `run` watches files.
# Copy this to local/test-bin/roc and put that directory first on PATH.
# The actual compiler is supplied explicitly; each program is built and run once.
set -eu
: "${ROC_BASELINE:?set the compiler path}"
: "${ROC_PG_ROOT:?set the roc-pg worktree path}"
opt=${ROC_TEST_OPT:-speed}
command=$1
shift
case "$command" in
    build)
        exec "$ROC_BASELINE" build --jobs=2 "--opt=$opt" "$@"
        ;;
    check|test)
        exec "$ROC_BASELINE" "$command" --jobs=2 "$@"
        ;;
    *.roc)
        mkdir -p "$ROC_PG_ROOT/local/test-runs"
        # A fresh inode also avoids macOS retaining a code-signature verdict
        # for a previously executed binary overwritten at the same path.
        output=$(mktemp "$ROC_PG_ROOT/local/test-runs/${command##*/}.XXXXXX")
        trap 'rm -f "$output"' EXIT HUP INT TERM
        "$ROC_BASELINE" build --jobs=2 "--opt=$opt" "$command" --output="$output"
        "$output" "$@"
        ;;
    *)
        exec "$ROC_BASELINE" "$command" "$@"
        ;;
esac
