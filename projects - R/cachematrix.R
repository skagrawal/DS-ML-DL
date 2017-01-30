## Matrix inversion is usually a costly computation and there may be some benefit
## to caching the inverse of a matrix rather than compute it repeatedly.

## This assignment is to write a pair of functions that cache the inverse of a matrix.

## This function creates a special "matrix" object that can cache its inverse.
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of inverse of the matrix
## 4. get the value of inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) m <<- solve
  getinverse <- function() m
  l = list(set = set, get = get,setinverse = setinverse,getinverse = getinverse)
  l
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then the cache inverse value is returned using getinverse function.
## Else inverse is computed using solve function and set it to cache using setinverse function.
## This function assumes that the matrix is always invertible.

cacheSolve <- function(x, ...) {
  
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data)
  x$setinverse(m)
  m
}


## Sample Run of this
# # Create a matrix
# > x = matrix(1:4,2,2)
# # call makeCacheMatrix for x
# > m = makeCacheMatrix(x)
# # call cacheSolve for m 
# # first time - No cache data so inverse calculated and returned
# > cacheSolve(m)
# [,1] [,2]
# [1,] -2.0  1.0
# [2,]  1.5 -0.5
# # Next time - cached value returned
# > cacheSolve(m)
# getting cached data
# [,1] [,2]
# [1,] -2.0  1.0
# [2,]  1.5 -0.5
