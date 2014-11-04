# rm(list = ls())
require("ape")

# open table
tab <- read.table("/home/rupert/Projects/nhamunda-checklist/seq_siluriformes_nhamunda.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# subset the sequenced individuals
stab <- tab[tab$to_sequence == "sequence",]


## NJ tree check

nam <- paste(">", gsub("UFAM:CTGA:", "", stab$occurrenceID), "|", stab$genus, "_", stab$specificEpithet, sep="")
com <- paste(nam, stab$sequence, sep="\n")
write(com, file="/home/rupert/Projects/nhamunda-checklist/sequences/nhamunda_seqs.fas")
#align externally
ns <- read.dna(file="/home/rupert/Projects/nhamunda-checklist/sequences/nhamunda_seqs_aligned.fasta", format="fasta")
plot(nj(dist.dna(ns, model="raw", pairwise.deletion=TRUE)))


### for the FASTA

# assemble the fasta names
nam <- paste(">", gsub("UFAM:CTGA:", "", stab$occurrenceID), " ", "[organism=", stab$genus, " ", stab$specificEpithet, "]", sep="")

# add the DNA seq and the newline sep
com <- paste(nam, stab$sequence, sep="\n")

#export the file
write(com, file="/home/rupert/LaTeX/nhamunda-checklist/genbank/sequences.fasta")#?write


### for the SOURCE MODIFIERS

# create a new dataframe
frm <- data.frame(cbind(
gsub("UFAM:CTGA:", "", stab$occurrenceID), 
rep("Valéria Nogueira Machado, Emanuell Duarte Ribeiro, Rupert A. Collins", length(stab$occurrenceID)), 
rep("Nov-2013", length(stab$occurrenceID)), 
rep("Brazil", length(stab$occurrenceID)), 
rep("Rupert A. Collins", length(stab$occurrenceID)), 
paste(gsub("-", "", stab$decimalLatitude), " S ", gsub("-", "", stab$decimalLongitude), " W", sep=""),
stab$catalogNumber,
stab$occurrenceID
), stringsAsFactors = FALSE)

# change the headers to GenBank format
names(frm) <- c("Sequence_ID", "Collected_by", "Collection_date", "Country", "Identified_by", "Lat_Lon", "Specimen_voucher", "Bio_material")

# export
write.table(frm, file="/home/rupert/LaTeX/nhamunda-checklist/genbank/source_mod_table.txt", sep="\t", row.names=FALSE, quote=FALSE)#?write.table


### for the PRIMERS

# create a new dataframe
prm <- data.frame(cbind(
gsub("UFAM:CTGA:", "", stab$occurrenceID), 
rep("TCAACCAACCACAAAGACATTGGCAC", length(stab$occurrenceID)),#fwd primer seq
rep("ACTTCAGGGTGACCGAAGAATCAGAA", length(stab$occurrenceID)),#rev primer seq
rep("FishF1", length(stab$occurrenceID)),#fwd primer name
rep("FishR2", length(stab$occurrenceID))#rev primer name
), stringsAsFactors = FALSE)

# change the headers to GenBank format
names(prm) <- c("Sequence_ID", "fwd_primer_seq", "rev_primer_seq", "fwd_primer_name", "rev_primer_name")

# export
write.table(prm, file="/home/rupert/LaTeX/nhamunda-checklist/genbank/primers.txt", sep="\t", row.names=FALSE, quote=FALSE)

#check names are same
#sort(gsub("UFAM:CTGA:", "", stab$occurrenceID)) == sort(unique(sapply(strsplit(fl, split="_"), function(x) x[2])))


### for the TRACES

#open the trace file dir
fl <- list.files(path="/home/rupert/LaTeX/nhamunda-checklist/genbank/traces")

trm <- data.frame(cbind(
sapply(strsplit(fl, split="_"), function(x) x[2]),
paste("traces", fl, sep="/"),
rep("ABI", length(fl)),
rep("legal_nhamunda", length(fl)),
rep("Geneious", length(fl)),
rep(NA, length(fl))
), stringsAsFactors = FALSE)

# change the headers to GenBank format
names(trm) <- c("Template_ID", "Trace_file", "Trace_format", "Center_project", "Program_ID", "Trace_end")

#add the forward or reverse code
trm$Trace_end[grep("R", sapply(strsplit(as.character(trm$Trace_file), split="_"), function(x) x[3]))] <- "R"
trm$Trace_end[grep("F", sapply(strsplit(as.character(trm$Trace_file), split="_"), function(x) x[3]))] <- "F"

# export
write.table(trm, file="/home/rupert/LaTeX/nhamunda-checklist/genbank/traces.txt", sep="\t", row.names=FALSE, quote=FALSE)