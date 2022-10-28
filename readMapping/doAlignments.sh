echo doAlignments.sh
# Script made by Dr. Isaac Kremsky edited by Samir Ali.
# This script runs tophat2 to allign the 90 pairs of RNA-seq Rat Brain trimmed fastqs.
# Did mkdir tophat2 manually in the /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019 directory
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/tophat2

for file in $(ls ../fastq/*fq.gz | grep _R1 | grep -e A2B5 -e AC -e MG -e NR -e ODC | grep val)
do
        pair2=$(echo $file | awk '{gsub("_R1", "_R2"); gsub("val_1", "val_2"); print}')
        outName=$(basename $file .fq.gz | awk '{gsub("_R1", ""); gsub("_val", ""); print}')
	tophat2 -p 4 --no-mixed --no-discordant -o $outName -G /data2/genomes/rn7/refSeqgenes_rn7.gtf /data2/genomes/rn7/rn7 $file $pair2 &
	while [ $(ps -a | wc -l) -gt 75 ]
	do
		sleep 300
	done
done
wait
echo done
