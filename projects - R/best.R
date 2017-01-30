# # 1 Plot the 30-day mortality rates for heart attack
# outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
# ncol(outcome)
# # Coerce the column to be numeric
# outcome[, 11] <- as.numeric(outcome[, 11])
# # Creating histogram
# hist(outcome[, 11])


# 2 Finding the best hospital in a state
best <- function(state, outcome) {
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  if(!(state %in% outcome_data[,7])){
    stop("invalid state")
  }
  outcome_set = c("heart attack", "heart failure", "pneumonia")
  if(!(outcome %in% outcome_set)){
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  if(outcome == "heart attack"){
    state_set=subset(outcome_data,outcome_data$State == state)
    state_set[,11] = sapply(state_set[, c(11)], as.numeric)
    min_of_state = min(state_set[,11],na.rm = TRUE)
    result_set=subset(state_set,state_set$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == min_of_state)
  }
  else if(outcome == "heart failure"){
    state_set=subset(outcome_data,outcome_data$State == state)
    state_set[,17] = sapply(state_set[, c(17)], as.numeric)
    min_of_state = min(state_set[,17],na.rm = TRUE)
    result_set=subset(state_set,state_set$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == min_of_state)
  }
  else {
    state_set=subset(outcome_data,outcome_data$State == state)
    state_set[,23] = sapply(state_set[, c(23)], as.numeric)
    min_of_state = min(state_set[,23],na.rm = TRUE)
    result_set=subset(state_set,state_set$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == min_of_state)
  }
  
  
  rs = sort(result_set$Hospital.Name)
  print(rs[1])
  
}
