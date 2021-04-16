# 16/04/21 codice per creare file 
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
