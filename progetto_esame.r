
setwd("C:/lab/esame/")
library(raster)
library(ncdf4)
library(rgdal)
library(rasterVis)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
pre<- brick("prima.jpg")
post<- brick("dopo.jpg")
par(mfrow=c(2,1))
plotRGB(pre)
plotRGB(post)


par(mfrow=c(3,2))
plot(pre$prima.1)
plot(pre$prima.2)
plot(pre$prima.3)
plot(post$dopo.1)
plot(post$dopo.2)
plot(post$dopo.3)
plotRGB(pre)
Rb<-  pre$prima.1
Gb<-  pre$prima.2
Bb<-  pre$prima.3
RGBb <- stack(Rb,Gb,Bb)
plotRGB(RGBb)
Ra<-  post$dopo.1
Ga<-  post$dopo.2
Ba<-  post$dopo.3
RGBa <- stack(Ra,Ga,Ba)
DifR<- Ra - Rb
DifG<- Ga - Gb
DifB<- Ba - Bb
RGBD <- stack(DifR,DifG,DifB)
par(mfrow=c(3,1))
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(DifG, col=cl, main="differenza nella banda verde tra post ed pre alluvione")
plot(DifR, col=cl, main="differenza nella banda verde tra post ed pre alluvione")
plot(DifB, col=cl, main="differenza nella banda verde tra post ed pre alluvione")
###############################################################################################
preclass <- unsuperClass(pre, nClasses= 3)
clclassp <- colorRampPalette(c("pink","green","blue"))(3)
plot(preclass$map, col=clclassp, main= "situazione pre alluvione")
postclass<- unsuperClass(post, nClasses= 3)
clclassd <- colorRampPalette(c("pink","blue","green"))(3)
plot(postclass$map, col=clclassd, main= "situazione post alluvione")
par(mfrow=c(2,1))
plot(preclass$map, col=clclassp, main= "situazione pre alluvione")
plot(postclass$map, col=clclassd, main= "situazione post alluvione")
############################################################################################


freq(preclass$map)
#    value  count
#[1,]     1 147142
#[2,]     2 259492
#[3,]     3  25366
freq(postclass$map)
#    value  count
#[1,]     1 108539
#[2,]     2  43419
#[3,]     3 280042


#############################################################################
p1 <- ggRGB(pre, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(post, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) 
#######################################################################


spre <- 147142 + 259492 + 25366
spost <- 108539 + 43419 + 280042
proppre <- freq(preclass$map) / spre
 #          value      count
#[1,] 2.314815e-06 0.34060648
#[2,] 4.629630e-06 0.60067593
#[3,] 6.944444e-06 0.05871759

proppost <- freq(postclass$map) / spost
 #          value     count
#[1,] 2.314815e-06 0.2512477
#[2,] 4.629630e-06 0.1005069
#[3,] 6.944444e-06 0.6482454

cover <- c("suolo inondato","suolo")
percent_pre <- c(5.9, 94.1) 
percent_post <- c(10, 90)
percentages <- data.frame(cover, percent_pre, percent_post)
percentages
#         cover percent_pre percent_post
#1 suolo inondato         5.9           10
#2          suolo        94.1           90

ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="springgreen3")
ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="darkolivgreen1")

percent1 <- ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="springgreen3")
percent2 <- ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="darkolivegreen1")
grid.arrange(percent1, percent2, nrow=1)

######################################################################################################################################################

perc_inond <- c(5.9,10)
cover <- c("suolo inondato_pre","suolo inondato_post")
tab <- data.frame(perc_inond)
p1 <- ggplot(tab, aes(x=cover, y=perc_inond, color=cover)) + geom_bar(stat="identity", fill="seagreen4")
grid.arrange(p1, nrow=1)


clpie<- colorRampPalette(c("thistle","lightgreen"))(2)
par(mfrow=c(1,2))
piepre <-pie(percent_pre, main="Diagramma a torta",labels=" situazione pre-alluvione" ,col=clpie)
piepost <-pie(percent_post, main="Diagramma a torta",labels=" situazione post-alluvione" ,col=clpie)


####################################################################################################################################################

banda_1 <-raster("SR_B1.TIF")
banda_2 <-raster("SR_B2.TIF")
banda_3 <-raster("SR_B3.TIF")
banda_4 <-raster("SR_B4.TIF")
banda_5 <-raster("SR_B5.TIF")
banda_6 <-raster("SR_B6.TIF")
banda_7 <-raster("SR_B7.TIF")
rlist <- list.files(pattern="SR_B")
import <- lapply(rlist,raster)
Bande <- stack(import)
plot(Bande, main=" bande della zona analizzata in precedenza")
plotRGB(Bande, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,2))
clB<- colorRampPalette(c("black","blue","light blue","light grey")) (200)
clV<- colorRampPalette(c("black","green","light green","light grey")) (200)
clR<- colorRampPalette(c("black","red","coral","yellow")) (200)
clNIR<- colorRampPalette(c("black","cyan","hotpink")) (200)
plot(Bande$SR_B2, col=clB, main="Banda del blu")
plot(Bande$SR_B3, col=clV,  main="Banda del verde")
plot(Bande$SR_B4, col=clR,  main="Banda del rosso")
plot(Bande$SR_B5, col=clNIR, main="Banda del vicino-infrarosso")

########################################################################################################################################################
   #crop per vedere un focus in rgb della zona affetta da inondazione


extension <- c(676000,725000 , 5660000, 5700000)
bandecut<- crop(Bande, extension)
plotRGB(bandecut, r=4, g=3, b=2, stretch="Lin")

##################################################################################################################################


#calcolo dvi


dvi <- Bande$SR_B5- Bande$SR_B4
cldvi <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi, col=cldvi, main="Calcolo DVI tramite la sottrazione della banda 4 alla 5")

plot(dvi, col=cl)
#calcolo NDVI
#SB:NDVI=(NIR-RED) / (NIR+RED)

ndvi <- dvi / (Bande$SR_B5+ Bande$SR_B4)
clndvi <- colorRampPalette(c('grey','lightgreen','darkgreen'))(50)
plot(ndvi, col=clndvi,main="Calcolo NDVI (DVI normalizzato)")

######################################################################################################################################################c

 #SB: mi mostra la correlazione tra tutte le bande e anche il valore di Pearson
banderes  aggregate(Bande, fact=10) 
banderes 
plotRGB(banderes, r=4, g=3, b=2, stretch="Lin") 
pairs(banderes)


vi<- spectralIndices(banderes, green = 3, red = 4, nir = 5) 
clvi <- colorRampPalette(c('cyan', 'purple', 'red')) (300)
plot(vi, col=clvi, title="calcolo dei diversi vegetation index")


#############################################################################################################

library(rasterVis)
cllp <- colorRampPalette(c("yellow", "goldenrod", "orangered","mediumorchid","palevioletred4" ,"coral", "darkred")) (1000)
levelplot(Bande,col.regions=cllp, main="Bande dell'immagine Landsat", names.attr=c("Banda1","Banda2", "Banda3", "Banda4", "Banda5", "Banda6", "Banda7"))

banderesres_pca <- rasterPCA(banderes)
summary(banderesres_pca$model)
Importance of components:
#                             Comp.1       Comp.2       Comp.3       Comp.4
#Standard deviation     5810.8960397 2452.0487947 1.078454e+03 3.909446e+02
#Proportion of Variance    0.8195438    0.1459299 2.822861e-02 3.709509e-03
#Cumulative Proportion     0.8195438    0.9654736 9.937022e-01 9.974117e-01
#                             Comp.5       Comp.6       Comp.7
#Standard deviation     3.035012e+02 1.125988e+02 4.299972e+01
#Proportion of Variance 2.235666e-03 3.077183e-04 4.487631e-05
#Cumulative Proportion  9.996474e-01 9.999551e-01 1.000000e+00
plotRGB(banderesres_pca$map,r=4, g=3, b=2, stretch="lin")

