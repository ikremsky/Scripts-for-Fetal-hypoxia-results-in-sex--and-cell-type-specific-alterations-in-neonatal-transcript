echo getBedFiles_RNAseq.sh 
mkdir bed
getFPKM ()
{
	bamToBed -split -i $file | grep -v random > bed/$(basename $file .bam).split.bed &
	bamToBed -i $file | grep -v random >  bed/$(basename $file .bam).bed &
	wait
	wc -l bed/$(basename $file .bam).bed | awk '{sub("bed/", ""); print}' >> bed/readCounts
	rm bed/$(basename $file .bam).bed
}

for file in $(ls /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/bam/*.UM.sorted.bam | grep pool)
do
	getFPKM &
done
wait
echo done
