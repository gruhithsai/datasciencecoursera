rankhospital <- function(state1 , outcome , num){
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
  hosp_list <- csv[(csv$state == state1), c("hospital.name",outcome)]
    hosp_list <- hosp_list[hosp_list[,2] != "Not Available",]
    hosp_list <- hosp_list[complete.cases(hosp_list[ ,2]),]
    hosp_list[,2] <- as.numeric(hosp_list[,2])
    hosp_list <- hosp_list[ order(hosp_list[,2],hosp_list[,1]), ]
    if(is.character(num)){
      if(num == "best") num <- 1
      else num <- nrow(hosp_list)
    }
    ret <- hosp_list$hospital.name[num]
  ret
}

