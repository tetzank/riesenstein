#!/bin/bash

tf=`mktemp`
sorted=`mktemp`

for f in content/boulders/*.html; do
	weight=$(grep '^weight' "$f" | cut -f2 -d' ')
	echo "$f $weight" >>$tf
done

sort -n -k2,2 $tf | awk '
BEGIN{
	group = 100;
}

{
	if($2 > group) {
		printf("--%i\n", group);
		group += 100;
	}
	print $1
}
' >$sorted

vim $sorted

awk '
BEGIN{
	group = 0;
	idx = 1;
}

/^--/{
	group += 100;
	idx = 1;
}
/^content/{
	printf("%s=%i\n", $1, idx + group);
	idx++;
}
' $sorted >$tf

for line in `cat $tf`; do
	fname=${line%=*}
	weight=${line#*=}
	sed -i "s/weight: [1-9][0-9]*$/weight: $weight/" "$fname"
done

rm $tf $sorted
