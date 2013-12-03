#to install 
#library(devtools)
#install_github("rgbif", "ropensci")
library(rgbif)

#?occ_search
key <- name_backbone(name='Tapirus terrestris')$speciesKey
se <- occ_search(taxonKey=key, return='all', limit=10000, minimal=FALSE)# ?occ_search
tail(se)
dat <- occ_search(scientificname = "Tapirus terrestris", coordinatestatus = TRUE)
gbifmap_list(dat)




key <- name_backbone(name='Siluriformes')$orderKey
se <- occ_search(taxonKey=key, return='all', minimal=FALSE, limit=100000)# ?occ_search #country = 'BR', 
head(se)
length(se$data$species)
se$data$locality
se$data$species[grep('Columbia', se$data$locality)]

#Rfishbase analysis
library(rfishbase)
data(fishbase)
length(fish.data)

tdi <- which_fish("Nhamund<c3><a1>", using="distribution", fish.data)
tdi <- which_fish("Nhamunda", using="distribution", fish.data)
#tdi <- which_fish("Tapaj<c3><b3>s", using="distribution", fish.data)
fam <- which_fish("Doradidae", using="Family", fish.data)

fish_names(fish.data[tdi])