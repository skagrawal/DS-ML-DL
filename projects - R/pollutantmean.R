pollutantmean <- function(directory, pollutant, id = 1:332) {
  sum <- 0
  total_data= NULL
  for(i in id){
    i = paste("000",i,sep = "")
    i = substr(i,nchar(i)-2,nchar(i))
    path = paste(directory,"/",i,".csv",sep = "")
    file = read.csv(path, header=TRUE) 
    total_data = c(total_data,file[, pollutant])
  }
  mean_val = mean(total_data, na.rm = TRUE)
  print(mean_val)
}
