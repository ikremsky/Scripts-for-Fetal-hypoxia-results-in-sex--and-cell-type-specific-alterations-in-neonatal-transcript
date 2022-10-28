echo makefisherPvalTable.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles

echo Sample"\t"Pval > PvalTable.txt
for file in $(ls *_F_*/summary.txt)
do
	awk -v OFS="\t" 'NR>1{print $1,$NF}' $file >> PvalTable.txt
done
echo done
