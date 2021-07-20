
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

