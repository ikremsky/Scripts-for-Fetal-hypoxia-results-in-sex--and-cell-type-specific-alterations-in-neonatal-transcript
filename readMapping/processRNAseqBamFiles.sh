echo processRNAseqBamFiles.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/
mkdir bam
process ()
{
	local newFile=bam/${name}.UM.sorted.bam
	samtools view -h $file | awk '$1 ~ "^@" || $NF == "NH:i:1"' | samtools view -bh - | samtools sort - > $newFile
}

for file in $(ls tophat2/*/accepted_hits.bam)
do
	name=$(echo $file | cut -f2 -d"/")
        process &
done
wait
echo done
