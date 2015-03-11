#! /bin/bash

# 1 = data prep
# 2 = feat prep
# 3 = monophone 
# 4 = triphone (deltas and deltas+deltas) 
# 5 = LDA + MLLT 
# 6 = LDA+MLLT+SAT, decode
# 7 = Karel's nnet

bash run_turkish_phones.sh 1  "all"
bash run_turkish_phones.sh 2  "all"

rhos="0.01 0.02 0.04 0.1 0.2 0.4 0.6 0.8 1"
tests="3 4"
subsets="500" #"200 500 1000"
# train with the full training set
#for i in $tests
#do
#	bash run_turkish_words.sh $i 
#done

# train with a subset of $n utts from training set
for n in $subsets
do
	for r in $rhos
	do
		for t in $tests
		do
			bash run_turkish_words.sh --l2rho "$r" $t $n
		done
	done
done

