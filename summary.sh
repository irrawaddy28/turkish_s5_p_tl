#!/bin/bash

[[ $# != 2 ]] && exit 1;

exp=$1  # this is the experiment directory
nbest=$2 # print nbest scores for each test case
tests="mono tri1 tri2b tri3b"
decodes="decode_test  decode_dev"
subsets="100 200 500 1000" 

echo "==== # Case: $exp ===="
for t in $tests
do
	echo "--$t--"
	for d in $decodes
	do
		for n in $subsets
		do		    
			for x in $exp/${t}${n}_*/${d}*; do [ -d $x ] && grep WER $x/wer_* | utils/best_wer.sh; done	
			echo " "		
		done
		echo -e "\n"
	done
	echo -e "\n"	
done

echo "----summary of top $nbest scores ----"
for t in $tests
do
	echo "--$t--"
	for d in $decodes
	do
		for n in $subsets
		do
			for x in $exp/${t}${n}_*/${d}*; do [ -d $x ] && grep WER $x/wer_* | utils/best_wer.sh; done | sort -n -k2|head -n $nbest| awk '{print $0, "*"}'
			echo "----"
		done
		echo -e "\n"
	done
	#echo -e "\n"
done

echo "==================="
