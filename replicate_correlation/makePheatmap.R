args=as.character(commandArgs(trailingOnly=T))
library("pheatmap")
library("grid")

table=read.delim(args[1], header = FALSE)
head(table)
replicate=read.delim(args[2], header = FALSE)
head(replicate)
sample=as.character(args[3])
M=NULL
for (Rep in as.numeric(replicate[[1]]))
{
#print(Rep)
index=table[,2]==Rep
cor=table[index,4]
M=cbind(M,table[index,4])
}
colnames(M)=replicate[[1]]
rownames(M)=replicate[[1]]

png(paste("heatmap_",sample,".png",sep=""))
setHook("grid.newpage", function() pushViewport(viewport(x=1,y=1,width=0.9, height=0.9, name="vp", just=c("right","top"))), action="prepend")
pheatmap(M,cluster_rows=F,fontsize=30, cluster_cols=F, scale="none", legend=F, fontsize_col=30,color=c(colorRampPalette(c("white", "black"))(20)), breaks=seq(0, 1, length.out = 21), fontsize_row=30, cex.main=3, main=paste(sample))
setHook("grid.newpage", NULL, "replace")
grid.text("Replicate Number", y=-0.07, gp=gpar(fontsize=30))
grid.text("Replicate Number", x=-0.07, rot=90, gp=gpar(fontsize=30))
dev.off()
