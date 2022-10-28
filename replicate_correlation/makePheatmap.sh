echo makePheatmap.sh
mkdir /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/pheatmap
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/pheatmap
Dir=/home/samir/Rat_Brain
Dir2=/data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/text_files
for sample in A2B5 AC MG NR ODC
do
	for sex in M F
	do
		for treatment in Hypoxia Normoxia
                do
			Rscript ${Dir}/makePheatmap.R ${Dir2}/Correlation_${sample}_${sex}_${treatment}_table.txt ${Dir2}/${sample}_${sex}_${treatment}_Sample_List.txt ${sample}_${sex}_${treatment}
		done
	done
done
wait
montage -geometry 300x300 -tile 5x4 -density 300 *.png Correlation_heatmaps_montage.png
echo done
