# Input data
args=commandArgs(trailingOnly=T)
name=as.character(args[1])
data=read.delim(args[2])
x = log(as.numeric(data[[1]])+1, 10)
y = log(as.numeric(data[[2]])+1, 10)
i=as.numeric(args[3])
j=as.numeric(args[4])
# Inputs for write.table
val_1=data[,1]
val_2=data[,2]
Cor=cor(x,y)
table=cbind(name,i,j,Cor)
head(table)

# Make scatterplot
#png(paste(name, "_scatterplot.png", sep=""))
#plot(x, y, xlab=paste("Rep", i, "log(FPKM+1)"), ylab=paste("Rep", j, "log(FPKM+1)"), main=paste("R = ", cor(x, y)))
#dev.off()

# Make write.table
write.table(table, file="Correlation_table.txt", quote=FALSE, append=TRUE, col.names=!file.exists("Correlation_table.txt"), row.names=FALSE)
