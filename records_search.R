#to install 
#library(devtools)
#install_github("rgbif", "ropensci")
library(rgbif)
library(rjson)

#?occ_search

key <- name_backbone(name='Siluriformes')$orderKey
se <- occ_search(taxonKey=key, return='data', minimal=FALSE, limit=150000)# ?occ_search #country = 'BR', 
head(se)
nrow(se)
se$locality
se$species[grep('Trombetas', se$locality)]

fy <- occ_search(search="Nhamund", return='data', minimal=FALSE, limit=100)


#Rfishbase analysis
library(rfishbase)
data(fishbase)
length(fish.data)

tdi <- which_fish("Nhamund<c3><a1>", using="distribution", fish.data)
tdi <- which_fish("Nhamunda", using="distribution", fish.data)
#tdi <- which_fish("Tapaj<c3><b3>s", using="distribution", fish.data)
fam <- which_fish("Doradidae", using="Family", fish.data)

fish_names(fish.data[tdi])