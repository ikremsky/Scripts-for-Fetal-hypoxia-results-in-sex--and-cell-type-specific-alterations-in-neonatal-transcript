echo doPCA.sh
mkdir /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/PCA
echo genes > geneTable.txt
awk '{if(NR > 1) print}' /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/A2B5_F_Normoxia.pooled/genes.fpkm_tracking | cut -f1 | sort -b >> geneTable.txt
lastType="x"
for folder in $(ls /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks | grep -v png | grep -v pool | grep -v expressed | grep -v temp | grep -v cufflinks| grep -v text_files | grep -v pheatmap | grep -v heatmaps)
do
#	echo $folder
	sample=$folder
#	echo $sample
	file=$(ls /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/${folder}/genes.fpkm_tracking)
	echo $sample | awk '{sub("_pooled", ""); print}' > temp
	awk '{if(NR > 1) print}' $file | sort -k1b,1 | cut -f10 >> temp
	paste geneTable.txt temp > temp2; mv temp2 geneTable.txt
#	echo $sample
done
# This command below makes SF1E with averaged points
#R --vanilla < PCAvarcolv2.R

x=""
for celltype in NR AC MG ODC A2B5
do
	x=$(echo $x" "${celltype}_M_Normoxia ${celltype}_F_Normoxia ${celltype}_M_Hypoxia ${celltype}_F_Hypoxia)
	echo $x
	Rscript Edited_PCA/PCA.R ${celltype} ${celltype}_M_Normoxia ${celltype}_F_Normoxia ${celltype}_M_Hypoxia ${celltype}_F_Hypoxia &
done
wait
#Rscript Edited_PCA/PCA_All_Reps.R ${celltype} $x
mv *png /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/PCA
