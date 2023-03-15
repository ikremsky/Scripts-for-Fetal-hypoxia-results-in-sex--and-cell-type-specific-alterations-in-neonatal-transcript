library("FactoMineR")
library(fastcluster)
library(gplots)
library("pheatmap")
library("qvalue")
args=as.character(commandArgs(trailingOnly=T))

x=read.delim("geneTable.txt", sep="\t", header=T)
sums=apply(x[,-1], 1, max)
y=x[,-1]
genes=x[,1]
names=colnames(y)
####
celltype=as.character(args[1])
samples=as.character(args[2:length(args)])


M=NULL
se=NULL
i=1
for (sample in samples)
{
	assign(sample, y[,grep(sample, names)])
	
	se=c(se, rep(i,4))
	i=i+1
}
M=get(samples[1])

for (j in 2:length(samples))
{
	M=cbind(M,get(samples[j]))
}

y=t(y)
M=as.matrix(M)
P=NULL

ses=factor(se)
levels(ses)=samples
head(levels(ses))
for (i in 1:length(x[,1]))
{
        a=aov(M[i,] ~ ses)
        P=c(P, unlist(summary(a))["Pr(>F)1"])
}
q=qvalue(P)$qvalues
#q=qvalue(P, lambda = seq(min(P), max(P), 0.025), smooth.log.pi0="TRUE")$qvalues

signif=which(q<.05)
#head(genes[signif], n=20)
x=NULL
for (sample in samples)
{
	assign(sample, get(sample)[signif,])
}

x=get(samples[1])

for (j in 2:length(samples))
{
        x=cbind(x,get(samples[j]))
}
#colnames(x)=samples
y=t(x)
#rownames(x)=genes[signif]
#print(x)

png(paste("PCA_", celltype, "_RNAseq.png", sep=""), height = 2000, width = 2000, res = 300)
P=PCA(y, graph = F, scale.unit = F)
#p=plot(P,choix="ind",habillage="ind",graph.type="classic", cex=2.5)
p=plot(P,choix="ind",habillage ="none", col.ind=rep("white",20), graph.type="classic",label="none")
points(P$ind$coord[,1],P$ind$coord[,2],col=c(rep("dodgerblue",4),rep("hotpink",4),rep("dodgerblue",4),rep("hotpink",4)),pch=c(rep(19,4),rep(19,4),rep(1,4),rep(1,4)), cex=1.5)
#points(P$ind$coord[,1],P$ind$coord[,2],col=c("black","black","black","black"),pch=c(rep(15,4),rep(19,4),rep(0,4),rep(1,4)), cex=1.5)
#legend("top", ncol=2, pch=c(19,19,1,1), legend=samples, col=c("dodgerblue","hotpink","dodgerblue","hotpink"), bty="o", cex=1.5)
#legend("top", ncol=2, pch=c(15,19,0,1), legend=samples, col=rep("black",4), bty="o", cex=1.5)
dev.off()
