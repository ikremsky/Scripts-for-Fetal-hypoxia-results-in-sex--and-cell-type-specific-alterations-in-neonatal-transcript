cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/Enhancers/bedFiles
#obtained refSeqgenes_mm10.bed from UCSC table browser.
cat refSeqgenes_rn7.bed | awk -v OFS="\t" '{if($6 == "+") {start = $2} else {start = $3-1}; print $1, start, start +1, $4, ".", $6}' | sort -k1,1 -k2,2n | uniq > TSSs_rn7.bed
pwd
echo done
