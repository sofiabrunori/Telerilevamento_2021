

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

#21/05
setwd("C:/lab/") #SB: in testa tutte le librerie
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis)
sentpca <- rasterPCA(sent) #SB: richiamo la pcaa della scorsa volta
pc1 <- sentpca$map$PC1 #SB: lego la mappa alla pca alla banda 1 cioè la PC1
#SB: applicare la funzione focal con la pc1
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)
#SB: utilizzo della funzione sources
# pc1 <- sentpca$map$PC1         questo codice è salvato dentro virtuale e l'ho scaricato dentro lab, con source metto il risultato in r
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)
source("source_test_lezione.r.txt") #SB: va con le """ perchè sono fuori R
#SB: scaricare le librarie viridis e richiamare ggplot e grid.extra ma in testa al codice
#SB: scarichiamo anche il file source ggplot, .txt perchè non riesco a cambiare estensione ma funziona lo stesso
source("source_ggplot.r.txt")
#SB: plottiamo tramite ggplot questi dati, la funz ggolot apre una nuova finestra
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")   #SB: geom_raster (quello che voglio poi le aestetichs, questa mappa è il modo migliore per vedere delle discontinuità
#SB: viridis mostra tutte le varie scale di colore visibili a tutti (anche per i daltonici e altro)
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html , le palette sono:  “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +                           #SB: argomento scale_fill_viridis
ggtitle("Standard deviation of PC1 by magma colour scale")
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "mako")  +
ggtitle("Standard deviation of PC1 by mako colour scale")
#SB: ora mettiamole tutte insieme (viridis, magma e mako), mi serve grid.arrange
#library(grid.extra) già messo in testa
grid.arrange(p1, p2, p3, nrow = 1) 
#SB: prima con source il prof aveva composto tutte le palette di viridis
#SB: non mettere la ramp palette rainbow









