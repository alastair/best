#!/bin/bash

pw=$(pwd)
if [ ! -d "$pw/data" ]; then
	mkdir "$pw/data"
fi

pushd $1
for f in $(ls |
	sed -e 's/ - .*//g' -e 's/ /+/g' |
	uniq ); do
		if [ ! -f "$pw/data/$f" ]; then
			wget -U "Best Songs" "http://ws.audioscrobbler.com/1.0/artist/$f/toptracks.xml" -O  "$pw/data/$f"
			sleep 2
		fi
	done
popd

echo Building best songs
(cd data ; ls ) | while read i
do 
	grep '<name>' "data/$i" | 
		head -n 2 | 
		while read song
		do 
			echo $i:$song
		done 
done | sed -e 's@</name>@@g' 	\
	-e 's@<name>@@g' 	\
	-e 's@+@ @g' 		\
	-e 's/&amp;/\&/g' >best.txt

