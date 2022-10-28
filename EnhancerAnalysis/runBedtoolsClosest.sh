echo runBedtoolsClosest.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles

for file in $(ls *fimo.forigv.bed | grep -e Neuron -e Oligodendrocyte -e Oligodendrocyte_precursor -e rat_MG_DHSs_rn7)
do
	outFile=$(basename $file fimo.forigv.bed)fimo.sorted.forigv.bed
	sort -k1,1 -k2,2n  $file | uniq > $outFile
done

for sample in A2B5 NR ODC MG
do
	for sex in M F
	do
		if [ $(echo $sample | awk '{if($1 == "NR") print 1; else print 0}') -eq 1 ]; then
			bedtools closest -d -a Neuron_rn7_fimo.sorted.forigv.bed -b TSSs_expressedgenes_${sample}_${sex}.bed | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}'| sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_expressed.forigv.bed &
			bedtools closest -d -a Neuron_rn7_fimo.sorted.forigv.bed -b TSSs_DEgenes_${sample}_${sex}.bed  | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}'| sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_DEgenes.forigv.bed &
		else
			if [ $(echo $sample | awk '{if($1 == "ODC") print 1; else print 0}') -eq 1 ]; then
				bedtools closest -d -a Oligodendrocyte_rn7_fimo.sorted.forigv.bed -b TSSs_expressedgenes_${sample}_${sex}.bed  | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}' | sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_expressed.forigv.bed &
				bedtools closest -d -a Oligodendrocyte_rn7_fimo.sorted.forigv.bed -b TSSs_DEgenes_${sample}_${sex}.bed | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}' | sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_DEgenes.forigv.bed &
			else
				bedtools closest -d -a Oligodendrocyte_precursor_rn7_fimo.sorted.forigv.bed -b TSSs_expressedgenes_${sample}_${sex}.bed  | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}' | sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_expressed.forigv.bed &
				bedtools closest -d -a Oligodendrocyte_precursor_rn7_fimo.sorted.forigv.bed -b TSSs_DEgenes_${sample}_${sex}.bed | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}' | sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_DEgenes.forigv.bed &

				if [ $(echo $sample | awk '{if($1 == "MG") print 1; else print 0}') -eq 1 ]; then
					bedtools closest -d -a rat_MG_DHSs_rn7_fimo.sorted.forigv.bed -b TSSs_expressedgenes_${sample}_${sex}.bed | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}' | sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_expressed.forigv.bed &
					bedtools closest -d -a rat_MG_DHSs_rn7_fimo.sorted.forigv.bed -b TSSs_DEgenes_${sample}_${sex}.bed | awk '$NF < 10000 && $NF > 500' | awk -v OFS="\t" '{print $1,$2,$3,toupper($4)}' | sort -k1,1 -k2,2n | uniq > ${sample}_${sex}_rn7_fimo_DEgenes.forigv.bed &
				fi
			fi
		fi
	done
done
wait
awk '$4 == "SRF" || $4 == "HNF1B" || $4 == "FOXC2" || $4 == "FOXB1"' NR_F_rn7_fimo_DEgenes.forigv.bed > NR_F_rn7_fimo_DEgenes.forigv.final.bed
awk '$4 == "POU3F1" || $4 == "HNF1B" || $4 == "FOXC2" || $4 == "FOXB1"' NR_M_rn7_fimo_DEgenes.forigv.bed > NR_M_rn7_fimo_DEgenes.forigv.final.bed
awk '$4 == "RREB1" || $4 == "EGR2" || $4 == "EBF1" || $4 == "CUX2" || $4 == "CUX1"' ODC_F_rn7_fimo_DEgenes.forigv.bed > ODC_F_rn7_fimo_DEgenes.forigv.final.bed
awk '$4 == "ZFP281" || $4 == "RREB1" || $4 == "NFKB1" || $4 == "MZF1" || $4 == "EGR2"' ODC_M_rn7_fimo_DEgenes.forigv.bed > ODC_M_rn7_fimo_DEgenes.forigv.final.bed
awk '$4 == "PRDM1" || $4 == "IRF1"' A2B5_F_rn7_fimo_DEgenes.forigv.bed > A2B5_F_rn7_fimo_DEgenes.forigv.final.bed
#awk '$4 == "SP2" || $4 == "SP1" || $4 == "RREB1" || $4 == "KLF5" || $4 == "EGR2" || $4 == "E2F6"' A2B5_M_rn7_fimo_DEgenes.forigv.bed > A2B5_M_rn7_fimo_DEgenes.forigv.final.bed
awk '$4 == "ZIC3" || $4 == "ZIC1" || $4 == "ZFP105" || $4 == "TBP" || $4 == "RREB1" || $4 == "FOXP1"' MG_F_rn7_fimo_DEgenes.forigv.bed > MG_F_rn7_fimo_DEgenes.forigv.final.bed
awk '$4 == "ZIC3" || $4 == "ZIC1" || $4 == "ZFP281" || $4 == "EGR1" || $4 == "CTCF"' MG_M_rn7_fimo_DEgenes.forigv.bed > MG_M_rn7_fimo_DEgenes.forigv.final.bed

wc -l *_rn7_fimo_DEgenes.forigv.bed
wc -l *_rn7_fimo_expressed.forigv.bed
wc -l *.final.bed
echo done
