##SB: analisi multivariate 
library(raster) #SB: su r è già stato fatto
library(RStoolbox)
setwd("C:/lab/") #SB: Windows, set wd
p224r63_2011<- brick("p224r63_2011_masked.grd") #SB: dobbiamo usare brick per caricare un set multiplo di bande, raster carica un solo set alla volta
p224r63_2011               
#               class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 
plot(p224r63_2011) #SB: plottare
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)#SB: mettiamo i valori della banda verde nel blu, pch= carattere del punto, cex= dimensione
# SB: la funzione pairs mette in risalto le correlazioni tra tutte le variabili del dataset a coppie
pairs(p224r63_2011) #SB mi mostra un grafico con tutte le correlazioni tra i dataset
               
library(RStoolbox)              
               
