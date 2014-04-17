# rm(list = ls())

# open table
tab <- read.table("/home/rupert/LaTeX/nhamunda-checklist/seq_siluriformes_nhamunda.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# subset the sequenced individuals
stab <- tab[tab$to_sequence == "sequence",]


### for the FASTA

# assemble the fasta names
nam <- paste(">", gsub("UFAM:CTGA:", "", stab$occurrenceID), " ", "[organism=", stab$genus, " ", stab$specificEpithet, "]", sep="")

# add the DNA seq and the newline sep
com <- paste(nam, stab$sequence, sep="\n")

#export the file
write(com, file="file")#?write


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
))

# change the headers to GenBank format
names(frm) <- c("Sequence_ID", "Collected_by", "Collection_date", "Country", "Identified_by", "Lat_Lon", "Specimen_voucher", "Bio_material")

# export
write.table(frm, file="table", sep="\t", row.names=FALSE, quote=FALSE)#?write.table


### for the PRIMERS

# create a new dataframe
prm <- data.frame(cbind(
gsub("UFAM:CTGA:", "", stab$occurrenceID), 
rep("GGGGGGGGGGGGGG", length(stab$occurrenceID)),#fwd primer seq
rep("CCCCCCCCCCCCCC", length(stab$occurrenceID)),#rev primer seq
rep("primer_fwd", length(stab$occurrenceID)),#fwd primer name
rep("primer_rev", length(stab$occurrenceID))#rev primer name
))

# change the headers to GenBank format
names(prm) <- c("Sequence_ID", "fwd_primer_seq", "rev_primer_seq", "fwd_primer_name", "rev_primer_name")

# export
write.table(prm, file="primers", sep="\t", row.names=FALSE, quote=FALSE)


### for the TRACES

# create a new dataframe
trm <- data.frame(rbind(
cbind(gsub("UFAM:CTGA:", "", stab$occurrenceID), 
paste("traces", stab$trace_FWD, sep="/"),
rep("ABI", length(stab$occurrenceID)),
rep("legal_nhamunda", length(stab$occurrenceID)),
rep("Geneious", length(stab$occurrenceID)),
rep("F", length(stab$occurrenceID))),
cbind(gsub("UFAM:CTGA:", "", stab$occurrenceID), 
paste("traces", stab$trace_REV, sep="/"),
rep("ABI", length(stab$occurrenceID)),
rep("legal_nhamunda", length(stab$occurrenceID)),
rep("Geneious", length(stab$occurrenceID)),
rep("R", length(stab$occurrenceID)))
))

# change the headers to GenBank format
names(trm) <- c("Template_ID", "Trace_file", "Trace_format", "Center_project", "Program_ID", "Trace_end")

# export
write.table(trm, file="traces", sep="\t", row.names=FALSE, quote=FALSE)