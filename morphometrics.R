#library(ggplot2)
#clear memory
rm(list = ls())
#read in morphho table
tab <- read.table("/home/rupert/LaTeX/nhamunda-checklist/pseudolithoxus_morphometrics_table.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, row.names="Measurement")#?read.table
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

body[1:21,]

apply(body, 2, function(x) x/tab[1,])




tg <- names(body) %in% "Percents"
body <- body[!tg]
#body <- as.matrix(body)


th <- names(tab) %in% "Percents"
tab <- tab[!th]

is.list(tab)

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

apply(subm, 2, function(x) (x/tab["Standard_length", ])*100)	

sub1 <- tab[2:24,3:12]

subm <- as.matrix(sub1)

rownames(subm)
colnames(subm)

dim(percs)

transpose(percs)

boxplot(percs, use.cols = FALSE)#?boxplot
