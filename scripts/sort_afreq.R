data <- read.table("variants50.af", header=FALSE)
contigs <- unique(data$V1)

rare <- data[data$V3 > 0.95 | data$V3 <0.05,]
length(unique(rare$V1))
contigs.rare <- unique(rare$V1)

rare.loci <- matrix(NA,nrow=length(contigs.rare), ncol=1)

for(i in 1:length(contigs.rare)){
	sites <- rare[rare$V1 == contigs.rare[i],]
##	rand <- round(runif(1, min=1, max=length(sites$V1)))
	rand <- sample(1:length(sites$V1), 1)   
	tmp <- as.character(sites$V2[rand])
	rare.loci[i,1] <- tmp

}
write.table(rare.loci,file="rare.loci.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

common <- data[data$V3 <= 0.95 & data$V3>=0.05, ]
length(unique(common$V1))

contigs.common <- unique(common$V1)

common.loci <- matrix(NA,nrow=length(contigs.common), ncol=1)

for(i in 1:length(contigs.common)){
	sites <- common[common$V1 == contigs.common[i],]
##	rand <- round(runif(1, min=1, max=length(sites$V1)))
	rand <- sample(1:length(sites$V1), 1)   
	tmp <- as.character(sites$V2[rand])
	common.loci[i,1] <- tmp

}
write.table(common.loci,file="common.loci.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)
