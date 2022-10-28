echo getBedGraphfromBed_RNAseq.sh 
cd bed
getBG ()
{
	outFile=$(echo $file | awk '{sub(".split", ""); print}')
	M=$(awk -v x=$outFile 'BEGIN{count=0}{if($2 == x) count+=$1/1000000}END{print 1/count}' readCounts)
	echo $M $file | awk '{print 1/$1,$2}'
	cut -f1-3 $file | sort -k1,1 | bedtools genomecov -scale $M -i - -g /data2/genomes/rn7/rn7.chrom.sizes -bg > $(basename $outFile .bed).bedGraph
	bedGraphToBigWig $(basename $outFile .bed).bedGraph /data2/genomes/rn7/rn7.chrom.sizes $(basename $outFile .bed).bw
}

i=1
for file in $(ls *split.bed | grep pool)
do
	getBG &
        if [ $(echo $i | awk '{print $1%6}') -eq 0 ]; then
                wait
        fi
        i=$(expr $i + 1)
done
wait
echo done
