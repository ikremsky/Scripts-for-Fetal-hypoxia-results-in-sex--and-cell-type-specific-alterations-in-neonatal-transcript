cd /data2/samir/RAT_BRAIN_RNA_SEQ_DATA_BO_LI_John_Chen_2019/cuffdiff/final
Dir=/home/samir/Rat_Brain/Enhancers

for Mfile in $(ls *_M*sig*.txt | grep -v Hypo | grep -v Nor)
do
	Ffile=$(echo $Mfile | awk '{gsub("_M","_F"); print}')
	File1=$(basename $Mfile gene_exp.diff.significant.txt).File1
	File2=$(basename $Ffile gene_exp.diff.significant.txt).File2

	awk 'NR>1 {print$1}' $Mfile | sort -b > $File1
	awk 'NR>1 {print$1}' $Ffile | sort -b > $File2

	type1=$(basename $Mfile gene_exp.diff.significant.txt | awk '{gsub("_M","-M");print}')
	type2=$(basename $Ffile gene_exp.diff.significant.txt | awk '{gsub("_F","-F");print}')
	id=${type1}_${type2}
	overlapFile=$(basename $Mfile _Mgene_exp.diff.significant.txt).overlap

	join $File1 $File2 > $overlapFile
	sh ${Dir}/getPariwisePeakVenns.sh $File1 $File2 $overlapFile NA $type1 $type2 $id
done

echo done
