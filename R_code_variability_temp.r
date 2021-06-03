

#19/05
setwd("C:/lab/") #SB: in testa tutte le librerie
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
install.packages("viridis")
library(viridis)
sent <- brick("sentinel.png") #SB: importare il dato
sent #SB: vedere le info
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/sentinel.png 
#names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
#min values :          0,          0,          0,          0 
#max values :        255,        255,        255,        255 
plotRGB(sent) #SB: non importa specificare le bande perchè di default sono già corrette
#SB: dobbiamo calcolare la variabilità (deviazione standard), alla fine ottengo una nuova mappa dove ogni pixel deriva dalla deviazione standard calcolata da una finestra mobile
nir <- sent$sentinel.1 #SB: metto i nomi più semplici
red <- sent$sentinel.2
ndvi <- (nir-red) / (nir+red) #SB: calcolando l'indice ndvi ho unito insieme tutte le bande
plot(ndvi)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) 
plot(ndvi,col=cl)
#SB: ora posso calcolare la dev. standard con la funzione focal
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd) #SB: focal(oggetto, w=  dimensione finestra mobile , fun= deviaz. stand)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)
#SB: calcoliamo anche la media
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean3, col=clsd)
#SB: proviamo a cambiare anche la dimensione della finestra mobile
ndvisd9 <- focal(ndvi, w=matrix(1/81, nrow=9, ncol=9), fun=sd)
plot(ndvisd9, col=clsd)
#SB: di solito 5 può andare bene
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)
#SB: esiste un altro modo per accorpare dei dati cioè la pca
sentpca <- rasterPCA(sent) #SB: rasterPCA è la funzione che fa la pca sui raster
plot(sentpca$map)  
sentpca
#$call
#rasterPCA(img = sent)
#$model
#Call:
#princomp(cor = spca, covmat = covMat[[1]])
#Standard deviations:
#  Comp.1   Comp.2   Comp.3   Comp.4 
#77.33628 53.51455  5.76560  0.00000 
#4  variables and  633612 observations.

#$map
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      :       PC1,       PC2,       PC3,       PC4 
#min values : -227.1124, -106.4863,  -74.6048,    0.0000 
#max values : 133.48720, 155.87991,  51.56744,   0.00000 
summary(sentpca$model)
#Importance of components:
 #                          Comp.1     Comp.2      Comp.3 Comp.4
#Standard deviation     77.3362848 53.5145531 5.765599616      0
#Proportion of Variance  0.6736804  0.3225753 0.003744348      0
#Cumulative Proportion   0.6736804  0.9962557 1.000000000      1
#SB: la prima componente spiega il 77,3% della variabilità








