echo makeDiffHeatmap.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019
mkdir heatmaps
Dir=/home/samir/Rat_Brain/Enhancers

for file in $(ls cuffdiff/*_M/gene_exp.diff cuffdiff/*_F/gene_exp.diff)
do
	awk '{gsub("inf","3"); print}' $file > ${file}.mod
done
wait

##The line below makes female and male right next to each other.
Rscript ${Dir}/makeDiffHeatmap_MnFv2.R cuffdiff/A2B5_F/gene_exp.diff.mod cuffdiff/A2B5_M/gene_exp.diff.mod cuffdiff/AC_F/gene_exp.diff.mod cuffdiff/AC_M/gene_exp.diff.mod cuffdiff/MG_F/gene_exp.diff.mod cuffdiff/MG_M/gene_exp.diff.mod cuffdiff/NR_F/gene_exp.diff.mod cuffdiff/NR_M/gene_exp.diff.mod cuffdiff/ODC_F/gene_exp.diff.mod cuffdiff/ODC_M/gene_exp.diff.mod
mv *heatmap*png heatmaps
echo done
