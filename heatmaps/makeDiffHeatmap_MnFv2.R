library("pheatmap")
library("fastcluster")
args=as.character(commandArgs(trailingOnly=T))

a=read.delim(args[1])
b=read.delim(args[2])

c=read.delim(args[3])
d=read.delim(args[4])

e=read.delim(args[5])
f=read.delim(args[6])

g=read.delim(args[7])
h=read.delim(args[8])

i=read.delim(args[9])
j=read.delim(args[10])

a[which(a[,10] > 3),10]=3
a[which(a[,10] < -3),10]=-3
b[which(b[,10] > 3),10]=3
b[which(b[,10] < -3),10]=-3

c[which(c[,10] > 3),10]=3
c[which(c[,10] < -3),10]=-3
d[which(d[,10] > 3),10]=3
d[which(d[,10] < -3),10]=-3

e[which(e[,10] > 3),10]=3
e[which(e[,10] < -3),10]=-3
f[which(f[,10] > 3),10]=3
f[which(f[,10] < -3),10]=-3

g[which(g[,10] > 3),10]=3
g[which(g[,10] < -3),10]=-3
h[which(h[,10] > 3),10]=3
h[which(h[,10] < -3),10]=-3

i[which(i[,10] > 3),10]=3
i[which(i[,10] < -3),10]=-3
j[which(j[,10] > 3),10]=3
j[which(j[,10] < -3),10]=-3

M=as.matrix(cbind(as.numeric(a[,10]),as.numeric(b[,10]),as.numeric(c[,10]),as.numeric(d[,10]),as.numeric(e[,10]),as.numeric(f[,10]),as.numeric(g[,10]),as.numeric(h[,10]),as.numeric(i[,10]),as.numeric(j[,10])))
colnames(M)=c("A2B5_F","A2B5_M","AC_F","AC_M","MG_F","MG_M","NR_F","NR_M","ODC_F","ODC_M")
index=((a[,13]<.05 & abs(a[,10])>1) | (b[,13]<.05 & abs(b[,10])>1) | (c[,13]<.05 & abs(c[,10])>1) | (d[,13]<.05 & abs(d[,10])>1) | (e[,13]<.05 & abs(e[,10])>1) | (f[,13]<.05 & abs(f[,10])>1) | (g[,13]<.05 & abs(g[,10])>1) | (h[,13]<.05 & abs(h[,10])>1) | (i[,13]<.05 & abs(i[,10])>1) | (j[,13]<.05 & abs(j[,10])>1))
#print(length(index))
M=-M[index,]
print(M)
ordr=hclust(dist(M))$order

myCol <- c(colorRampPalette(c("blue", "white", "red"))(300))
myBreaks <- c(seq(-3,-.1,length=150), 0, seq(.1,3,length=150))

png("FemaleAndMale_heatmap_HC.png", height = 2000, width = 2000, res = 300)
pheatmap(M[ordr,], cluster_rows=F, cluster_cols=F, scale="none", legend=T, fontsize_col=20,color=myCol,breaks=myBreaks)
dev.off()

