echo dofishertest_motifs.sh
startDir=/data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles
Dir=/home/samir/Rat_Brain/Enhancers
cd $startDir
Region="distal"
rm -r *_motifs

process ()
{
cd $startDir
motifctrlN=$(cat ${startDir}/${type}_rn7_fimo_DEgenes.forigv.bed | wc -l)
ctrltotalN=$(cat ${startDir}/${type}_rn7_fimo_expressed.forigv.bed | wc -l)

cut -f4 ${startDir}/expressedgenes_${type}.bed | sort -b | uniq > expressedGenes_${type}.txt

region=$Region
rm ${type}_motifs/summary_${region}.txt
mkdir ${type}_motifs
cd ${type}_motifs
cut -f4 ${startDir}/${type}_rn7_fimo_DEgenes.forigv.bed | awk '{print toupper($1)}' | sort -b | uniq > ids
for motif in $(join -i ids ${startDir}/expressedGenes_${type}.txt | sort -b | uniq)
do
	rm -r individualTFs
	mkdir individualTFs
	motifN=$(awk -v motif=$motif '{if(toupper($4) == toupper(motif)) print $1,$2,$3}' ${startDir}/${type}_rn7_fimo_DEgenes.forigv.bed | sort -k1,1 -k2,2n | uniq | wc -l)
	totalN=$(awk -v motif=$motif '{if(toupper($4) == toupper(motif)) print $1,$2,$3}' ${startDir}/${type}_rn7_fimo_expressed.forigv.bed | sort -k1,1 -k2,2n | uniq | wc -l)
	echo $motifN $totalN > ${motif}.matrix
	echo $motifctrlN $ctrltotalN >> ${motif}.matrix
	echo $motif
	cat ${motif}.matrix
	R --vanilla --args ${motif}.matrix $(echo $motif) < /home/samir/Rat_Brain/Enhancers/fisherTest.R
done
awk 'BEGIN{OFS="\t"}{if(NR == 1 || NR%2 == 0 ) print}' summary.txt > temp; mv temp summary_${region}.txt
R --vanilla --args summary_${region}.txt ${type}_${region} Ctrl $type < /home/samir/Rat_Brain/Enhancers/getTables.R
rm *.matrix
cd $startDir

	awk -v OFS="\t" '{if(NR>1 && $5 < .001 && $3 > $4) print $1,$2,$NF}' ${type}_motifs/summary_${region}.txt | awk 'NR<34' > ${type}_motifs/summary_${region}_final1.txt
#	awk -v OFS="\t" '{if(NR>1 && $5 < .001 && $3 > $4) print $1,$2,$NF}' ${type}_motifs/summary_${region}.txt | awk 'NR>33 && NR<67' > ${type}_motifs/summary_${region}_final2.txt
	R --vanilla --args ${type}_motifs/summary_${region}_final1.txt ${type} < /home/samir/Rat_Brain/Enhancers/getBarPlots/getBarPlots_IAPs1.R
#	R --vanilla --args ${type}_motifs/summary_${region}_final2.txt ${region} < /home/samir/Rat_Brain/Enhancers/getBarPlots/getBarPlots_IAPs2.R
R --vanilla < ~/NEC/getBarPlots/getBarPlotLegend.R
}
for sample in A2B5 NR ODC MG
do
        for sex in M F
        do
		type=${sample}_${sex}
		process &
		sort -k4b,4 ${startDir}/${type}_rn7_fimo_DEgenes.forigv.bed
	done
done
echo done
