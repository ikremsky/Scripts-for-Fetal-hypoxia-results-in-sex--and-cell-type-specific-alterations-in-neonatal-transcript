echo getMGdata.sh
cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles/

wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3500nnn/GSM3500804/suppl/GSM3500804_1UNTR_picard_mapped_sorted_reversed.fdr0.01.hot.bed.gz &
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3500nnn/GSM3500805/suppl/GSM3500805_2UNTR_picard_mapped_sorted_reversed.fdr0.01.hot.bed.gz &
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3500nnn/GSM3500806/suppl/GSM3500806_1LPS_picard_mapped_sorted_reversed.fdr0.01.hot.bed.gz &
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3500nnn/GSM3500807/suppl/GSM3500807_2LPS_picard_mapped_sorted_reversed.fdr0.01.hot.bed.gz &
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3500nnn/GSM3500808/suppl/GSM3500808_1GCM_picard_mapped_sorted_reversed.fdr0.01.hot.bed.gz &
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3500nnn/GSM3500809/suppl/GSM3500809_2GCM_picard_mapped_sorted_reversed.fdr0.01.hot.bed.gz &
wait

files=$(ls *hot.bed.gz)

zcat $files | sort -k1,1 -k2,2n | bedtools merge -i - | awk -v OFS="\t" '{print $1,$2,$3,$1":"$2"-"$3,".","+"}' > rat_MG_DHSs_rn5.bed
liftOver rat_MG_DHSs_rn5.bed ../rn5ToRn7.over.chain.gz rat_MG_DHSs_rn7.bed rat_MG_DHSs_rn7.unmapped
awk -v OFS="\t" '{print $1,$2,$3,$1":"$2"-"$3,".","+"}' rat_MG_DHSs_rn7.bed > temp; mv temp rat_MG_DHSs_rn7.bed
