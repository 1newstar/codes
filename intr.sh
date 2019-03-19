#!/bin/bash

 FILE="/proc/interrupts"

 output=$(awk 'NR==1 {
 core_count = NF
 print core_count
 next
}
#/eno/ {
/'"${1}"'/ {
 for (i = 2; i <= 2+core_count; i++)
 totals[i-2] += $i
}

END {
 for (i = 0; i < core_count; i++)
 printf("%d\n", totals[i])
}
' $FILE)

core_count=$(echo $output | cut -d' ' -f1)

output=$(echo $output | sed 's/^[0-9]*//')

totals=(${output// / })

#echo CC: $core_count total0 ${totals[0]} total1 ${totals[1]}
#echo CC: $core_count total0 ${totals[0]} total1 ${totals[1]} total2 ${totals[2]} total3 ${totals[3]}

echo CC: $core_count
for ((i = 0; i < $core_count; i++))
do
 echo total$i ${totals[i]}
done
