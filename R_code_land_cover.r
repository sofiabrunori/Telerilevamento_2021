#5/05

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

#7/05
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








