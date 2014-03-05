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
gbT <- unique(c(as.vector(na.omit(se$species[grep('Trombetas', se$locality, ignore.case=TRUE)])), as.vector(na.omit(se$name[grep('Trombetas', se$locality, ignore.case=TRUE)]))))
gbU <- unique(c(as.vector(na.omit(se$species[grep('Uatum', se$locality, ignore.case=TRUE)])), as.vector(na.omit(se$name[grep('Uatum', se$locality, ignore.case=TRUE)]))))
gbN <- unique(c(as.vector(na.omit(se$species[grep('Nhamund', se$locality, ignore.case=TRUE)])), as.vector(na.omit(se$name[grep('Nhamund', se$locality, ignore.case=TRUE)]))))


#### Rfishbase analysis
# library(devtools)
# install_github("rfishbase", "ropensci")
library(rfishbase)
#updateCache(path = "/home/rupert/R/Programs/rfishbase/")#?updateCache
loadCache(path="/home/rupert/R/Programs/rfishbase")#?loadCache
# citation("rfishbase")#currently 0.2-2
data(fishbase)# ?which_fish
length(fish.data)# length before update 30970

# get Siluriformes names
sil <- which_fish("Siluriformes", using="Order", fish.data)

##
# FINAL Trombetas species list using BOTH gbif and fishbase
tro <- which_fish("Trombetas", using="distribution", fish.data)
fbT <- as.vector(fish_names(fish.data[tro])[fish_names(fish.data[tro]) %in% fish_names(fish.data[sil])])

# FINAL Uatuma species list using BOTH gbif and fishbase
uat <- which_fish("Uatum", using="distribution", fish.data)
fbU <- as.vector(fish_names(fish.data[uat])[fish_names(fish.data[uat]) %in% fish_names(fish.data[sil])])

# FINAL Nhamunda species list using BOTH gbif and fishbase
nha <- which_fish("Nhamund", using="distribution", fish.data)
fbN <- as.vector(fish_names(fish.data[nha])[fish_names(fish.data[nha]) %in% fish_names(fish.data[sil])])


## open names from Checklist of Catfishes and Catalog of fishes

tab <- read.table("/home/rupert/LaTeX/nhamunda-checklist/checklist_records.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)#?read.table , 

chT <- as.vector(na.omit(tab$Trombetas))
chU <- as.vector(na.omit(tab$Uatuma))
chN <- as.vector(na.omit(tab$Nhamunda))

#final cleanup and counts
unique(c(fbT, gbT, chT))# species count for Trombetas: 37 (49-12)
unique(c(fbU, gbU, chU))# count for Uatuma: 5 species
unique(c(fbN, gbN, chN))# count for Nhamunda: 1 genus


g1 <- grep(" ", gbT, value=TRUE)
grep("\\(", g1, value=TRUE, invert=TRUE)

#clear memory
rm(list = ls())