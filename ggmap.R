require(ggmap)

mapImageData1 <- get_map(location = c(lon = -57.36856, lat = -1.71782),  color = "color",    source = "google",    maptype = "terrain",    zoom = 10)

m <- ggmap(mapImageData1, extent = "panel", ylab = "Latitude", xlab = "Longitude") 
m + geom_point(aes(x = deg_long, y = deg_lat), colour = "blue", size=10, data = gps)

?geom_point

aes=(na.omit(gps)[,2], na.omit(gps)[,3])
gps <- read.table(file="/home/rupert/LaTeX/nhamunda-checklist/site_gps.csv", sep=",", header=TRUE)

gps <- na.omit(gps)


?get_map
?ggmap

go <- geocode("faro")

df <- round(data.frame(x = jitter(rep(-95.36, 50), amount = .3), y = jitter(rep( 29.76, 50), amount = .3)), digits = 2)