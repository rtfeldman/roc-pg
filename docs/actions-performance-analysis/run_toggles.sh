#!/bin/sh
# Usage: run_toggles.sh LABEL [ENV=1 ...]  -- checks the package with --no-cache -j2
ROC=${ROC:?set ROC to the compiler binary}
: "${ROC_CACHE_DIR:?set ROC_CACHE_DIR to an isolated cache dir}"
label=$1; shift
out=/tmp/roc-toggle-$label.log
env ROC_PROFILE_CACHE=1 "$@" /usr/bin/time -l $ROC check --no-cache -j2 package/main.roc > $out 2>&1
echo "== $label ($*)"
grep -E "CACHE_PROFILE (Node|Actions|Check|Catalog|Rt) (setup|publish|settled)|No errors|rror|maximum resident|real" $out | grep -v "^CACHE_OPEN"
