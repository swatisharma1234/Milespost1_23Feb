
download.file("https://github.com/skhan8/n-ssats/blob/master/nssatspuf_2017.RData?raw=true", destfile= "C:/Users/swati/OneDrive - Emory University/Documents/Sem IV/550/Milepost1/nssatspuf_2017.RData", mode = "wb")
load("C:/Users/swati/OneDrive - Emory University/Documents/Sem IV/550/Milepost1/nssatspuf_2017.RData")
# View Dataset
View(nssatspuf_2017)

#Save Dataset with name "data"
data<- nssatspuf_2017

# View Data Set
View(data)
nrow(data) #13585

library(tidyverse)

# Validating NA in the dataset
unique(data$B_PCT)
unique(data$A_PCT)
unique(data$STATE)
# NA are present in A_PCT and B_PCT. Subsetting the data so that observations where NA are present for variable A_PCT and B_PCT can be filtered
data2<-select(data,STATE, B_PCT, A_PCT)
View(data2)
# creating new dataset "data3" without NA
data3<- data2[(complete.cases(data2)),]
# checking number of observations in the new dataset "data3"
nrow(data3) #12551
# labelling "ZZ" as "other jurisdiction". Validated from Codebook
# Path to codebook https://datafiles.samhsa.gov/study-dataset/national-survey-substance-abuse-treatment-services-2017-n-ssats-2017-ds0001-nid18445
data3$STATE[data3$STATE=="ZZ"]<- "Other jurisdictions"
unique(data3$STATE)
# Sorting the value in STATE column alphabetically.
data3<- arrange(data3,STATE)
