echo getDEgenes_MvF.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019
mkdir cuffdiff
mkdir cuffdiff/final
mkdir Enhancers/bedFiles
Dir=Enhancers/bedFiles
process ()
{
	cuffdiff -p 4 -L ${sample1},${sample2} -o cuffdiff/${type} /data2/genomes/rn7/refSeqgenes_rn7.gtf $MaleFiles $FemaleFiles
	awk 'BEGIN{OFS="\t"}{if(NR == 1) print}' cuffdiff/${type}/gene_exp.diff > cuffdiff/final/${type}gene_exp.diff.significant.txt
	awk 'BEGIN{OFS="\t"}{$10=-$10; if(NR > 1 && $13<.05 && sqrt($10*$10) > 1) print}' cuffdiff/${type}/gene_exp.diff >> cuffdiff/final/${type}gene_exp.diff.significant.txt

	awk -v OFS="\t" '{if($13<.05) print $4,$1}' cuffdiff/final/${type}gene_exp.diff.significant.txt | awk '{sub(":", "\t"); sub("-", "\t"); print}' | sort -k1,1 -k2,2n > ${Dir}/DEgenes_${type}.bed
	awk '{if($8>3 || $9>3) print $1}' cuffdiff/final/${type}gene_exp.diff.significant.txt | sort -b  > ${Dir}/expressedGenes_${type}.txt
#	awk '{if($10>0) color="red"; else color="blue"; if($13<.05 && sqrt($10*$10)>1) print $1,color}' cuffdiff/final/${type}gene_exp.diff.significant.txt > ${Dir}/DEGenes_color_${type}.txt
	intersectBed -f 1 -F 1 -u -a ${Dir}/DEgenes_${type}.bed -b ${Dir}/expressedgenes_${type}.bed > temp_${type}; mv temp_${type} ${Dir}/DEgenes_${type}.bed
	intersectBed -u -a ${Dir}/TSSs_rn7.bed -b ${Dir}/DEgenes_${type}.bed > ${Dir}/TSSs_DEgenes_${type}.bed
}

Male=M
Female=F

for sample in A2B5 AC MG NR ODC
do
        for condition in Hypoxia Normoxia
        do
		type=${sample}_${condition}
		sample1=${sample}_${Male}_${condition}
		sample2=${sample}_${Female}_${condition}
		MaleFiles=$(ls bam/${sample1}*.UM.sorted.bam | grep -v pooled | awk -v x="" '{x=","$1x}END{sub(",", "", x); print x}')
		FemaleFiles=$(ls bam/${sample2}*.UM.sorted.bam | grep -v pooled | awk -v x="" '{x=","$1x}END{sub(",", "", x); print x}')
		process &
      done
done
wait
wc -l cuffdiff/final/*significant.txt
wc -l Enhancers/bedFiles/*DEgenes_*bed
wc -l Enhancers/bedFiles/*expressedGenes_*txt
pwd
echo done
