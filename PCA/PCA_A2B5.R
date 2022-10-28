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
A2B5_M_Normoxia=y[,grep("A2B5_M_Normoxia", names)]
A2B5_F_Normoxia=y[,grep("A2B5_F_Normoxia", names)]
A2B5_M_Hypoxia=y[,grep("A2B5_M_Hypoxia", names)]
A2B5_F_Hypoxia=y[,grep("A2B5_F_Hypoxia", names)]

y=t(y)
M=as.matrix(cbind(A2B5_M_Normoxia, A2B5_F_Normoxia, A2B5_M_Hypoxia, A2B5_F_Hypoxia))
P=NULL

ses=factor(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4)))
levels(ses)=c("A2B5_M_Normoxia", "A2B5_F_Normoxia", "A2B5_M_Hypoxia", "A2B5_F_Hypoxia")
for(i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues

signif=which(q<.05)
head(signif)

A2B5_M_Normoxia=A2B5_M_Normoxia[signif,]
A2B5_F_Normoxia=A2B5_F_Normoxia[signif,]
A2B5_M_Hypoxia=A2B5_M_Hypoxia[signif,]
A2B5_F_Hypoxia=A2B5_F_Hypoxia[signif,]
length(signif)
head(y)

A2B5_M_Normoxia=apply(A2B5_M_Normoxia, 1, mean)
A2B5_F_Normoxia=apply(A2B5_F_Normoxia, 1, mean)
A2B5_M_Hypoxia=apply(A2B5_M_Hypoxia, 1, mean)
A2B5_F_Hypoxia=apply(A2B5_F_Hypoxia, 1, mean)

x= cbind(A2B5_M_Normoxia, A2B5_F_Normoxia, A2B5_M_Hypoxia, A2B5_F_Hypoxia)
colnames(x)=c("A2B5_M_N","A2B5_F_N","A2B5_M_H", "A2B5_F_H")
y=t(x)

png(paste("PCA_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
p=plot(P,choix="ind",habillage="ind",graph.type="classic")
dev.off()
