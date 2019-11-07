# Get worldclim data for populations based on their GPS locations
# assumes we already downloaded and decompressed the worldclim current climate layers at the finest resolution available (30 arcseconds) from http://www.worldclim.org/current

library(raster); library(sp)

# read in locations and create a SpatialPoints object
pops = read.csv("GPS_coords.csv")
poplocs = SpatialPoints(pops[,c("Longitude", "Latitude")])

# use extract() to get values from the Worldclim rasters at these locations
r = raster("./wc2/wc2.0_bio_30s_01.tif")
pops$mean_ann_temp = extract(r, poplocs)
r = raster("./wc2/wc2.0_bio_30s_04.tif")
pops$temp_seasonality = extract(r, poplocs)
r = raster("./wc2/wc2.0_bio_30s_12.tif")
pops$mean_ann_precip = extract(r, poplocs)
r = raster("./wc2/wc2.0_bio_30s_15.tif")
pops$precip_seasonality = extract(r, poplocs)

write.csv(pops, "population_worldclim_data.csv")
