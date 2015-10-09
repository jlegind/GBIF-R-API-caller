
library(jsonlite)
mycsv <- read.csv("G:/Fauna_Europeana/species.csv", sep=";", strip.white=T)
#The csv file should only contain a list of species names in one column

df <- data.frame(name=character(), taxonKey=integer(), count=integer(), stringsAsFactors = F)

for (j in mycsv[,1]){
    url <- URLencode(paste("http://api.gbif.org/v1/species/match?kingdom=Plantae&name=", j, sep=""))
    res <- fromJSON(url)    
    key <- res$usageKey
    url <- URLencode(paste("http://api.gbif.org/v1/occurrence/count?taxonKey=", key, sep=""))
    count <- fromJSON(url)
    df[nrow(df)+1,] <- (c(j, key, count))        
}
#Loop builds the data.frame and this can be used instead of the output csv file
#API documentation here: http://www.gbif.org/developer/summary

write.table(df, "fauna.csv", append=F, sep="\t", row.names=F)
