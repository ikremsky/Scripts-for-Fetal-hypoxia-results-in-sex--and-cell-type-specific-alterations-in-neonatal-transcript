echo runfimo.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles
Dir=/home/samir/Rat_Brain/Enhancers
for file in $(ls *bed | grep rat_MG_DHSs_rn7.bed)
do
	fastaFile=$(basename $file .bed).fasta
	fimoFile=$(basename $file .bed)_fimo.txt
	fastaFromBed -fi /data2/genomes/rn7/rn7.fa -bed $file -fo $fastaFile
	fimo --text /home/samir/Advanced_Bioinformatics/Assignment8_2/combinedMotifs.meme $fastaFile > $fimoFile &
done
wait
sh ${Dir}/analyzeMotifsFromFimo.sh
echo done
