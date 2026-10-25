#!/bin/bash
# Packs the raw results of a comparison into the runs.tar.xz of a directory of results, as the
# directories of results/ have them: the .json files that the compare scripts write, but for the
# comparisons in pairs (.stats.json), which scripts/paired-stats.py makes from the raw results
# again. It copies environment.txt, which notes the versions, next to the archive, and leaves the
# tables (.md) out, as the write-up has what they show:
#
#     scripts/pack-results.sh $WORK/batched-sends-results-ac6e6fa results/<date>-<what>-<machine>
#
# To get the raw results back, and a comparison in pairs of them:
#
#     mkdir runs && tar -xJf results/<date>-<what>-<machine>/runs.tar.xz -C runs
#     scripts/paired-stats.py runs/calls.json --baseline baseline --candidate batched

set -euo pipefail

if [ $# -ne 2 ]; then
    echo "usage: $0 SOURCE DEST" >&2
    exit 1
fi
src=$1
dest=$2

mkdir -p "$dest"
if [ -f "$src/environment.txt" ] && ! [ "$src/environment.txt" -ef "$dest/environment.txt" ]; then
    cp "$src/environment.txt" "$dest/"
fi
# The same raw results make the same archive: the files go in by name, with neither owners nor
# times of their own.
(
    cd "$src"
    find . -type f -name '*.json' ! -name '*.stats.json' ! -path './stats/*' -printf '%P\0' |
        LC_ALL=C sort -z |
        tar --null --no-recursion --owner=0 --group=0 --numeric-owner --mode=644 --mtime=@0 \
            -cf - -T -
) | xz -9 -T1 > "$dest/runs.tar.xz"
