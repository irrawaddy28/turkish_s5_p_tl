# turkish settings
turkish=/media/data/workspace/work/kaldi/egs/turkish/s5_p_v2_test


# timit settings
timit=/media/data/workspace/work/kaldi/egs/timit/s5wb
sdata=$timit/data/train/split30
echo "split data = $sdata"
# get some features
apply-cmvn --utt2spk=ark:$sdata/1/utt2spk scp:$sdata/1/cmvn.scp scp:$sdata/1/feats.scp ark:- | add-deltas ark:- ark:- | subset-feats --n=1 ark:- ark,t:add-deltas_split30_job1_1.txt

gmm-acc-stats-ali  --binary=false  ${turkish}/foo/mono/1.mdl "ark,t:${turkish}/foo/mono/timit/add-deltas_split30_job1_1.txt"   "ark,t:${turkish}/foo/mono/timit/ali.2.1.convert.txt"  ${turkish}/foo/mono/timit/1.1.convert.acc > 1.1.convert.acc.log

gmm-sum-accs --binary=false ${turkish}/foo/mono/timit/sum.convert.acc ${turkish}/foo/mono/timit/1.1.convert.acc ${turkish}/foo/mono/timit/1.1.convert.acc

gmm-scale-accs --binary=false 0.1 ${turkish}/foo/mono/timit/sum.convert.acc ${turkish}/foo/mono/timit/scaled.convert.acc


gmm-est --write-occs=${turkish}/foo/mono/2.occs --mix-up=117 --power=0.25 ${turkish}/foo/mono/1.mdl ${turkish}/foo/mono/timit/sum.convert.acc ${turkish}/foo/mono/2.mdl
