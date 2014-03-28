# load ggmap and ggplot
require(ggmap)

# read gps data
gps <- read.table(file="/home/rupert/LaTeX/nhamunda-checklist/site_gps.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)

# get a base map from google
mapImageData1 <- get_map(location=c(lon=-57.05, lat=-1.99), color="color", source="google", maptype="terrain", zoom=10)
# create map
m <- ggmap(mapImageData1, extent="panel") 
# plot, and add points and text
m + geom_point(data=gps, aes(x=deg_long, y=deg_lat), colour="black", shape=21, bg="orange", size=5, alpha=0.55, na.rm=TRUE) + geom_text(data=gps, aes(x=deg_long, y=deg_lat, label=site_code), colour="grey20", size=3, fontface=2, vjust=-1, hjust=-0.1, na.rm=TRUE) + labs(x=NULL, y=NULL) 
#save
ggsave(file="testmap.png", width=8, height=8, dpi = 150)

?geom_point
?get_map
?ggmap
?geom_text
