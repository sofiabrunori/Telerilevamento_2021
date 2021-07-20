# CODICE R COMPLETO - telerilevamento geo-ecologico 2021


# summary:
# 1 REMOT SENSING
# 2 TIME SERIES ANALISYS/ ANALISI MULTITEMPORALE
# 3 COPERNICUS
# 4 KNITR
# 5 ANALISI MULTIVARIATE 
# 6 CLASSIFICATION
# 7 GGPLOT2
# 8 VEGETATION INDICES
# 9 LAND COVER
# 10 VARIABILITY
# 11 FIRMA SPETTRALE
# esercizio


##  1 REMOT SENSING (10/03/21)
install.packages("raster") #SB: sto installando il pacchetto raster che permette di gestire dati in formato raster, non vanno mai messi spazi
#SB: ricorda di mettere le virgolette quado attingi ad elementi che sono esterni ad R, 
#SB: le parentesi invece racciudono l'argomento della funzione che voglio esercitare
# SB: R è un pacchetto case sensitive cioè è sensibile all'uso delle maiscole/minuscole (raster è scritto con la minuscola se sbaglio mi darà errore così:)
# SB: > install.packages("Raster")
#SB :Installing package into ‘C:/Users/utente/Documents/R/win-library/3.6’
#(as ‘lib’ is unspecified)
#Warning messages:
#1: package ‘Raster’ is not available (for R version 3.6.3) 
#2: Perhaps you meant ‘raster’ ? 
#> 
library(raster) # SB:mi permette di richiamare ipacchetti scaricati in precedenza 

## 12/03/21 
 setwd("C:/lab/") #SB: r lavora per funzioni, devo comunicargli che cartella voglio utilizzare (lab precedentemente creata in C) per fare le operazioni, la funzione è set working directory
 #SB: devo mettere le virgolette perchè sto "uscendo" da R per attingere al disco C.
 library(raster)#SB: brick è una funzione che compare dentro il pacchetto ratser per questo devo richiamarlo prima di utilizzarlo, solitamente si mette sepre all'inizio del codice
 p224r63_2011 <- brick("p224r63_2011_masked.grd") # SB:la funzione brick permette di importare la serie di dati desiderata in formato raster da mettere sempre tra virgolette
 # SB: associo anche con la freccetta i dati ad un nome p224..
 p224r63_2011 #SB: mi mostra quello che contiene la variabile (classe, dimensioni, righe, colonne..)
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 
plot(p224r63_2011) # SB plot è la funzione che permette di vedere a video quello che ho importato
dev.off() #SB: permette di cancellare quello che ho a video

##17/03/21
library(raster) #SB:la funzione library richiama il pacchetto che si ha prima installato, require è analogo. per correttezza quando inizio un nuovo codive vanno richiamati per prima cosa
#i pacchetti che dovrò usare durante lo sviluppo.ù setwd("C:/lab/")
setwd("C:/lab/") #SB: impostata la workingdirectory cioè la cartella in cui R va a prendere i dati che mi servono
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
plot(p224r63_2011)
#SB: cambiamo i colori di rappresentazione e la funzione che serve è colorRampPalette
#SB: r seleziona i colori con delle lable e queste vanno virgolettate nero="black", poi comunque devo fare un array se cambio un set di colori quindi metterlo tra parentesi
#SB: in pratica metto diversi argomenti nella stessa funzione devo metterci la c davanti
#SB: poi tra parentesi metto di nuovo un altro argomento tra parentesi (100) cioè vorrei 100 colori intermedi ed infine le attribuisco un nome
cl <-colorRampPalette(c("black","grey","light grey")) (100)
#SB: poi con col messo come argomento dentro plot mi permette di fare un plot con la palette che ho fatto prima (col=cl)
plot(p224r63_2011,col=cl)
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot (p224r63_2011,col=cls)
dev.off()

## (24/03/2021) 
library(raster) #SB: carico pacchetto raser
#Carico il pacchetto richiesto: sp SB: in automatico mi carica anche il pachetto sp
setwd("C:/lab/") #SB: devo carivcare anche la cartella dove sono localizzati i dati, !!!!! se uso il mec devo stare attenta e mettere setwd("/Users/name/Desktop/lab/")
p224r63_2011 <- brick("p224r63_2011_masked.grd") #SB: prendo l'immagine masked già "tagliata"
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot (p224r63_2011,col=cls) #SB: plottiamo con anche il colore
p224r63_2011 #SB: mi da delle info
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/p224r63_2011_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
#max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 

#SB: LE BANDE LANDNSAT
# 1=blu
#2=verde
#3=rosso
#4=infrarosso vicino
#5=infrarosso medio
#6=infrarosso termicola
#proviamo a plottare la banda del blu il suo nome è B1_sre
dev.off() #SB: ripulisce la finestra grafica
#SB: il dollaro $ lega la banda blu
#SB: esercizio di plot con nuova color ramp
plot(p224r63_2011$B1_sre)
clB<- colorRampPalette(c("black","blue","light blue","light grey")) (200)
plot(p224r63_2011$B1_sre, col=clB)
#SB: utilizziamo la funzione "par" che mi permette di blottare due immagini insieme cioè un multiframe lo indico mf e specifico sempre righe e colonne volendo
par(mfrow=c(1,2)) #cioè una riga e due colonne nel mio array 
par(mfrow=c(2,1)) #così lo faccio in due righe e una colonna da preferire perchè uso tutto lo spazio
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#SB: se faccio par mfcol metto nell'arrey prima il numero delle colonne
par(mfcol=c(1,2))
par(mfrow=c(4,1)) #SB: faccio plot delle 4 bande 
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
par(mfrow=c(2,2))
#SB: è visualizzato male occorre mettere  2 righe e due colonne
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

clA<- colorRampPalette(c("orchid","cyan","hotpink","lemonchiffon","turquoise","peachpuff")) (200)
plot(p224r63_2011$B1_sre, col=clA)
#SB: colours() mi mostra a video tutti i colori che posso sfruttare
#SB: esercizio con 4 colori
par(mfrow=c(2,2))
clB<- colorRampPalette(c("black","blue","light blue","light grey")) (200)
plot(p224r63_2011$B1_sre, col=clB)
clV<- colorRampPalette(c("black","green","light green","light grey")) (200)
plot(p224r63_2011$B2_sre, col=clV)
clR<- colorRampPalette(c("black","red","coral","yellow")) (200)
plot(p224r63_2011$B3_sre, col=clR)
clnir<- colorRampPalette(c("black","magenta","grey")) (200)
plot(p224r63_2011$B4_sre, col=clnir)

## 26/03/21
library(raster) #SB: richiama pacchetto
setwd("C:/lab/") #SB: setta la WD
p224r63_2011 <- brick("p224r63_2011_masked.grd") #SB: ricarichiamo con brick i dati utili (meglio ricaricarli perchè se salvo w. space qualcosa va perso
#SB: LE BANDE DELL'LANDNSAT
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio
#RGB= è lo schema fisso che il dispositivo usa per mostrare i colori (Red, Green, Blu), a seconda di come si mischiano ho tutti i colori
# in pratica monto le bande nel punto giusto e formo un'immagine con i colori che vede l'occhio umano
# la funzione è plotRGB(oggetto, r=3, g=2, b=1, stretch="lin")  stretch permette di migliorare la visualizzazione, funziona anche se scrivo 3, 2 ,1
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #immagine a colori naturali
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # SB: così ho messo la banda dell'infrarosso
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #SB: cos' in viola vedo il suolo nudo
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#SB: esercizio fare un multiframe con le immagini create in precedenza
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #SB: immagine a colori naturali
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # SB: così ho messo la banda dell'infrarosso
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #SB: cos' in viola vedo il suolo nudo
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#SB: come salvare un pdf
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()
# SB: lo stretch può anche non essere lineare ma ancora più esteso nei valori medi con Histogramstretch
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")
par(mfrow=c(2,1)) #SB: vedo la differenza tra i due tipi di stretch
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")
#EX: fare multiframe con colori naturali false e con hist
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Hist")

# SB: per analisi pca installare questo pacchetto
install.packages("RStoolbox")
library(RStoolbox) #SB: controlla vada bene perchè era già iinstallata la RStoolbox
library(raster) #SB: richiama pacchetto
setwd("C:/lab/") #SB: setta la WD
p224r63_2011 <- brick("p224r63_2011_masked.grd") #SB: brik importa l'immagine intera
p224r63_2011 #SB: guardiamo le caratteristiche del dato
# SB: effettuiamo un analisi multitemporale, cioè confrontiamo lo stesso dato che viene da anni diversi.
p224r63_1988 <- brick("p224r63_1988_masked.grd") #SB: importaimo il nuovo file
p224r63_1988#SB: guardiamo le nuove info
#class      : RasterBrick 
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
#resolution : 30, 30  (x, y)
#extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/p224r63_1988_masked.grd 
#names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
#min values : 4.070954e-03, 8.173777e-03, 4.615846e-03, 1.300000e-02, 4.567942e-03, 2.947000e+02, 0.000000e+00 
#max values :   0.08496003,   0.17020000,   0.21908860,   0.54999932,   0.45184137, 305.20000000,   0.49681378 
plot(p224r63_1988) #SB: primo plot
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #SB: la metto coi colori naturali
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")#SB: plot all'infrarosso
par(mfrow=c(2,1)) #SB: così vedo le differenze
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,2)) #SB: vediamo come cambia con streth hist è impo per i geologi perchè la riflettanza cambia con grain
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

pdf("multitemp_R.pdf") #SB : salvataggio in pdf
par(mfrow=c(2,2)) #SB: vediamo come cambia con streth hist è impo per i geologi perchè la riflettanza cambia con grain
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


## 2 TIME SERIES ANALISYS/ ANALISI MULTITEMPORALE
# SB: scaricare i dati da virtuale e metterli in una cartella dentro lab
library(raster) #SB va richiamata sempre prima la libreria, in questa operazione si carica in automatico anche il pacchetto "sp"
setwd("C:/lab/greenland") # SB: settare la wd mettendo bene la cartella
# non posso fare brick per importare i file della cartella perchè non è un singolo ma sono 4 diversi
lst_2000 <- raster("lst_2000.tif") # SB: il comando che permette di importare singoli starti è "raster" crea infatti un rasterlayer
lst_2005 <- raster("lst_2005.tif")
plot(lst_2000) # SB: vediamo come si presenta
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif") # SB anche in questo caso do un nome all'oggetto e gleilo associo con la freccietta
lst_2015 <- raster("lst_2015.tif")
lst_2000 # SB: si vedono le caratteristiche del file 
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/greenland/lst_2000.tif 
#names      : lst_2000 
#values     : 0, 65535  (min, max)
par(mfrow=c(2,2)) # SB: con par faccio una unica visualizzazione 2x2
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
# SB: importare le immagini una a una è inutile soprattuto quando uno maneggia molti dati come importarle tutte assieme?
# la funzione che lo permette è lapply che mi permette di applicare la stessa funzione ad una lista di file che creo in precedenza. in pratica faccio una lista dei file e con 
# SB lapply applico a tutti il comando raster
rlist <- list.files(pattern="lst") #SB: creo la lista di file, con pattern dico al softaware che caratteristica comune hanno i file nel nome "lst"
rlist
# [1] "lst_2000.tif" "lst_2005.tif" "lst_2010.tif" "lst_2015.tif" così vedo il contenuto della mia lista
import <- lapply(rlist,raster) #lapply è la funzione che mi fa applicare raster alla lista
import
#[[1]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/greenland/lst_2000.tif 
#names      : lst_2000 
#values     : 0, 65535  (min, max)
#[[2]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/greenland/lst_2005.tif 
#names      : lst_2005 
#values     : 0, 65535  (min, max)
#[[3]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/greenland/lst_2010.tif 
#names      : lst_2010 
#values     : 0, 65535  (min, max)
#[[4]]
#class      : RasterLayer 
#dimensions : 1913, 2315, 4428595  (nrow, ncol, ncell)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#source     : C:/lab/greenland/lst_2015.tif 
#names      : lst_2015 
#values     : 0, 65535  (min, max)
TGr <- stack(import) #la funzione stak mi permette di fare un unico file con i diversi singoli file che ho importato in precedenza
TGr
#class      : RasterStack 
#dimensions : 1913, 2315, 4428595, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1546.869, 1546.898  (x, y)
#extent     : -267676.7, 3313324, -1483987, 1475229  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=90 +lon_0=-33 +k=0.994 +x_0=2000000 +y_0=2000000 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#names      : lst_2000, lst_2005, lst_2010, lst_2015 
#min values :        0,        0,        0,        0 
#max values :    65535,    65535,    65535,    65535 
plot(TGr) #SB: faccio plot
plotRGB(TGr, 1, 2, 3, stretch="Lin") #SB: associo le immagini ai valori rgb che mi pota a vedere in quali anni ho avuto i valori maggiori
plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 

install.packages("rasterVis") # Installo nuovo pacchetto per fare levelplot ma rcordati che formalemnte devo metterlo all'inizio del codice
library(raster)# SB: richiamiamo le librerie
library(rasterVis)
library(rgdal)
rlist <- list.files(pattern="lst")
import <- lapply(rlist,raster)
TGr <- stack(import)
levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
plot(TGr, col.regions=cl) #SB: vedo confronto, funziona anche plot ma la visualizzazione è inferiore per qualità
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))#SB: cambio il nome negli attributi per denominare le mappe con un array
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #SB: nome generale della mappa con main
#SB: analisi dei dati del melt scaricati da virtuale
meltlist <- list.files(pattern="melt") #SB: creiamo una lista dei file che abbiamo creato secondo la caratteristica comune "melt"
melt_import <- lapply(meltlist,raster) #SB: applichiamo lapply alla lista
melt <- stack(melt_import) #SB: facciamo uno stak unico
melt #SB: vedo le caratteristiche del file, vedo i nomi dei vari layer dello stak
#class      : RasterStack 
#dimensions : 109, 60, 6540, 28  (nrow, ncol, ncell, nlayers)
#resolution : 25000, 25000  (x, y)
#extent     : -650000, 850000, -3375000, -650000  (xmin, xmax, ymin, ymax)
#crs        : +proj=stere +lat_0=90 +lat_ts=70 +lon_0=-45 +k=1 +x_0=0 +y_0=0 +a=6378273 +b=6356889.449 +units=m +no_defs 
#names      : X1979annual_melt, X1980annual_melt, X1981annual_melt, X1982annual_melt, X1983annual_melt, X1984annual_melt, X1985annual_melt, X1986annual_melt, X1987annual_melt, X1988annual_melt, X1989annual_melt, X1990annual_melt, X1991annual_melt, X1992annual_melt, X1993annual_melt, ... 
#min values :                0,                0,                0,                0,                0,                0,                0,                0,                0,                0,                0,                0,                0,                0,                0, ... 
#max values :            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535,            65535, ... 
levelplot(melt) #SB: ora posso plottare lo stak
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt #SB: creo una mappa che mi mostra la perdita di ghiaccio dal 79 al 2007, i nomi delle immagini li cerco in melt
#SB: mettere il dollaro per legare la singola immagine dello stack 
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb, main="differenza 79-07") # SB: si può anche mettere titolo.
# SB: per la prossima volta
install.packages("knitr")

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 3 COPERNICUS
#SB: richiamare le librerie utili
library(raster)
install.packages("ncdf4") #SB: questo pacchetto serve per visualizzare formato .nc tra virgolette percè esco da r
library(ncdf4) #SB: va sempre richiamato, formalmente va messo in testa 
setwd("C:/lab/") #SB: settiamo la wd
temp1 <- raster("temp1-01.nc") # SB: importare il dato gennaio
temp1
#class      : RasterLayer 
#band       : 1  (of  24  bands)
#dimensions : 3584, 8064, 28901376  (nrow, ncol, ncell)
#resolution : 0.04464286, 0.04464286  (x, y)
#extent     : -180.0223, 179.9777, -79.97768, 80.02232  (xmin, xmax, ymin, ymax)
#crs        : +proj=longlat +rf=298.257223563 +pm=0 +a=6378137 
#source     : C:/lab/temp1-01.nc 
#names      : Fraction.of.Valid.Observations 
#z-value    : 2021-01-01 
#zvar       : FRAC_VALID_OBS 
 #SB: facciamo un plot per visualizzare
colT<- colorRampPalette(c("green", "pink", "red", "brown")) (200)
plot(temp1, col=colT, main="temperatura a gennaio") #SB: ho aggiunto con main il titolo nell'argomento

#SB: funzione aggregate permette di migliorare la visualizzazione, riduco il numero di pixel con un fattore x, in pratica raggruppa i pixel e fa la media
#SB: ex fattore 10 (prende 100 pixel e li accorpa in 1 facendo la media) faccio un resampling per far pesare meno
temp1agg<- aggregate (temp1, fact= 100) #SB: in questo caso ho raggruppato 10000 pixel
plot(temp1agg, col=colT, main="temperatura a gennaio, ricampionato" ) #SB: riplotto con nuovo titolo

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 4 KNITR
setwd("C:/lab/") #SB: come sempre prima si setta la W.D
require(knitr) #SB: il comando require ha la stesso funzione di library
#SB: knitr prende un codice esterno che va messo tra virgolette e all'interno di R genera un report che si salva nella cartella dove è presente il codice
#SB: copia lo script in una pagina word e salvala nella cartella lab
#SB: la funzione che lo permette è stitch e il primo argomento è il nome del codice che ho salvato in lab
install.packages("tinytex")
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#SB: da errore ma si risolve così
tinytex::install_tinytex()
tinytex::tlmgr_update()

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##  5 ANALISI MULTIVARIATE

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
p224r63_2011res_pca <- rasterPCA(p224r63_2011res) #SB: rasterPCA crea una mappa e un modello per l'analisi (principal component analisy)
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
summary(p224r63_2011res_pca$model) #SB: questa funzione mi mostra il sommario del modello che ho creato (infatti lego il dato con $ al modello)
#Importance of components:
                        #  Comp.1      Comp.2       Comp.3       Comp.4
#Standard deviation     1.2050671 0.046154880 0.0151509526 4.575220e-03
#Proportion of Variance 0.9983595 0.001464535 0.0001578136 1.439092e-05
#Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01     #SB: si legge così la prima banda spiega il 99,83% della variabilità, le componenti 1,2 e 3 spieano il 99,99%
                         #    Comp.5       Comp.6       Comp.7
#Standard deviation     1.841357e-03 1.233375e-03 7.595368e-04
#Proportion of Variance 2.330990e-06 1.045814e-06 3.966086e-07
#Cumulative Proportion  9.999986e-01 9.999996e-01 1.000000e+00
plot(p224r63_2011res_pca$map) #SB: per plottare va messo anche il legame con la mappa
dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #SB: con plotRGB guardo i colori rgb

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 6 CLASSIFICATION

#SB: classificazione di alcune immagini del sole 21/04
library(raster) #SB: richiamiamo la libreria raster che mi permette di usare file raster
library(RStoolbox) #SB: anche RStoolbox
setwd("C:/lab/") #SB: settiamo la wd (ricordati che se usi il mec cambia la stringalibrary(raster) #SB: richiamiamo la libreria raster che mi permette di usare file raster
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

## SB: facciamo un esercitazione con il grand canyon per visualizzare alcune litologie
#SB: i dati sono stati scaricati da: https://virtuale.unibo.it/mod/resource/view.php?id=558031
library(raster) #SB: richiamiamo la libreria raster che mi permette di usare file raster
library(RStoolbox) #SB: i pacchetti si possono richiamare anche con require()
setwd("C:/lab/") #SB: poi inseriamo la working directory
#SB: importa l'immagine in RGB associando un nome con brick perchè l'immagine è rgb e brick le monta gia insieme
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin") #SB: plotRGB permette di plottare un file in tre livelli per vederlo come l'occhio umano (B=3, G=2, R=1)
plotRGB(gc, r=1, g=2, b=3, stretch="hist") #SB: cambio lo stretching per cambiare la visualizzazione
#SB: i daltonici non distinguono il rosso ed il verde quindi in un articolo meglio non usarli
#SB: facciamo una classificazione non supervisionata in 2 classi, sarà diversa per ogni pc 
#SB: info a: https://cran.r-project.org/web/packages/RStoolbox/RStoolbox.pdf
gcc2 <-unsuperClass(gc, nClasses= 2) #SB: due classi 
gcc2
#unsuperClass results

#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 6222, 9334, 58076148  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 9334, 0, 6222  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/Users/utente/AppData/Local/Temp/RtmpmAz4CL/raster/r_tmp_2021-04-23_095124_10140_90209.grd 
#names      : layer 
#values     : 1, 2  (min, max)
plot(gcc2$map)#SB: per plottare ricordati di legare il dataset alla mappa con $map
gcc4 <- unsuperClass(gc, nClasses=4) #SB: riclassifichiamo in 4 classi
plot(gcc4$map)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## 7 GGPLOT2 
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # SB: devo avere grid extra 

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 8 VEGETATION INDICES

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
#(5/05)
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

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 9 LAND COVER 

setwd("C:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
install.packages("gridExtra")
library(gridExtra)
defor1 <- brick("defor1.jpg") #SB: con brick importiamo l'immagine
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #SB: plotta dei raster in modo più interessanteù
#SB: stessi passaggi con l'immagine 2
defor2 <- brick("defor2.jpg") #SB: con brick importiamo l'immagine
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
par(mfrow=c(1,2)) #SB: per visualizzare meglio fare un par che però "esce" da gg plot
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#SB: per fare un multiframe con ggplot devo installare gridExtra per usare grid.arrange che monta vari pezzi in un grafico
#install.packages("gridExtra")
#library(gridExtra)
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin") #SB: do dei nomi ai due oggetti che mi servono e che ho già fatto prima
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) #SB: l'ho messo su due righe

#(7/05)
setwd("C:/lab/") #SB: come sempre in testa mettere tutte le librerie
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
defor1 <- brick("defor1.jpg") #SB: importiamo tutto
defor2 <- brick("defor2.jpg")
#SB: ora facciamo una classificazione non supervisionata per vedere dove ho agricoltura e dove ho foresta
d1c <- unsuperClass(defor1, nClasses=2)
d1c
#*************** Map ******************
#$map
#class      : RasterLayer 
#dimensions : 478, 714, 341292  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : layer 
#values     : 1, 2  (min, max) #SB: ci sono 2 classi ovviamente quindi due valori
plot(d1c$map) #SB: ricordati sempre $map
# classe 1: foresta
# classe 2: agricultura
#SB: fare anche il 2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#classe 1: foresta
#classe 2: agricoltura
d2c3 <- unsuperClass(defor2, nClasses=3) #SB: proviamo con 3 classi per vedere dove mette il fiume
plot(d2c3$map)
#SB: facciamo qualche calcolo
#SB: calcolo frequenza dei pixel nelle diverse classi con la funzione freq
freq(d1c$map)     #SB: mi ridà i valori ogni pc ha i suoi valori perchè la classificaz è arbitraria del pc
#    value  count
#[1,]     1  34271
#[2,]     2 307021
s1 <- 34271 +  307021
s1
#[1] 341292
prop1 <- freq(d1c$map) / s1 #SB: vediamo in proporzione , se moltiplico per 100 ho le percentuali
prop1
#            value     count
#[1,] 2.930042e-06 0.1004155
#[2,] 5.860085e-06 0.8995845
freq(d2c$map)
#     value  count
#[1,]     1 179515
#[2,]     2 163211
s2 <- 179515 +  163211
prop2 <- freq(d2c$map) / s2
#SB: creiamo un dataset (dataframe)
cover <- c("Forest","Agriculture") #SB la prima colonna è cover, tra virgolette perchè è un testo
percent_1992 <- c(89.83, 10.16) #SB: la seconda colonna sono le percentuali 92, vanno messi i dati che vengono dal tuo pc
percent_2006 <- c(52.06, 47.93) #SB: la terza colonna 2006
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#        cover percent_1992 percent_2006
#1      Forest        89.83        52.06
#2 Agriculture        10.16        47.93
#SB: creiamo dei grafici con ggplot
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#SB: aestethics (x= fattore, Y= 1992, color=legenda) geom_bar(stat="identity", fill="white")
#SB: proviamo ad usare grid.arrange per comporre un grafico unico
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="violet")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="green")
grid.arrange(p1, p2, nrow=1)

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 10 VARIABILITY 

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

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#11 FIRMA SPETTRALE
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
 #-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#11 ESERCIZIO 

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




