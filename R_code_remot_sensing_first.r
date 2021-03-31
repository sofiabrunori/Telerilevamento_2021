
##10/03/21 lezione introduttiva telerilevamento geo ecologico
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



## 24/03/2021 ANALISI MULTITEMPORALE
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

#SB: LE BANDE DELL'LANDNSAT
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

##### 26/03/21 VISUALIZZAZIONE DATI TRAMITE RGBPLOT
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


