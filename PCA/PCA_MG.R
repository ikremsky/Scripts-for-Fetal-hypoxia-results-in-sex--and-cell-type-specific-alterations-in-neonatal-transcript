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
MG_M_Normoxia=y[,grep("MG_M_Normoxia", names)]
MG_F_Normoxia=y[,grep("MG_F_Normoxia", names)]
MG_M_Hypoxia=y[,grep("MG_M_Hypoxia", names)]
MG_F_Hypoxia=y[,grep("MG_F_Hypoxia", names)]

y=t(y)
M=as.matrix(cbind(MG_M_Normoxia, MG_F_Normoxia, MG_M_Hypoxia, MG_F_Hypoxia))
P=NULL

ses=factor(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4)))
levels(ses)=c("MG_M_Normoxia", "MG_F_Normoxia", "MG_M_Hypoxia", "MG_F_Hypoxia")
for(i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues

signif=which(q<.05)
head(signif)

MG_M_Normoxia=MG_M_Normoxia[signif,]
MG_F_Normoxia=MG_F_Normoxia[signif,]
MG_M_Hypoxia=MG_M_Hypoxia[signif,]
MG_F_Hypoxia=MG_F_Hypoxia[signif,]
length(signif)
head(y)

MG_M_Normoxia=apply(MG_M_Normoxia, 1, mean)
MG_F_Normoxia=apply(MG_F_Normoxia, 1, mean)
MG_M_Hypoxia=apply(MG_M_Hypoxia, 1, mean)
MG_F_Hypoxia=apply(MG_F_Hypoxia, 1, mean)

x= cbind(MG_M_Normoxia, MG_F_Normoxia, MG_M_Hypoxia, MG_F_Hypoxia)
colnames(x)=c("MG_M_N","MG_F_N","MG_M_H","MG_F_H")
y=t(x)

png(paste("PCA_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
p=plot(P,choix="ind",habillage="ind",graph.type="classic")
dev.off()
