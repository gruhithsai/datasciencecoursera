rankall <- function(outcome,num = "best"){
csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
names(csv) <- tolower(names(csv))
outcome <- gsub(" ", ".", outcome) 
outcome <- paste("hospital.30.day.death..mortality..rates.from.",outcome,sep="")
bool <- outcome %in% colnames(csv)
if(!bool)
  stop("invalid outcome")
hosp_list <- csv[ , c("hospital.name","state",outcome)]
hosp_list <- hosp_list[hosp_list[,3] != "Not Available",]
hosp_list <- hosp_list[complete.cases(hosp_list[ ,3]),]
hosp_list[,3] <- as.numeric(hosp_list[,3])
hosp_list <- hosp_list[ order(hosp_list[,2],hosp_list[,3],hosp_list[,1]), ]
states <- unique(hosp_list$state)
main_df <- data.frame()
if(is.character(num)) {
  for(state in states){
    if(num == "best"){
      temp_df <- hosp_list[hosp_list[,"state"] == state,c("hospital.name","state")]
      temp_df <- head(temp_df,1)
      main_df <- rbind(main_df,temp_df)
    }
  else{
    temp_df <- hosp_list[hosp_list[,"state"] == state,c("hospital.name","state")]
    temp_df <- tail(temp_df,1)
    main_df <- rbind(main_df,temp_df)
  }
  }
}
else{
  for(state in states){
    temp_df <- hosp_list[hosp_list[,"state"] == state,c("hospital.name","state")]
    if(num > nrow(temp_df)){
      temp_df <- temp_df[1,]
      temp_df[,1] <- NA
    }
    else{
    temp_df <- temp_df[num,]
    }
    main_df <- rbind(main_df,temp_df)
  }
}
main_df
}