#clear memory
#rm(list = ls())
#### rgbif analysis
# to install 
# library(devtools)
# install_github("rgbif", "ropensci")
library(rgbif)#currently 0.5.0 (04-03-14)
library(rjson)
# citation("rgbif")

# ask for key for Siluriformes
key <- name_backbone(name='Siluriformes')$orderKey
# count number of Siluriformes records
maxrecs <- occ_count(nubKey = key)
# retrieve all Siluriformes records (takes long time)
se <- occ_search(taxonKey=key, return="data", fields="all", limit=maxrecs)# ?occ_search
# save and load the data
# save(se, file = "/media/1TB/auto_backed_up/LaTeX/nhamunda-checklist/gbif_search_240432max_04-03-14.RData")
load("/media/1TB/auto_backed_up/LaTeX/nhamunda-checklist/gbif_search_240432max_04-03-14.RData")

# inspect the data
nrow(se)
head(se)
tail(se)
head(se$locality)

# grep in the localities field for text strings of the river names
# searches in both "species" and "names" fields for non-duplicated records
gbT <- unique(c(as.vector(na.omit(se$species[grep('Trombetas', se$locality, ignore.case=TRUE)])), as.vector(na.omit(se$name[grep('Trombetas', se$locality, ignore.case=TRUE)]))))#has genus and family level names and repeated names with authors (remove later)
gbU <- unique(c(as.vector(na.omit(se$species[grep('Uatum', se$locality, ignore.case=TRUE)])), as.vector(na.omit(se$name[grep('Uatum', se$locality, ignore.case=TRUE)]))))
gbN <- unique(c(as.vector(na.omit(se$species[grep('Nhamund', se$locality, ignore.case=TRUE)])), as.vector(na.omit(se$name[grep('Nhamund', se$locality, ignore.case=TRUE)]))))




#### Rfishbase analysis
# library(devtools)
# install_github("rfishbase", "ropensci")
library(rfishbase)
# updateCache(path = "/home/rupert/R/Programs/rfishbase/")#?updateCache
# currrently using '2013-10-18fishdata.Rdat'
# mv the '2013-10-18fishdata.Rdat' into '/rfishbase/data/fishbase.rda'
# citation("rfishbase")#currently 0.2-2
data(fishbase)# ?which_fish
length(fish.data)# length before update 30970

# get Siluriformes names
sil <- which_fish("Siluriformes", using="Order", fish.data)

# Trombetas species list using fishbase
tro <- which_fish("Trombetas", using="distribution", fish.data)
fbT <- as.vector(fish_names(fish.data[tro])[fish_names(fish.data[tro]) %in% fish_names(fish.data[sil])])

# Uatuma species list using fishbase
uat <- which_fish("Uatum", using="distribution", fish.data)
fbU <- as.vector(fish_names(fish.data[uat])[fish_names(fish.data[uat]) %in% fish_names(fish.data[sil])])

# Nhamunda species list using fishbase
nha <- which_fish("Nhamund", using="distribution", fish.data)
fbN <- as.vector(fish_names(fish.data[nha])[fish_names(fish.data[nha]) %in% fish_names(fish.data[sil])])


#### open names from Checklist of Catfishes and Catalog of fishes
tab <- read.table("/home/rupert/LaTeX/nhamunda-checklist/checklist_records.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)# ?read.table

chT <- as.vector(na.omit(tab$Trombetas))
chU <- as.vector(na.omit(tab$Uatuma))
chN <- as.vector(na.omit(tab$Nhamunda))




#### final counts
# cleanup to leave just species level data without authors
# only for Trombetas and Uatuma. Nhamunda contains no species level data
cT <- grep("[A-Z][a-z]* [a-z]*$", gsub(" [^a-z].*$", "", c(fbT, gbT, chT), fixed=FALSE), fixed=FALSE, value=TRUE)
cU <- grep("[A-Z][a-z]* [a-z]*$", gsub(" [^a-z].*$", "", c(fbU, gbU, chU), fixed=FALSE), fixed=FALSE, value=TRUE)

#make counts
unique(sort(cT))# species count for Trombetas: 44 species
unique(sort(cU))# species count for Uatuma: 5 species
c(fbN, gbN, chN)# count for Nhamunda: 1 genus