
setwd("C:/lab/esame/")
library(raster)
library(raster)
library(ncdf4)
library(rgdal)
library(RStoolbox)
library(ggplot2)
pre<- brick("prima.jpg")
post<- brick("dopo.jpg")
par(mfrow=c(2,1))
plotRGB(pre, main="situazione pre inondazione")
plotRGB(post, main="situazione post inondazione")
plot(pre$prima.1, main="situazione pre inondazione")
plot(pre$prima.2)
plot(pre$prima.3)
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
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
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
    value  count
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
            value     count
#[1,] 2.314815e-06 0.2512477
#[2,] 4.629630e-06 0.1005069
#[3,] 6.944444e-06 0.6482454

cover <- c("suolo inondato","suolo")
percent_pre <- c(5.9, 94.1) #SB: la seconda colonna sono le percentuali 92, vanno messi i dati che vengono dal tuo pc
percent_post <- c(10, 90)
percentages <- data.frame(cover, percent_pre, percent_post)
percentages
 #         cover percent_pre percent_post
#1 suolo inondato         5.9           10
#2          suolo        94.1           90
ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="green")
ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="green")
p1 <- ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1)
######################################################################################################################################################
perc_inond <- c(5.9,10)
cover <- c("suolo inondato_pre","suolo inondato_post")
tab <- data.frame(perc_inond)
p1 <- ggplot(tab, aes(x=cover, y=perc_inond, color=cover)) + geom_bar(stat="identity", fill="light blue")
grid.arrange(p1, nrow=1)

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
pdf(Tutte_le_bande)
plot(Bande, main="bande della zona analizzata in precedenza")
q()
plotRGB(Bande, r=4, g=3, b=2, stretch="Lin")
pdf("Bande.pdf")
par(mfrow=c(2,2))
clB<- colorRampPalette(c("black","blue","light blue","light grey")) (200)
clV<- colorRampPalette(c("black","green","light green","light grey")) (200)
clR<- colorRampPalette(c("black","red","coral","yellow")) (200)
clNIR<- colorRampPalette(c("black","cyan","hotpink")) (200)
plot(Bande$SR_B2, col=clB, main="Banda del blu")
plot(Bande$SR_B3, col=clV,  main="Banda del verde")
plot(Bande$SR_B4, col=clR,  main="Banda del rosso")
plot(Bande$SR_B5, col=clNIR, main="Banda del vicino-infrarosso")
q()

########################################################################################################################################################
   
#calcolo dvi
dvi <- Bande$SR_B5- Bande$SR_B4
cldvi <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi, col=cldvi, main="Calcolo DVI tramite la sottrazione della banda 4 alla 5")
clndvi <- colorRampPalette(c('darkblue','lightbue','lillac','hotpink'))(100)
plot(dvi, col=cl)
#calcolo NDVI
#SB:NDVI=(NIR-RED) / (NIR+RED)
ndvi <- dvi / (Bande$SR_B5+ Bande$SR_B4)
clndvi <- colorRampPalette(c('darkblue','lightblue','violet','hotpink'))(100)
plot(ndvi, col=clndvi, zlim=c(0,1),main="Calcolo NDVI (DVI normalizzato))

#######################################################################################################################################################

pairs(Bande) #SB: mi mostra la correlazione tra tutte le bande e anche il valore di Pearson
banderes <- aggregate(Bande, fact=10) #SB: meglio ricampionare l'immagine con aggregate (in pratica abbasso la risoluzione) per evitare che le funzioni dopo impieghino troppo tempo
banderes #SB: con fattore 10 la sisuluzione è passata da 30 a 300
 plotRGB(banderes, r=4, g=3, b=2, stretch="Lin") 
vi<- spectralIndices(banderes, green = 3, red = 4, nir = 5) #???????
plot(vi)
#############################################################################################################

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
p1 <- ggplot(percentages, aes(x=cover, y=percent_pre, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_post, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1)
perc_inond <- c(0.95,0.99)
cover <- c("suolo inondato_pre","suolo inondato_post")
tab <- data.frame(perc_inond)
p1 <- ggplot(tab, aes(x=cover, y=perc_inond, color=cover)) + geom_bar(stat="identity", fill="light blue")
grid.arrange(p1, nrow=1)
plot (p224r63_2011),col=cls)


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
plotRGB(Bande, r=3, g=2, b=1, stretch="Lin")
plotRGB(Bande, r=4, g=3, b=2, stretch="Lin")
pdf("Bande.pdf")
par(mfrow=c(2,2))
clB<- colorRampPalette(c("black","blue","light blue","light grey")) (200)
clV<- colorRampPalette(c("black","green","light green","light grey")) (200)
clR<- colorRampPalette(c("black","red","coral","yellow")) (200)
clNIR<- colorRampPalette(c("black","cyan","hotpink")) (200)
plot(Bande$SR_B2, col=clB, main="Banda del blu")
plot(Bande$SR_B3, col=clV,  main="Banda del verde")
plot(Bande$SR_B4, col=clR,  main="Banda del rosso")
plot(Bande$SR_B5, col=clNIR, main="Banda del vicino-infrarosso")
q()



