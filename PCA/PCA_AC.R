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
AC_M_Normoxia=y[,grep("AC_M_Normoxia", names)]
AC_F_Normoxia=y[,grep("AC_F_Normoxia", names)]
AC_M_Hypoxia=y[,grep("AC_M_Hypoxia", names)]
AC_F_Hypoxia=y[,grep("AC_F_Hypoxia", names)]

y=t(y)
M=as.matrix(cbind(AC_M_Normoxia, AC_F_Normoxia, AC_M_Hypoxia, AC_F_Hypoxia))
P=NULL

ses=factor(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4)))
levels(ses)=c("AC_M_Normoxia", "AC_F_Normoxia", "AC_M_Hypoxia", "AC_F_Hypoxia")
for(i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues

signif=which(q<.05)
head(signif)

AC_M_Normoxia=AC_M_Normoxia[signif,]
AC_F_Normoxia=AC_F_Normoxia[signif,]
AC_M_Hypoxia=AC_M_Hypoxia[signif,]
AC_F_Hypoxia=AC_F_Hypoxia[signif,]
length(signif)
head(y)

AC_M_Normoxia=apply(AC_M_Normoxia, 1, mean)
AC_F_Normoxia=apply(AC_F_Normoxia, 1, mean)
AC_M_Hypoxia=apply(AC_M_Hypoxia, 1, mean)
AC_F_Hypoxia=apply(AC_F_Hypoxia, 1, mean)

x= cbind(AC_M_Normoxia, AC_F_Normoxia, AC_M_Hypoxia, AC_F_Hypoxia)
colnames(x)=c("AC_M_N","AC_F_N","AC_M_H","AC_F_H")
y=t(x)

png(paste("PCA_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
p=plot(P,choix="ind",habillage="ind",graph.type="classic")
dev.off()
