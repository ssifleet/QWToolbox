preferences <- function(...){
  
###Initialize variables
.guiEnv$siteIDs <- read.csv("data/siteids.csv", header=F,colClasses = "character")
colnames(.guiEnv$siteIDs) <- "Station IDs"

.guiEnv$pcodes <- read.csv("data/pcodes.csv", header=F,colClasses = "character")
colnames(.guiEnv$pcodes) <- "pcodes"

}
