
##10/03/21 lezione introduttiva telerilevamento geo ecologico
install.packages("raster") #SB: sto installando il pacchetto raster che permette di gestire dati in formato raster, 
#ricorda di mettere le virgolette quado attingi ad elementi che sono esterni ad R, 
#le parentesi invece racciudono l'argomento della funzione che voglio esercitare
# R è un pacchetto case sensitive cioè è sensibile all'uso delle maiscole/minuscole (raster è scritto con la minuscola se sbaglio mi darà errore così:)
#> install.packages("Raster")
#Installing package into ‘C:/Users/utente/Documents/R/win-library/3.6’
#(as ‘lib’ is unspecified)
#Warning messages:
#1: package ‘Raster’ is not available (for R version 3.6.3) 
#2: Perhaps you meant ‘raster’ ? 
#> 
library(raster) #mi permette di richiamare ipacchetti scaricati in precedenza 

## 12/03/21 
 setwd("C:/lab/") # r lavora per funzioni, devo comunicargli che cartella voglio utilizzare (lab precedentemente creata in C) per fare le operazioni, la funzione è set working directory
 #devo mettere le virgolette perchè sto "uscendo" da R per attingere al disco C.
 library(raster)# brick è una funzione che compare dentro il pacchetto ratser per questo devo richiamarlo prima di utilizzarlo, solitamente si mette sepre all'inizio del codice
 p224r63_2011 <- brick("p224r63_2011_masked.grd") #la funzione brick permette di importare la serie di dati desiderata in formato raster da mettere sempre tra virgolette
 #associo anche con la freccetta i dati ad un nome p224..
 p224r63_2011 #mi mostra quello che contiene la variabile (classe, dimensioni, righe, colonne..)
 plot(p224r63_2011) #plot è la funzione che permette di vedere a video quello che ho importato
 dev.off() #permette di cancellare quello che ho a video
