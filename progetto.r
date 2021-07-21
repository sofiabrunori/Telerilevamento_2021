
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








setwd("C:/lab/esame/")
library(raster)
library(raster)
library(ncdf4)
library(rgdal)
library(RStoolbox)
library(ggplot2)
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
plot(ER$B3, ER$B2, ER$B1, zlim=c(1,65454))
plotRGB(ER, r=3, g=2, b=1, stretch="lin")

prova<- brick("prova.jpeg")
plotRGB(prova, r=1, g=2, b=3) #così vedo l'immagine



pre<- raster("Balluvione.jpg")
pre<- brick("Balluvione.jpg")
plot(pre$Balluvione.1, pre$Balluvione.2, pre$Balluvione.3, zlim=c(0,255))
plotRGB(pre, r=3, g=2, b=1)
post<- brick("Aalluvione.jpg")
par(mfrow=c(1,2))
plotRGB(pre, main="situazione pre-alluvione")
plotRGB(post, main="situazione post-alluvione")
plot(pre$Balluvione.1)
plot(pre$Balluvione.2)
clA<- colorRampPalette(c("black","orchid","cyan","hotpink","lemonchiffon","turquoise","peachpuff")) (200)
DifBA <- post - pre
plot(DifBA)
plot(DifBA$layer.2, col=clA)
plot(DifBA$layer.1, DifBA$layer.2, DifBA$layer.3)
plotRGB(DifBA,r=1, g=2, b=3, colNA='white',scale= c(-255,255))
plotB<-plotRGB(pre, main="situazione pre-alluvione")
plotA<-plotRGB(post, main="situazione post-alluvione")
DifBA <- plotA - plotB
plot(DifBA, zlim=c(0,255), col=cls)
DifBA <- pre-post
plot(pre)
plot(pre$Balluvione.1, pre$Balluvione.2, pre$Balluvione.3)
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
levelplot(DifBA$layer.1, DifBA$layer.2, DifBA$layer.3)




T1996<- raster("1996.jpg")
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(T1996, col=clA )

pre<- raster("a.jpg")
pre<- brick("Balluvione.jpg")
post<- brick("Aalluvione.jpg")
plotRGB(pre)
Rb<-  pre$Balluvione.1
Gb<-  pre$Balluvione.2
Bb<-  pre$Balluvione.3
RGBb <- stack(Rb,Gb,Bb)
plotRGB(RGBb)

Ra<-  post$Aalluvione.1
Ga<-  post$Aalluvione.2
Ba<-  post$Aalluvione.3
RGBa <- stack(Ra,Ga,Ba)
plotRGB(RGBa)
plot(pre$Balluvione.1)
par(mfrow=c(1,2))
plotRGB(pre, main="situazione pre-alluvione")
plotRGB(post, main="situazione post-alluvione")

DifR<- Ra - Rb
DifG<- Ga - Gb
DifB<- Ba - Bb
RGBD <- stack(DifR,DifG,DifB)
plot(RGBD)
plotRGB(RGBD)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(DifG, col=cl, main='differenza nella banda verde tra post ed pre alluvione')
preclass <- unsuperClass(pre, nClasses= 2)
plot(preclass$map)
clclassA <- colorRampPalette(c("blue","pink"))(2)
clclassB <- colorRampPalette(c("pink","blue"))(2)
postclass<- unsuperClass(post, nClasses= 2)
plot(postclass$map)
par(mfrow=c(2,1))
plot(preclass$map, col=clclassB, main="pre")
plot(postclass$map, col=clclassA, main="post")
 freq(preclass$map)
    # value    count
#[1,]     1 11180627
#[2,]     2  1175667
p1 <- ggRGB(pre, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(post, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) 
spre <- 11180627 + 1175667
spre
#[1] 12356294
freq(postclass$map)
  #  value    count
#[1,]     1  1232993
#[2,]     2 11123301
spost <- 1232993 + 11123301
# [1] 12356294
proppre <- freq(preclass$map) / spre
            value      count
#[1,] 8.093041e-08 0.90485278
#[2,] 1.618608e-07 0.09514722
propost <- freq(postclass$map) / spost
#            value      count
#[1,] 8.093041e-08 0.09978664
#[2,] 1.618608e-07 0.90021336
cover <- c("suolo inondato","suolo")
percent_pre <- c(0.95, 90.48) #SB: la seconda colonna sono le percentuali 92, vanno messi i dati che vengono dal tuo pc
percent_post <- c(0.99, 90.02)
percentages <- data.frame(cover, percent_pre, percent_post)
percentages
#           cover percent_pre percent_post
#1 suolo inondato        0.95         0.99
#2          suolo       90.48        90.02
ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="green")
ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="green")
p1 <- ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="violet")
p2 <- ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="violet")
grid.arrange(p1, p2, nrow=1)
perc_inond <- c(0.95,0.99)
cover <- c("suolo inondato_pre","suolo inondato_post")
tab <- data.frame(perc_inond)
p1 <- ggplot(tab, aes(x=cover, y=perc_inond, color=cover)) + geom_bar(stat="identity", fill="light blue")
grid.arrange(p1, nrow=1)

