best <- function(state1 , outcome){
csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
names(csv) <- tolower(names(csv))
bool  <- state1 %in% csv[,"state"]
if(!bool)
  stop("invalid state")
outcome <- gsub(" ", ".", outcome) 
outcome <- paste("hospital.30.day.death..mortality..rates.from.",outcome,sep="")
bool <- outcome %in% colnames(csv)
if(!bool)
  stop("invalid outcome")
temp <- csv[(csv$state == state1), c("hospital.name",outcome)]
temp <- temp[temp[,2] != "Not Available",]
temp <- temp[complete.cases(temp[ ,2]),]
hosp_list <- temp$hospital.name[temp[,outcome] == min(as.numeric(temp[,outcome]),na.rm = T)]
hosp_list <- sort(hosp_list)
hosp_list[1]
}

