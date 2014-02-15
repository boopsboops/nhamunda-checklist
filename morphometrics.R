#clear memory
rm(list = ls())
#read in morpho table
tab <- read.table("/home/rupert/LaTeX/nhamunda-checklist/pseudolithoxus_morphometrics_table.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, row.names="Measurement")#?read.table , 
#remove landmark number, keep abbreviations and convert to Matrix
tab <- subset(tab, select=-Landmarks)

##check data is read in correctly
#class(tab)
#dim(tab)
#head(tab)
#tab$CTGA_14486
#tab["Standard_length",]
#rownames(tab)
#colnames(tab)


#subset body measurements, remove percents, and convert to matrix
body <- na.omit(tab[tab$Percents=="body",])
body2 <- as.matrix(subset(body, select=-Percents))
#selects the correct row with standard lengths
sl <- as.matrix(subset(tab["Standard_length",], select=-Percents))

#perform a 'sweep' over the columns to get the % of SL for each
slp <- sweep(body2, 2, sl, FUN="/") *100#?sweep

#plot
#boxplot(slp, use.cols = FALSE, cex.axis=0.6, las=2)#?boxplot?plot

#for head lengths
head <- na.omit(tab[tab$Percents=="head",])
head2 <- as.matrix(subset(head, select=-Percents))
hl <- as.matrix(subset(tab["Head_length",], select=-Percents))
hlp <- sweep(head2, 2, hl, FUN="/") *100
#boxplot(hlp, use.cols = FALSE, cex.axis=0.6, las=2)#?boxplot?plot

#combined boxplot
com <- rbind(slp, hlp)
#boxplot(com, use.cols = FALSE, cex.axis=0.6, las=2)#?boxplot?plot

#boxplot ordered by range
ran <- as.vector(apply(com, 1, sd))
ex <- as.data.frame(cbind(com,ran))
ex <- ex[order(ex$"ran", decreasing=TRUE),]
ex <- as.matrix(subset(ex, select=-ran))
par(mar=c(10,5,2,2))
boxplot(ex, use.cols = FALSE, cex.axis=0.6, las=2, ylab="percent of SL/HL sorted by standard devation")


#libraries to melt and use new boxplot
library(car)
library(reshape2)
#form data into 3 cols
mex <- melt(ex)#?melt
par(mar=c(10,5,2,2))
#boxplot with outliers annotated
Boxplot(mex$value~mex$Var1, data=mex, labels=as.character(mex$Var2), cex.axis=0.6, las=2)#?Boxplot #?par

#check the individual values
ex["Abdominal_length",]

