library(raster) # SB:mi permette di richiamare ipacchetti scaricati in precedenza 

## 12/03/21 
 setwd("C:/lab/")
 rlist <- list.files(pattern="WI")
 import <- lapply(rlist,raster)
 WI <- stack(import)
 cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
 plot(WI, main="serie temporale dal 2010 al 2021")
 levelplot(WI)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(WI, col.regions=cl)
