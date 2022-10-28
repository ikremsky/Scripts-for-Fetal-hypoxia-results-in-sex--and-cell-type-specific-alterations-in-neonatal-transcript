echo getBedfiles.sh
mkdir /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers
Dir=/home/samir/Rat_Brain/Enhancers
## Got the rn5.txt files from here: http://www.enhanceratlas.org/browsespecies.php?species=Rattus_norvegicus
#wget https://hgdownload.soe.ucsc.edu/goldenPath/rn5/liftOver/rn5ToRn7.over.chain.gz
for file in $(ls ${Dir}/*rn5.txt)
do
	outFile=$(basename $file rn5.txt)rn5.bed
	outFile2=$(basename $file rn5.txt)rn7.bed
	outFile3=$(basename $file rn5.txt)rn7.unmapped
	awk -v OFS="\t" '{print $1,$2,$3,$1":"$2"-"$3,".","+"}' $file > $outFile
	liftOver $outFile rn5ToRn7.over.chain.gz $outFile2 $outFile3
done
wait
echo done
