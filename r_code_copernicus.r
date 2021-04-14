#SB: esercizi con dati scaricati da copernicus, visualizzazione
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
