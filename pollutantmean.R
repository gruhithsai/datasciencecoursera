pollutantmean <- function(directory,pollutant,id = 1:332) {
  main_df <- data.frame()
  for(value in id) {
    if(value < 10){
      temp_df <- read.csv(paste(getwd(),"/",directory,"/00",as.character(value),".csv",collapse = "",sep=""))
      main_df <- rbind(main_df,temp_df)
    }
    else if(value < 100){
      temp_df <- read.csv(paste(getwd(),"/",directory,"/0",as.character(value),".csv",collapse = "",sep=""))
      main_df <- rbind(main_df,temp_df)
    }
    else {li
      temp_df <- read.csv(paste(getwd(),"/",directory,"/",as.character(value),".csv",collapse = "",sep=""))
      main_df <- rbind(main_df,temp_df)
    }
  } 
  mean(main_df[,pollutant],na.rm = TRUE)
}

