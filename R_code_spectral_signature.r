
# SB: a questo link trovo 
#https://www.neonscience.org/resources/learning-hub/tutorials/select-pixels-compare-spectral-signatures-r
#SB: abbiamo scaricato i dati da virtuale e "dezippati" in una cartella sul disco C detta EN
library(raster)
library(ggplot2)
library(rgdal)
libary(RStoolbox)
setwd("C:/lab/EN") # SB: ricordiamo che abbiamo fatto una cartella apposita "EN"
#SB: per importare i dati ho diverse strae ma siccome serve solo una banda mi basta usare brick
#SB: devo importare la prima immagine 
EN01 <- brick("EN_0001.png")
#SB: plottare la prima immagine con la mcl che ti piace 
cl <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot <-(EN01,col=cl)
#SB: importare l'ultima immagine 
EN13 <- brick("EN_0013.png")
plot <-(EN13,col=cl)
#SB creare la mappa differenza 
DEN <- EN13- EN01 #SB: stai attenta quando fai la diferenza a mettere il maggiore per primo se no ti trovi i valori negativi
plot <-(DEN,col=cl)
#SB: plottare tutto insieme
par(mfrow=c(3,1)) #così lo faccio in due righe e una colonna da preferire perchè uso tutto lo spazio
plot(EN01,col=cl)
plot(EN13,col=cl)
plot(DEN,col=cl)
#SB: fare una lista con tutti i file
rlist <- list.files(pattern="EN")
import <- lapply(rlist,raster)
EN <- stack(import)
plot <-(EN,col=cl)
#SB: fare un plot comprensivo di 1 e 13 
par(mfrow=c(2,1))
plot(EN$EN_001, col=cl)
plot(EN$EN_013, col=cl)
#SB: fare una pca
ENpca  <- rasterPCA(EN)
summary  <- (ENpca$model)
plotRGB(ENpca$map, r=1, g=2, b=3 , stretch="lin")
#SB: calcolare la variabilità sulla prima componente
PC1sd  <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd) 
plot(PC1sd, col=cl)







library(raster)
library(ggplot2)
library(rgdal)
setwd("C:/lab/")
#SB: il dataset defor è già stato scaricato in massato
rgbStack <- brick("defor2.jpg")
plotRGB(rgbStack, 1,2,3, stretch="Lin") #SB: plottiamo con le bande 
plotRGB(rgbStack, 1,2,3, stretch="Hist") #SB: questa visualizzazione permette di accentuare le differenze
#SB: la funzione click permette permette di vedere le firme spettrali tramitte un semplice click
click(rgbStack, id=T, xy=T, cell=T, type="p", pch=16, col="green") #SB: pch è il carattere 
#SB: cliccando nel punto mi da i valori 
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 505.5 200.5 199115      193      185      172
#SB: ora creiamo un dataframe, creo la tabella 
band <- c(1,2,3)
forest <- c(187,23,34)
water <- c(39,87,125)
spectrals <- data.frame(band,forest,water) #SB: così creo la tab
 spectrals
  #band forest water
#1    1    187    39
#2    2     23    87
#3    3     34   125
ggplot(spectrals, aes(x=band)) + 
    geom_line(aes(y = forest), color = "green")+
    geom_line(aes(y = water), color = "blue", linetype = "dotted")+
    labs(x="wavelength", y="reflectance")
# SB: questo è il plot con ggplot 2 con le relative aesthetics
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#SB: nuovo dataset
band <- c(1,2,3)
time1 <- c(223,11,33)
time2 <- c(197,163,151)
spectralst <- data.frame(band, time1, time2)

#SB: sepctral signatures
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time2), color="gray") +
 labs(x="band",y="reflectance")
 #SB: nuovo tentativo 
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149,157,133)
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)
 # plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="gray") +
 labs(x="band",y="reflectance")






