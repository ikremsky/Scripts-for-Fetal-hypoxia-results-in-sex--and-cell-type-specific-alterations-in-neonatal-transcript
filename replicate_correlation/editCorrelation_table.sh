cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks/text_files/
echo editCorrelation_table.sh
for sample in A2B5 AC MG NR ODC
do
	for sex in M F
	do
		for treatment in Hypoxia Normoxia
		do
			type=${sample}_${sex}_${treatment}
			outFile=Correlation_${type}_table.txt
			listFile=${type}_Sample_List.txt
			grep $type Correlation_table.txt | awk -v OFS="\t" '{print $1,$2,$3,$4}' > $outFile
			awk '{print $2}' $outFile | sort -k1n,1 | uniq > $listFile
		done
	done
done
echo done
