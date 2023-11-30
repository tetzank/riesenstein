#!/bin/bash

#grades=(4 5 6A 6B 6C 7A 7B 7C 8A 8B)
grades=(4 5 6A 6A+ 6B 6B+ 6C 6C+ 7A 7A+ 7B 7B+ 7C 7C+ 8A 8A+ 8B 8B+)
width=$((${#grades[@]}*30 + 30))
base=120

echo "<svg width=\"$width\" height=\"$((base+30))\"
   version=\"1.1\"
   xmlns:xlink=\"http://www.w3.org/1999/xlink\"
   xmlns=\"http://www.w3.org/2000/svg\"
   xmlns:svg=\"http://www.w3.org/2000/svg\">

<text x=\"20\" y=\"$((base-95))\" text-anchor=\"end\">10</text>
<text x=\"20\" y=\"$((base-45))\" text-anchor=\"end\">5</text>
<path d=\"M30 $base v-115\" stroke=\"black\" fill=\"none\" stroke-width=\"1\"/>

<path d=\"M30 $base h$width\" stroke=\"black\" fill=\"none\" stroke-width=\"1\"/>
<path d=\"M30 $((base-50)) h$width\" stroke=\"black\" fill=\"none\" stroke-width=\"1\" stroke-dasharray=\"3\"/>
<path d=\"M30 $((base-100)) h$width\" stroke=\"black\" fill=\"none\" stroke-width=\"1\" stroke-dasharray=\"3\"/>"

x=45
for g in ${grades[@]}; do
	#c=$(grep -r title content/boulders/ | grep -c $g)
	c=$(grep -r title content/boulders/ | grep -c " $g[^\+]")
	((c *= 10))
	# plus symbol '+' must be escaped in URL, replace with '%2B'
	echo "<a href=\"./boulders/?grade=${g/\+/%2B}\">
	<path d=\"M$x $base h-7 v-$c h14 v$c z\" stroke=\"black\" fill=\"white\" stroke-width=\"1\" />
	<text x=\"$x\" y=\"$((base+20))\" text-anchor=\"middle\">$g</text>
</a>"
	((x += 30))
done
echo '</svg>'
