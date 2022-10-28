library("FactoMineR")
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
NR_M_Normoxia=y[,grep("NR_M_Normoxia", names)]
NR_F_Normoxia=y[,grep("NR_F_Normoxia", names)]
NR_M_Hypoxia=y[,grep("NR_M_Hypoxia", names)]
NR_F_Hypoxia=y[,grep("NR_M_Hypoxia", names)]

y=t(y)
M=as.matrix(cbind(NR_M_Normoxia, NR_F_Normoxia, NR_M_Hypoxia, NR_F_Hypoxia))
P=NULL

ses=factor(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4)))
levels(ses)=c("NR_M_Normoxia", "NR_F_Normoxia", "NR_M_Hypoxia", "NR_F_Hypoxia")
for(i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues

signif=which(q<.05)
head(signif)

NR_M_Normoxia=NR_M_Normoxia[signif,]
NR_F_Normoxia=NR_F_Normoxia[signif,]
NR_M_Hypoxia=NR_M_Hypoxia[signif,]
NR_F_Hypoxia=NR_F_Hypoxia[signif,]
length(signif)
head(y)

NR_M_Normoxia=apply(NR_M_Normoxia, 1, mean)
NR_F_Normoxia=apply(NR_F_Normoxia, 1, mean)
NR_M_Hypoxia=apply(NR_M_Hypoxia, 1, mean)
NR_F_Hypoxia=apply(NR_F_Hypoxia, 1, mean)

x= cbind(NR_M_Normoxia, NR_F_Normoxia, NR_M_Hypoxia, NR_F_Hypoxia)
colnames(x)=c("NR_M_N","NR_F_N","NR_M_H","NR_F_H")
y=t(x)

png(paste("PCA_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
p=plot(P,choix="ind",habillage="ind",graph.type="classic")
dev.off()
