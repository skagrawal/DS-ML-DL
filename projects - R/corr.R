corr <- function(directory, threshold = 0) {
  #threshold = 400
  total_data= NULL
  for(i in 1:332){
    i = paste("000",i,sep = "")
    i = substr(i,nchar(i)-2,nchar(i))
    path = paste(directory,"/",i,".csv",sep = "")
    
    file = read.csv(path, header=TRUE) 
    complete_count = sum(complete.cases(file))
    
    if(complete_count>threshold){
      total_data = c(total_data,cor(file$nitrate,file$sulfate,use="complete.obs"))
    }
  }
  return(total_data)
}
