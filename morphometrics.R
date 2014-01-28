
#read in morphho table
tab <- read.table("/media/1TB/auto_backed_up/LaTeX/nhamunda-checklist/pseudolithoxus_morphometrics_table.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#check data is read in correctly
head(tab)
tab$Landmark
tab$Measurement
tab$CTGA_14486