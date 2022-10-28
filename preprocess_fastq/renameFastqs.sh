# I scp'd the files into fastqtemp
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/fastqtemp
echo renameFastqs.sh
# Made by Samir Ali.
# This script renames the fastqs obtatined from Rat Brain data.

for IDs in $(grep CFG /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/LiBo_RNAseq_annotation.txt | cut -f1 -d " ")
do
	sample=$(grep $IDs /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/LiBo_RNAseq_annotation.txt | cut -f2 -d " ")
	filename1=$(ls */${IDs}*_R1*gz)
	filename2=$(ls */${IDs}*_R2*gz)
	newfilename1=$(basename $filename1 | awk -v sample=$sample -v IDs=$IDs '{sub(IDs,sample); print}')
	newfilename2=$(basename $filename2 | awk -v sample=$sample -v IDs=$IDs '{sub(IDs,sample); print}')
	mv $filename1 $newfilename1
	mv $filename2 $newfilename2
done
wait
echo done
