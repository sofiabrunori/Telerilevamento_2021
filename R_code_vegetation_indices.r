#28/04
require(raster) #SB: richiamare prima librerie utili
setwd("C:/lab/") #SB: settare la WD
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg") #SB: importiamo le immagini scaricate
# b1 = NIR
# b2 = red
# b3 = green
par(mfrow=c(2,1)) #SB: vediamo uno vicino all'altro così vedo la multitemporalità
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") #SB: montiamo le bande e vediamo come si presenta con plotRGB
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
defor1
#class      : RasterBrick 
#dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/defor1.jpg 
#names      : defor1.1, defor1.2, defor1.3 
#min values :        0,        0,        0 
#max values :      255,      255,      255 
#SB: calcoliamo il DVI facendo NIR-RED, per farlo guardo le caratteristiche del dato per vedere i nomi delle bande cioè defor1.1 e defor1.2
dvi1 <- defor1$defor1.1 - defor1$defor1.2 #SB: lego all'immagine (con $) la banda che mi interessa b1-b2 (cioè defor1.1 - defor1.2)
plot(dvi1) #SB: si plotta per vedere la sottrazione nei pixel
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) #SB: faccio array coi colori che preferisco per la visual
plot(dvi1, col=cl) #SB: plot coi colori giusti
plot(dvi1, col=cl, main="DVI at time 1") #SB: con main aggiungo anche un titolo all'immagine
##ES calcoliamo il dvi anche per l'immagine2
defor2
#class      : RasterBrick 
#dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/defor2.jpg 
#names      : defor2.1, defor2.2, defor2.3 
#min values :        0,        0,        0 
#max values :      255,      255,      255 
#SB: i dati sono defor2.1- defor2.2
dvi2 <- defor2$defor2.1 - defor2$defor2.2 #SB: faccio come prima la sottrazione con le bande$legate al dato
plot(dvi2, col=cl, main="DVI at time 2")
par(mfrow=c(2,1)) #SB: così posso visualizzarle uno sotto l'altro
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
#SB: posso fare la differenza dei due DVI per ogni pixel
difdvi <- dvi1 - dvi2 # Raster objects have different extents. Result for their intersection is returned SB: da questo errore perchè un dato ha qualche pizel in più o in meno 
cld <- colorRampPalette(c('blue','white','red'))(100) #SB: questa è una ramppalette molto usata per vedere dove si ha avuto l'impatto maggiore di defor(in questo caso)
plot(difdvi, col=cld)
#SB: ora posso calcolare NDVI cioè la normalizzazione per avere dati confrontabili
#SB:NDVI=(NIR-RED) / (NIR+RED) (è standardizzato per la somma delle due variabili)
#SB: il range di NDVI è sempre tra -1 e 1
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2) #SB: bisogna sempre vedere i nomi delle bande ma sta volta son sempre quelli
# SB: suggerimento= meglio  mettere sempre le parentesi anche dove è scontato perchè alcuni software non hanno regole di calcolo
plot(ndvi1, col=cl)
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2) #SB: in realtà il numeratore è semplicemente div2
# ndvi2 <- dvi2 / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
difndvi <- ndvi1 - ndvi2 #SB: mi posso calcolare la divverenza tra i due per vedere dove la vegetazione ha sofferto di +
plot(difndvi, col=cld) #SB: plot con la palette per le differenze
library(RStoolbox) #SB: ricordati che formalmente va messo all'inizio
#SB: facciamo alcuni calcoli
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1) #SB: VI= vegetation index, lo calcolo per la prima immagine
plot(vi1, col=cl)
#SB: mi mostra delle mappe con tutti gli indici spettrali che possono essere calcolati
vi1 #SB mi mostra quelli che ha fatto
class      : RasterBrick 
dimensions : 478, 714, 341292, 15  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      :         CTVI,          DVI,       GEMI,        GNDVI,        MSAVI,       MSAVI2,         NDVI,         NDWI,         NRVI,          RVI,         SAVI,           SR,         TTVI,          TVI,         WDVI 
min values :   -0.7071068, -114.0000000,         -?,   -1.0000000,  -18.8971647,  -13.2204227,   -1.0000000,   -1.0000000,   -1.0000000,    0.0000000,   -1.4920635,    0.0000000,    0.0696733,    0.0696733, -114.0000000 
max values :     1.224745,   248.000000,   1.777827,     1.000000,     1.000000,     1.000000,     1.000000,     1.000000,     0.972973,           NA,     1.496945,           NA,     1.224745,     1.224745,   248.000000 
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl) #SB: anche con il secondo oggetto

#5/05
install.packages("rasterdiv")
library(rasterdiv)
install.packages("rasterVis") #SB: era già stata installata
library(rasterVis)
setwd("C:/lab/")
plot(copNDVI) #SB: mi mostra tutto l'NDVI del mondo preso da copernicus
#SB: togliamo la parte del grafico che ha l'acqua cioè i pixel 253, 254 e 255, devono essere messi come NA (not assigned)
#SB: la funzione reclassify
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
levelplot(copNDVI) #SB: con levelplot 





