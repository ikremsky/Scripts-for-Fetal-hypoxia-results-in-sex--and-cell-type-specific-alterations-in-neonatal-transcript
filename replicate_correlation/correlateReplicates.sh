echo correlateReplicates.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cufflinks
mkdir text_files
rm text_files/*txt
Dir=/home/samir/Rat_Brain
for cell in $(ls | grep -v png | grep -v expressed | grep "_" | cut -f1 -d"_" | grep -v temp | grep -e A2B5 -e AC -e MG -e NR -e ODC | sort | uniq)
do
	for sex in M F
	do
		for treatment in Hypoxia Normoxia
		do
			type=${cell}_${sex}_${treatment}
			indices=$(ls -d ${type}_* | cut -f4 -d"_" | grep -v RNAseq | sort -n | uniq)
			k=0
			for i in $indices
			do
				fpkmFile1=$(ls ${type}*_${i}_*/genes.fpkm_tracking)
				awk 'NR > 1' $fpkmFile1 | cut -f1,10 | sort -k1,1 | cut -f2 > temp1
				for j in $indices
				do
					if [ $i -gt 0 ];
					then
						fpkmFile2=$(ls ${type}*_${j}_*/genes.fpkm_tracking)
						awk 'NR > 1' $fpkmFile2 | cut -f1,10 | sort -k1,1 | cut -f2 > temp2
						paste temp1 temp2 | awk '$1 > 1 || $2 > 1' > ${type}.expressed
						wc -l ${type}.expressed
						echo $type
						Rscript ${Dir}/getScatterPlots.R ${type}_${i}_$j ${type}.expressed $i $j
					fi
				done
			done
		done
	done
done
rm temp*
mv *txt text_files
sh ${Dir}/editCorrelation_table.sh
echo done
