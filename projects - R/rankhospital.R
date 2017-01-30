state = "TX"
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  #print(state)
  if(!(state %in% outcome_data[,7])){
    stop("invalid state")
  }
  outcome_set = c("heart attack", "heart failure", "pneumonia")
  if(!(outcome %in% outcome_set)){
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if(outcome == "heart attack"){
    state_set=subset(outcome_data,outcome_data$State == state ,select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    state_set[,2] = sapply(state_set[, c(2)], as.numeric)
    state_set = subset(state_set,state_set$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack!="NA")
    newdata = state_set[order(state_set$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,state_set$Hospital.Name),]
  }
  else if(outcome == "heart failure"){
    state_set=subset(outcome_data,outcome_data$State == state ,select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    state_set[,2] = sapply(state_set[, c(2)], as.numeric)
    state_set = subset(state_set,state_set$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure!="NA")
    newdata = state_set[order(state_set$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,state_set$Hospital.Name),]
  }
  else {
    state_set=subset(outcome_data,outcome_data$State == state ,select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    state_set[,2] = sapply(state_set[, c(2)], as.numeric)
    state_set = subset(state_set,state_set$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia!="NA")
    newdata = state_set[order(state_set$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,state_set$Hospital.Name),]
  }
  
  # Calculating the maximum rank of the hospital list
  nrows = nrow(newdata)
  #Returning result
  if(num == "best")
    print(newdata[1,1])
  else if(num == "worst")
    print(newdata[nrows,1])
  else if(num<nrows)
    print(newdata[num,1])
  else
    print("NA") 
}
