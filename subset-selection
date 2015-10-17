library(leaps)

ret.a.c<-read.csv("abc.csv")
#cor(ret.a.c[,-1])
#pairs(ret.a.c[,-1])

#Best Subset selection
leaps<-regsubsets(ret.a.c$returned~.,data=ret.a.c,nvmax=dim(ret.a.c)[2]-1)
S<-summary(leaps)
S
plot(leaps,scale="bic")
plot(leaps,scale="Cp")
coef(leaps,5)

#Forward Selection
leaps.fwd<-regsubsets(ret.a.c$returned~.,data=ret.a.c,nvmax =14,method ="forward")

plot(leaps.fwd,scale="bic")
plot(leaps.fwd,scale="Cp")
coef(leaps.fwd,7)

#Backward Selection
leaps.bwd<-regsubsets(ret.a.c$returned~.,data=ret.a.c,nvmax =14,method ="backward")

plot(leaps.bwd,scale="bic")
plot(leaps.bwd,scale="Cp")
coef(leaps.bwd,7)


library(genridge)

# Calculate Ridge estimator range- lambda: 0 -> 10

lambda<-seq(0,10,length.out=100)
L <- ridge(ret.a.c$returned~.,data=ret.a.c,lambda=lambda)

# Coefficients shrinkage

traceplot(L,X=c("lambda"))
M<-as.matrix(L$GCV)
abline(v=L$lambda[which.min(M)])
traceplot(L,X=c("lambda"))
abline(v=L$kGCV,col="black",lwd=3)

#PCR
library(pls)
set.seed(1)
pcr.fit<-pcr(ret.a.c$returned~.,data=ret.a.c ,scale =TRUE,validation ="LOO") 
summary(pcr.fit)



