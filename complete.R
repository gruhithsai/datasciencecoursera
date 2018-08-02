complete <- function(directory , id = 1:332) {
  main_df <- data.frame()
  for(value in id) {
    if(value < 10){
      temp_df1 <- read.csv(paste(getwd(),"/",directory,"/00",as.character(value),".csv",collapse = "",sep=""))
    }
    else if(value < 100){
      temp_df1 <- read.csv(paste(getwd(),"/",directory,"/0",as.character(value),".csv",collapse = "",sep=""))
     
    }
    else {
      temp_df1 <- read.csv(paste(getwd(),"/",directory,"/",as.character(value),".csv",collapse = "",sep=""))
    
    }
    nobs <- sum(complete.cases(temp_df1))
    temp_df2 <- data.frame(value,nobs)
    main_df <- rbind(main_df,temp_df2)
  } 
  main_df
}