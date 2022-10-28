echo poolReplicates_RNAseq.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/bam
for sample in A2B5 AC MG NR ODC
do
        for sex in M F
        do
                for treatment in Hypoxia Normoxia
                do
			type=${sample}_${sex}_${treatment}
			files=$(ls ${type}*.UM.sorted.bam)
			samtools merge ${type}.pooled.UM.sorted.bam $files &
		done
	done
done
wait
