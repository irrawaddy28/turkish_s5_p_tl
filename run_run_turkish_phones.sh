#! /bin/bash
# 1 = data prep
# 2 = feat prep
# 3 = monophone 
# 4 = triphone (deltas and deltas+deltas) 
# 5 = LDA + MLLT 
# 6 = LDA+MLLT+SAT, decode
# 7 = delta+delta-delta + MPE
# 8 = LDA + MLLT + MPE
# 9 = Karel's nnet

# bash run_turkish_phones.sh 1  "all"
# bash run_turkish_phones.sh 2  "all"

: << 'COMMENT'
rhos="0.00001 0.00002 0.00004 0.00006 0.00008 0.0001 0.0002 0.0004 0.0006 0.0008 0.001 0.002 0.004 0.006 0.008 0.01 0.02 0.04"
tests="3 4 5 6"
subsets="100 200 500 1000" #"200 500 1000"

# train with a subset of $n utts from training set
for n in $subsets
do
	for r in $rhos
	do
		for t in $tests
		do
			bash run_turkish_phones.sh --l2rho "$r" $t $n
		done
	done
done
COMMENT

bash run_turkish_phones.sh --l2rho "0.001" 9 100
bash run_turkish_phones.sh --l2rho "0.0006" 9 200
bash run_turkish_phones.sh --l2rho "0.0002" 9 500
bash run_turkish_phones.sh --l2rho "0.00002" 9 1000
