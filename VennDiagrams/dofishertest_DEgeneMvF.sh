echo dofishertest_motifs.sh
startDir=/data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles
Dir2=/data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cuffdiff
Dir=/home/samir/Rat_Brain/Enhancers
cd $startDir
Region="distal"
rm -r *_motifs

process ()
{
cd $startDir
motifctrlN=$(awk 'NR>1{print}' ${Dir2}/final/${sample}_Mgene_exp.diff.significant.txt | wc -l)
ctrltotalN=$(awk 'NR>1{print}' ${Dir2}/${type}/gene_exp.diff | wc -l)

region=$Region
mkdir ${type}_motifs
cd ${type}_motifs
for motif in $sample
do
	rm -r individualTFs
	mkdir individualTFs
	motifN=$(awk 'NR>1{print}' ${Dir2}/final/${sample}_Fgene_exp.diff.significant.txt | wc -l)
	totalN=$(awk 'NR>1{print}' ${Dir2}/${type}/gene_exp.diff | wc -l)
	echo $motifN $totalN > ${motif}.matrix
	echo $motifctrlN $ctrltotalN >> ${motif}.matrix
	echo $motif
	cat ${motif}.matrix
	R --vanilla --args ${motif}.matrix $(echo $motif) < /home/samir/Rat_Brain/Enhancers/fisherTest.R
done
}
for sample in A2B5 AC NR MG ODC
do
        for sex in M F
        do
		type=${sample}_${sex}
		process &
	done
done
wait
echo done
