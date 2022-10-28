library("VennDiagram")
args=commandArgs(trailingOnly=TRUE)
i=1
area1=as.numeric(args[i]); i=i+1
area2=as.numeric(args[i]); i=i+1
cross.area=as.numeric(args[i]); i=i+1
name1=as.character(args[i]); i=i+1
name2=as.character(args[i]); i=i+1
outName=as.character(args[i]); i=i+1

png(outName, height = 2000, width = 2000, res = 300)
draw.pairwise.venn(area1, area2, cross.area, category=c(name1, name2), fill = c("dodgerblue3", "hotpink"), main="test", cat.cex=3, cat.just = list(c(.5, .5), c(.5, .5)), cat.dist=c(.02,.02), cat.default.pos="outer", cat.pos=c(0,180), cex=3)
dev.off()
#cat.cex=2 cex=1.5
