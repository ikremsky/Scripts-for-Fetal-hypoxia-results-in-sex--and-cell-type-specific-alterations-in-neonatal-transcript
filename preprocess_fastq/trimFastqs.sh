cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/fastq
echo trimFastqs.sh
# Made by Dr. Isaac Kremsky edited by Samir Ali.
# This script trims the fastq files for Rat Brain data!

for file in $(ls *gz | grep -e _R1 | grep -v trim)
do
	file2=$(echo $file | awk '{sub("_R1", "_R2"); print}')
	outFile=$(basename $file .fastq.gz).trim.fastq.gz
	outFile2=$(basename $file2 .fastq.gz).trim.fastq.gz
	summaryFile=$(basename $file .fastq.gz).txt
	trim_galore --paired $file $file2 &
	fastqc $file &
	fastqc $file2 &
done
wait
echo done
