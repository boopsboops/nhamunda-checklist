#library(ggplot2)
#clear memory
rm(list = ls())
#read in morphho table
tab <- read.table("/home/rupert/LaTeX/nhamunda-checklist/pseudolithoxus_morphometrics_table.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, row.names="Measurement")#?read.table , 
#remove landmark number, keep abbreviations and convert to Matrix
tab <- subset(tab, select=-Landmarks)

#tab <- tab[,-1]#?as.matrix


#class(tab)
#dim(tab)
#check data is read in correctly
head(tab)
tab$CTGA_14486
tab["Standard_length",]
rownames(tab)
colnames(tab)


#subset body measurements
#yes, yes, I know this can be done easier with [x:y,] but there's less scope for mistakes
body <- tab[tab$Percents=="body",]
body <- subset(body, select=-Percents)
tab <- subset(tab, select=-Percents)

apply(as.matrix(body), 1, function(xx) xx / tab["Standard_length",])


#working!
mat <- apply(hj, 1, function(xx) (xx / pc)*100)

hj <- as.matrix(body)
pc <- as.matrix(tab["Standard_length",])

rownames(hj) <- NULL
rownames(pc) <- NULL

colnames(hj) <- NULL
colnames(pc) <- NULL

colnames(mat) <- rownames(body)


kk <- tab[== "PL", "HL",] / tab["SL",]
class(kk)
str(kk)
#subset to smaller frame
tabsm <- tab[, 3:12]

divs <- (tab[2,]/tab[1,3:12])*100

tab[1, 1:10]/2
tab[, ]


tab$Landmarks



percs <- 

apply(subm, 1:2, function(x) x / tab[1, 2:11])	

sub1 <- tab[2:24,2:11]

subm <- as.matrix(sub1)

subm[1,]

rownames(subm) <- NULL
colnames(subm)

dim(percs)


boxplot(mat, use.cols = TRUE, cex.axis=0.4)#?boxplot?plot


31.6/72.6
22.1/98.9