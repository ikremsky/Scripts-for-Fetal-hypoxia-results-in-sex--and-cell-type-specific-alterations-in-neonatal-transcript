#library("FactoMineR")
library(fastcluster)
library(gplots)
library("pheatmap")
library("qvalue")


x=read.delim("geneTable.txt", sep="\t", header=T)
sums=apply(x[,-1], 1, max)
y=x[,-1]
genes=x[,1]
names=colnames(y)
####
ODC_M_Normoxia=y[,grep("ODC_M_Normoxia", names)]
ODC_F_Normoxia=y[,grep("ODC_F_Normoxia", names)]
ODC_M_Hypoxia=y[,grep("ODC_M_Hypoxia", names)]
ODC_F_Hypoxia=y[,grep("ODC_F_Hypoxia", names)]

y=t(y)
M=as.matrix(cbind(ODC_M_Normoxia, ODC_F_Normoxia, ODC_M_Hypoxia, ODC_F_Hypoxia))
P=NULL

ses=factor(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4)))
levels(ses)=c("ODC_M_Normoxia", "ODC_F_Normoxia", "ODC_M_Hypoxia", "ODC_F_Hypoxia")
for(i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues

signif=which(q<.05)
head(signif)

ODC_M_Normoxia=ODC_M_Normoxia[signif,]
ODC_F_Normoxia=ODC_F_Normoxia[signif,]
ODC_M_Hypoxia=ODC_M_Hypoxia[signif,]
ODC_F_Hypoxia=ODC_F_Hypoxia[signif,]
length(signif)

ODC_M_Normoxia=apply(ODC_M_Normoxia, 1, mean)
ODC_F_Normoxia=apply(ODC_F_Normoxia, 1, mean)
ODC_M_Hypoxia=apply(ODC_M_Hypoxia, 1, mean)
ODC_F_Hypoxia=apply(ODC_F_Hypoxia, 1, mean)

x= cbind(ODC_M_Normoxia, ODC_F_Normoxia, ODC_M_Hypoxia, ODC_F_Hypoxia)
colnames(x)=c("ODC_M_N","ODC_F_N","ODC_M_H","ODC_F_H")
y=t(x)
png(paste("PCA_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
p=plot(P,choix="ind",habillage="ind",graph.type="classic")
dev.off()
