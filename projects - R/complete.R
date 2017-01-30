complete <- function(directory, id = 1:332) {
  nobs <- rep(0, length(id))
  n = 1
  for(i in id){
    i = paste("000",i,sep = "")
    i = substr(i,nchar(i)-2,nchar(i))
    path = paste(directory,"/",i,".csv",sep = "")
    file = read.csv(path, header=TRUE) 
    nobs[n]<-sum(complete.cases(file))
    n = n+1
  }
  complete<-data.frame(id = id, nobs = nobs)
  return(complete)
}
