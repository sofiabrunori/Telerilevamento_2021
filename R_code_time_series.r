# TIME SERIES ANALISYS/ ANALISI MULTITEMPORALE
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


### 
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

#####################à
install.packages("knitr")

