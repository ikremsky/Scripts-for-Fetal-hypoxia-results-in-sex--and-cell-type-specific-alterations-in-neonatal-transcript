echo getDEgenes.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/
mkdir cufflinks

for file in $(ls bam/*.UM.sorted.bam | grep pooled )
do
	name=$(basename $file .UM.sorted.bam)
	cufflinks -G /data2/genomes/rn7/refSeqgenes_rn7.gtf $file -o cufflinks/$name &
done
wait

echo done
