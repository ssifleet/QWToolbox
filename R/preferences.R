
###Initialize variables
siteIDs <- read.csv("Data/siteids.csv", header=F,colClasses = "character")
colnames(siteIDs) <- "Station IDs"

pcodes <- read.csv("Data/pcodes.csv", header=F,colClasses = "character")
colnames(pcodes) <- "pcodes"

