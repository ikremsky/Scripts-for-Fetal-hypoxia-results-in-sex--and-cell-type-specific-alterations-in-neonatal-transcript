library("pheatmap")
library("fastcluster")
args=as.character(commandArgs(trailingOnly=T))

M=NULL
N=NULL
HNs=NULL
Q=NULL
FPKM=NULL
for (i in 1:length(args))
{
	names=gsub("/gene_exp.diff.mod", "", gsub("cuffdiff/", "", args[i]))
	x=read.delim(args[i])
	x=x[order(x[,1]),]
	Log2FC=x[,10]
	HNs=cbind(HNs,names)
	x[which(Log2FC > 3),10]=3
	x[which(Log2FC < -3),10]=-3
	M=cbind(M,Log2FC)
	N=cbind(N,x[,10])
	Q=cbind(Q,x[,13])
	FPKM=cbind(FPKM,log(x[,9]+1, 2))
}	
colnames(M)=HNs
colnames(Q)=HNs
colnames(FPKM)=HNs
colnames(N)=HNs
rownames(M)=x[,1]
rownames(Q)=x[,1]
rownames(FPKM)=x[,1]
 
index=( (Q[,1]<.05 & abs(M[,1])>1) | (Q[,2]<.05 & abs(M[,2])>1) | (Q[,4]<.05 & abs(M[,4])>1) | (Q[,5]<.05 & abs(M[,5])>1) | (Q[,7]<.05 & abs(M[,7])>1) | (Q[,8]<.05 & abs(M[,8])>1) | (Q[,10]<.05 & abs(M[,10])>1) | (Q[,11]<.05 & abs(M[,11])>1) | (Q[,13]<.05 & abs(M[,13])>1) | (Q[,14]<.05 & abs(M[,14])>1) )
M=-M[index,]
N=-N[index,]
FPKM=FPKM[index,]
M[,c(3,6,9,12,15)]=-M[,c(3,6,9,12,15)]
N[,c(3,6,9,12,15)]=-N[,c(3,6,9,12,15)]
#write.table(M, file = "Diffheatmap", quote = FALSE, sep = "\t", row.names = TRUE, col.names = TRUE)
ordr=hclust(dist(M))$order
write.table(rownames(M)[ordr], file = "Diffheatmap", quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)

myCol <- c(colorRampPalette(c("blue", "white", "red"))(300))
myBreaks <- c(seq(-3,-.1,length=150), 0, seq(.1,3,length=150))

png("Female-Male-Normoxia_heatmap_HC.png", height = 2000, width = 2000, res = 300)
pheatmap(N[ordr,], cluster_rows=F, cluster_cols=F, scale="none", legend=T, fontsize_col=20,color=myCol,breaks=myBreaks)
dev.off()

#####
val=9
#####
myCol <- c(colorRampPalette(c("white", "black"))(25))
myBreaks <- seq(0,val,length=26)

png(paste("All_heatmap_ScaleFalse_pooled_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
pheatmap(FPKM[ordr,-c(3,6,9,12,15)], cluster_rows=F, cluster_cols=F, scale="none", legend=T, fontsize_col=20,color=myCol, breaks=myBreaks)
dev.off()

