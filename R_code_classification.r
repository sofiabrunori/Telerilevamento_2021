#SB: classificazione di alcune immagini del sole 21/04
library(raster) #SB: richiamiamo la libreria raster che mi permette di usare file raster
library(RStoolbox) #SB: anche RStoolbox
setwd("C:/lab/") #SB: settiamo la wd (ricordati che se usi il mec cambia la stringa
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #SB: carichiamo l'immagine all'interno di r con la funzione brick, e con la freccetta gli associo il nome
so #SB: se digiiamo il nome r mi restituisce le informazioni del dato
#class      : RasterBrick 
#dimensions : 1157, 1920, 2221440, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1920, 0, 1157  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg 
#names      : Solar_Orbiter_s_first_views_of_the_Sun_pillars.1, Solar_Orbiter_s_first_views_of_the_Sun_pillars.2, Solar_Orbiter_s_first_views_of_the_Sun_pillars.3 
#min values :                                                0,                                                0,                                                0 
#max values :                                              255,                                              255,                                              255 
plotRGB(so, 1, 2, 3, stretch="lin") #SB: effettuiamo plot per visualizzare il dato con le bande posizionate normalmente e stretch lineare
#SB: si fa una classificazione non supervisionata cioè l'utente non definisce le classi, lo fa il software "per somiglianza" 
#SB: la funzione è unsuperClass, gli argomenti sono: nome immagine, numero di pixel, numero di classi,..)
#SB: tutte le caratteristiche delle funz le trovo in https://www.rdocumentation.org/packages/RStoolbox/versions/0.2.6/topics/unsuperClass
soc <- unsuperClass(so, nClasses= 3) #SB: abbiamo dato un nome e definito tre classi
soc
#unsuperClass results

#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 1157, 1920, 2221440  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 1920, 0, 1157  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 3  (min, max)
#SB: ora facciamo plot del risultato ma devo prima legare la mappa al dataset
plot(soc$map) #SB: il numero random di pixel lo decide il software per questo tra di noi le mappe sono diverse
set.seed(42) #SB: così lo definiamo noi
so20 <- unsuperClass(so, nClasses= 20) #SB: esercizio con 20 classi 
plot(so20$map)
#SB: esiste la classificazione supervisionata si scelgono i parametri
cl<-coloRrampPalette(c("pink", "red", "violet")) (20)
plot(so20$map, col= cl)
## esercizio (posso importare file di qualsiasi formato)
gatto <- brick("prova.jpg")
gattoC <- unsuperClass(gatto, nClasses= 3)
cl <- colorRampPalette(c('red','black','yellow'))(100)
plot(gattoC$map, col=cl)
## SB: facciamo un esercitazione con il grand canyon
