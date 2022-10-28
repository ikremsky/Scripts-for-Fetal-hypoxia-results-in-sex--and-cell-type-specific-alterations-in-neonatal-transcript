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
AC_M_Normoxia=y[,grep("AC_M_Normoxia", names)]
AC_F_Normoxia=y[,grep("AC_F_Normoxia", names)]
AC_M_Hypoxia=y[,grep("AC_M_Hypoxia", names)]
AC_F_Hypoxia=y[,grep("AC_F_Hypoxia", names)]
MG_M_Normoxia=y[,grep("MG_M_Normoxia", names)]
MG_F_Normoxia=y[,grep("MG_F_Normoxia", names)]
MG_M_Hypoxia=y[,grep("MG_M_Hypoxia", names)]
MG_F_Hypoxia=y[,grep("MG_F_Hypoxia", names)]
ODC_M_Normoxia=y[,grep("ODC_M_Normoxia", names)]
ODC_F_Normoxia=y[,grep("ODC_F_Normoxia", names)]
ODC_M_Hypoxia=y[,grep("ODC_M_Hypoxia", names)]
ODC_F_Hypoxia=y[,grep("ODC_F_Hypoxia", names)]
A2B5_M_Normoxia=y[,grep("A2B5_M_Normoxia", names)]
A2B5_F_Normoxia=y[,grep("A2B5_F_Normoxia", names)]
A2B5_M_Hypoxia=y[,grep("A2B5_M_Hypoxia", names)]
A2B5_F_Hypoxia=y[,grep("A2B5_F_Hypoxia", names)]

y=t(y)
M=as.matrix(cbind(NR_M_Normoxia, NR_F_Normoxia, NR_M_Hypoxia, NR_F_Hypoxia, AC_M_Normoxia, AC_F_Normoxia, AC_M_Hypoxia, AC_F_Hypoxia, MG_M_Normoxia, MG_F_Normoxia, MG_M_Hypoxia, MG_F_Hypoxia, ODC_M_Normoxia, ODC_F_Normoxia, ODC_M_Hypoxia, ODC_F_Hypoxia, A2B5_M_Normoxia, A2B5_F_Normoxia, A2B5_M_Hypoxia, A2B5_F_Hypoxia))
print(names)
P=NULL

ses=factor(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4),rep(5,4),rep(6,4),rep(7,4),rep(8,4),rep(9,4),rep(10,4),rep(11,4),rep(12,4),rep(13,4),rep(14,4),rep(15,4),rep(16,4),rep (17,4),rep(18,4),rep(19,4),rep(20,4)))
levels(ses)=c("NR_M_Normoxia", "NR_F_Normoxia", "NR_M_Hypoxia", "NR_F_Hypoxia", "AC_M_Normoxia", "AC_F_Normoxia", "AC_M_Hypoxia", "AC_F_Hypoxia", "MG_M_Normoxia", "MG_F_Normoxia", "MG_M_Hypoxia", "MG_F_Hypoxia", "ODC_M_Normoxia", "ODC_F_Normoxia", "ODC_M_Hypoxia", "ODC_F_Hypoxia","A2B5_M_Normoxia", "A2B5_F_Normoxia", "A2B5_M_Hypoxia", "A2B5_F_Hypoxia")
for(i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues

signif=which(q<.05)

NR_M_Normoxia=NR_M_Normoxia[signif,]
NR_F_Normoxia=NR_F_Normoxia[signif,]
NR_M_Hypoxia=NR_M_Hypoxia[signif,]
NR_F_Hypoxia=NR_F_Hypoxia[signif,]
AC_M_Normoxia=AC_M_Normoxia[signif,]
AC_F_Normoxia=AC_F_Normoxia[signif,]
AC_M_Hypoxia=AC_M_Hypoxia[signif,]
AC_F_Hypoxia=AC_F_Hypoxia[signif,]
MG_M_Normoxia=MG_M_Normoxia[signif,]
MG_F_Normoxia=MG_F_Normoxia[signif,]
MG_M_Hypoxia=MG_M_Hypoxia[signif,]
MG_F_Hypoxia=MG_F_Hypoxia[signif,]
ODC_M_Normoxia=ODC_M_Normoxia[signif,]
ODC_F_Normoxia=ODC_F_Normoxia[signif,]
ODC_M_Hypoxia=ODC_M_Hypoxia[signif,]
ODC_F_Hypoxia=ODC_F_Hypoxia[signif,]
A2B5_M_Normoxia=A2B5_M_Normoxia[signif,]
A2B5_F_Normoxia=A2B5_F_Normoxia[signif,]
A2B5_M_Hypoxia=A2B5_M_Hypoxia[signif,]
A2B5_F_Hypoxia=A2B5_F_Hypoxia[signif,]
length(signif)
head(y)

NR_M_Normoxia=apply(NR_M_Normoxia, 1, mean)
NR_F_Normoxia=apply(NR_F_Normoxia, 1, mean)
NR_M_Hypoxia=apply(NR_M_Hypoxia, 1, mean)
NR_F_Hypoxia=apply(NR_F_Hypoxia, 1, mean)
AC_M_Normoxia=apply(AC_M_Normoxia, 1, mean)
AC_F_Normoxia=apply(AC_F_Normoxia, 1, mean)
AC_M_Hypoxia=apply(AC_M_Hypoxia, 1, mean)
AC_F_Hypoxia=apply(AC_F_Hypoxia, 1, mean)
MG_M_Normoxia=apply(MG_M_Normoxia, 1, mean)
MG_F_Normoxia=apply(MG_F_Normoxia, 1, mean)
MG_M_Hypoxia=apply(MG_M_Hypoxia, 1, mean)
MG_F_Hypoxia=apply(MG_F_Hypoxia, 1, mean)
ODC_M_Normoxia=apply(ODC_M_Normoxia, 1, mean)
ODC_F_Normoxia=apply(ODC_F_Normoxia, 1, mean)
ODC_M_Hypoxia=apply(ODC_M_Hypoxia, 1, mean)
ODC_F_Hypoxia=apply(ODC_F_Hypoxia, 1, mean)
A2B5_M_Normoxia=apply(A2B5_M_Normoxia, 1, mean)
A2B5_F_Normoxia=apply(A2B5_F_Normoxia, 1, mean)
A2B5_M_Hypoxia=apply(A2B5_M_Hypoxia, 1, mean)
A2B5_F_Hypoxia=apply(A2B5_F_Hypoxia, 1, mean)

x= cbind(NR_M_Normoxia, NR_F_Normoxia, NR_M_Hypoxia, NR_F_Hypoxia, AC_M_Normoxia, AC_F_Normoxia, AC_M_Hypoxia, AC_F_Hypoxia, MG_M_Normoxia, MG_F_Normoxia, MG_M_Hypoxia, MG_F_Hypoxia, ODC_M_Normoxia, ODC_F_Normoxia, ODC_M_Hypoxia, ODC_F_Hypoxia, A2B5_M_Normoxia, A2B5_F_Normoxia, A2B5_M_Hypoxia, A2B5_F_Hypoxia)
colnames(x)=c("NR_M_N","NR_F_N","NR_M_H","NR_F_H","AC_M_N","AC_F_N","AC_M_H","AC_F_H","MG_M_N","MG_F_N","MG_M_H","MG_F_H","ODC_M_N","ODC_F_N","ODC_M_H","ODC_F_H", "A2B5_M_N","A2B5_F_N","A2B5_M_H", "A2B5_F_H")
y=t(x)

png(paste("PCA_RNAseq", ".png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
p=plot(P,choix="ind",habillage="ind",graph.type="classic")
dev.off()
length(colnames(x))
length(x[1,])
length(ses)
length(M[1,])
