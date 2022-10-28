echo genes > geneTable.txt
awk '{if(NR > 1) print}' /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/A2B5_F_Normoxia.pooled/genes.fpkm_tracking | cut -f1 | sort -b > geneTable.txt
lastType="x"
for folder in $(ls /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks | grep -v png | grep -v pool | grep -v expressed | grep -v temp | grep -v cufflinks| grep -v text_files | grep -v pheatmap)
do
	echo $folder
	sample=$folder
	echo $sample
	file=$(ls /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/${folder}/genes.fpkm_tracking)
	echo $sample | awk '{sub("_pooled", ""); print}' > temp
	awk '{if(NR > 1) print}' $file | sort -k1b,1 | cut -f10 >> temp
	paste geneTable.txt temp > temp2; mv temp2 geneTable.txt
	echo $sample
done
#R --vanilla < PCA.R
#R --vanilla < PCA_AC.R
#R --vanilla < PCA_MG.R
#R --vanilla < PCA_NR.R
sudo R --vanilla < PCA_ODC.R
#R --vanilla < PCA_A2B5.R
