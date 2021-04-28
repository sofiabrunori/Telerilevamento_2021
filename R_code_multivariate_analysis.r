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
                           
library(raster) #SB: richiamare librerie
library(RStoolbox)
setwd("C:/lab/") #SB: Windows, set la cartella di riferimento         
p224r63_2011<- brick("p224r63_2011_masked.grd") #SB: carichiamo il dataset che abbiamo scaricato 
pairs(p224r63_2011) #SB: mi mostra la correlazione tra tutte le bande e anche il valore di Pearson
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #SB: meglio ricampionare l'immagine con aggregate (in pratica abbasso la risoluzione) per evitare che le funzioni dopo impieghino troppo tempo
p224r63_2011res #SB: con fattore 10 la sisuluzione è passata da 30 a 300
#class      : RasterBrick 
#dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
#resolution : 300, 300  (x, y)
#extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : memory
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values :   0.00670000,   0.01580000,   0.01356544,   0.01648527,   0.01500000, 295.54400513,   0.00270000 
#max values :   0.04936299,   0.08943339,   0.10513023,   0.43805822,   0.31297142, 303.57499786,   0.18649654 
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin") #SB: confrontiamo a video i due casi 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res) #SB: rasterPCA crea una mappa e un modello per l'analisi
p224r63_2011res_pca
#$call
#rasterPCA(img = p224r63_2011res)

#$model
#Call:
#princomp(cor = spca, covmat = covMat[[1]])

#Standard deviations:
 #     Comp.1       Comp.2       Comp.3       Comp.4       Comp.5       Comp.6 
#1.2050671158 0.0461548804 0.0151509526 0.0045752199 0.0018413569 0.0012333745 
 #     Comp.7 
#0.0007595368 

 #7  variables and  44550 observations.

#$map
#class      : RasterBrick 
#dimensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
#resolution : 300, 300  (x, y)
#extent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : memory
#names      :         PC1,         PC2,         PC3,         PC4,         PC5,         PC6,         PC7 
#min values : -1.96808589, -0.30213565, -0.07212294, -0.02976086, -0.02695825, -0.01712903, -0.00744772 
#max values : 6.065265723, 0.142898435, 0.114509984, 0.056825372, 0.008628344, 0.010537396, 0.005594299 

#attr(,"class")
#[1] "rasterPCA" "RStoolbox"
#con la funzione summary vedo i dati meglio legat col $
summary(p224r63_2011res_pca$model)
#Importance of components:
                        #  Comp.1      Comp.2       Comp.3       Comp.4
#Standard deviation     1.2050671 0.046154880 0.0151509526 4.575220e-03
#Proportion of Variance 0.9983595 0.001464535 0.0001578136 1.439092e-05
#Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01
                         #    Comp.5       Comp.6       Comp.7
#Standard deviation     1.841357e-03 1.233375e-03 7.595368e-04
#Proportion of Variance 2.330990e-06 1.045814e-06 3.966086e-07
#Cumulative Proportion  9.999986e-01 9.999996e-01 1.000000e+00
plot(p224r63_2011res_pca$map) #SB: per plottare va messo anche il legame con la mappa
dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #SB: con plotRGB guardo i colori naturali


