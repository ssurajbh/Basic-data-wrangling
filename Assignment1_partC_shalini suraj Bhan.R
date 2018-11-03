
############### Importing the data file

data2 <- read.delim(file.choose(), header = T)
data2

############### Checking data-sets

############### Class and summary
class(data2)
summary(data2)
str(data2)

############### Variable names.
names(data2)

############### Species richness of data (found: 127)

length(unique(data2$species_name))

############### No. of BINs (150) (3188)

length(unique(data2$bin_uri))

############### Specimen bearing BINS.

length(grep("[:]", data2$bin_uri))

############### Data Reduction

data3 <- data2[c(grep(":", data2$bin_uri)),]

length(data3$bin_uri)

sum(is.na(data3$bin_uri))      

sum(is.na(data2$bin_uri))

############## Country with most barcode data (Canada: 3188)

install.packages("fansi")
library(fansi)

data3 %>%
  group_by(country) %>%
  summarize(count = length(processid)) %>%
  arrange(desc(count))

############### Biodiversity analysis

install.packages("vegan")
library(vegan)

### Groupind data and counting records in each bin

data4 <- data3 %>%
  group_by(bin_uri) %>%
  count(bin_uri)
data4

############## changing the data set format

library(dplyr)

library(magrittr)

library(tidyverse)

data5 <- spread(data4, bin_uri, n)
data5

 
############## checking unique markers

unique(data2$markercode)

############### Installing packages

install.packages("tidyverse")
library(tidyverse)

install.packages("stringi")
library(stringi)



install.packages("ape")
library(ape)

install.packages("RSQLite")
library(RSQLite)

install.packages("DECIPHER")
install.packages("stringr")
library(stringr)

source("https://bioconductor.org/biocLite.R")
biocLite("msa")
biocLite("Biostrings")
abiocLite("muscle")
biocLite("msa")
biocLite("DECIPHER")
library(Biostrings)
library(muscle)
library(msa)
library(DECIPHER)

install.packages("dplyr")
library(dplyr)

############### Database, with list of markercodes

MarkerCodeList <- data2 %>%
  group_by(markercode) %>%
  summarize(n = length(processid)) %>%
  arrange(desc(n)) %>%
  print()

############## Converting to data string

Data2String <- DNAStringSet(data2$nucleotides)


############### Subseting the dataframe data2 to retain those records having a COI-5P markercode.

DataCOI <- data2 %>%
  filter(markercode == "COI-5P") %>%
  filter(str_detect('nucleotides', "[ACGT]"))
DataCOI

############### Calculating Nucleotide sequences.

######## checking data type
class(DataCOI$nucleotides)

######## Converting to 18s markerset
Data18snucleotides <- DNAStringSet(DataCOI$nucleotides)
Data18snucleotides
