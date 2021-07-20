
setwd("C:/lab/esame/")
library(raster)
library(raster)
library(ncdf4)
library(rgdal)
library(RStoolbox)
library(ggplot2)
coastlines <- readOGR("ne_10m_coastline.shp")
rlist=list.files(pattern="temp", full.names=T)
list_temp =lapply(rlist, raster)
land_t <- stack(list_temp)rlist=list.files(pattern="temp", full.names=T)
list_temp =lapply(rlist, raster)
land_t <- stack(list_temp)
cl <- colorRampPalette(c('cyan', 'purple', 'red')) (300)
plot(land_t,col=cl,main="T° dal 2012 al 2020", adj=0.5, zlim=c(0,5))
plot(coastlines)
t_2020 <- raster("temp_2020.nc")
t_2012 <- raster("temp_2012.nc")
difT <- t_2020-t_2012
cldiff <- colorRampPalette(c('blue','orange','red'))(100)
plot(difT, col=cldiff, main= "grafico differenza tra l'anno 2020 e 2012")
plot(coastlines, add=T)

t_2020 <- raster("temp_2020.nc")
t_2012 <- raster("temp_2012.nc")
par(mfrow=c(2,1))
plot(t_2020, col=cl, main="temperatura 2020",zlim=c(0,5))
plot(coastlines, add=T)
plot(t_2012, col=cl, main="temperatura 2012",zlim=c(0,5))
plot(coastlines, add=T)















banda_1 <-raster("B1.TIF")
banda_2 <-raster("B2.TIF")
banda_3 <-raster("B3.TIF")
banda_4 <-raster("B4.TIF")
banda_5 <-raster("B5.TIF")
banda_6 <-raster("B6.TIF")
rlist=list.files(pattern=".TIF", full.names=T)
list =lapply(rlist, raster)
ER <- brick(list)
plot(ER)
plot(ER$B1, ER$B2, ER$B3, zlim=c(1,65454))
plotRGB(ER, r=1, g=2, b=3, stretch="lin")

prova<- brick("prova.jpeg")
