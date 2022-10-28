echo getExpressedGenes.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles
Dir=/data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019
process ()
{
	awk '$10 > 1' ${Dir}/cufflinks/${sample1}/genes.fpkm_tracking | awk '{gsub(":"," ",$7); print}' | awk '{gsub("-"," ",$8); print}' | awk -v OFS="\t" 'NR>1 {print $7,$8,$9,$4,$12,"+"}' > temp_${sample1}
	awk '$10 > 1' ${Dir}/cufflinks/${sample2}/genes.fpkm_tracking | awk '{gsub(":"," ",$7); print}' | awk '{gsub("-"," ",$8); print}' | awk -v OFS="\t" 'NR>1 {print $7,$8,$9,$4,$12,"+"}' > temp_${sample2}
	cat temp_${sample1} temp_${sample2} | sort -k1,1 -k2,2n | uniq > expressedgenes_${sample}_${sex}.bed
	intersectBed -u -a TSSs_rn7.bed -b expressedgenes_${sample}_${sex}.bed > TSSs_expressedgenes_${sample}_${sex}.bed
}

test=Hypoxia
ctrl=Normoxia

for sample in A2B5 AC MG NR ODC
do
        for sex in M F
        do
                compare=${test}v${ctrl}
                sample1=${sample}_${sex}_${test}.pooled
                sample2=${sample}_${sex}_${ctrl}.pooled
                process &
        done
done
wait
#rm *temp*
wc -l *TSSs_expressedgenes_*bed
tail *TSSs_expressedgenes_*bed
pwd
echo done
