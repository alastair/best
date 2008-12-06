
./song2m3u "$1" best.txt >best.m3u 2>best.err

sed -e '/Not found/!d' -e 's/: Not found.*//' < best.err >missing
