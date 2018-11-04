# HiTSEQ calculator based on R
#Written by Hsuan-Chun Lin
#version 1.5
#The original edition calculate Xi as Si0/sum(si0)

#Data input
#print("Please input your filename (in .csv format)")
#filename <- readline()
#filename <- paste(filename,".csv",sep="")

#import your .csv file as test
test.import <- read.csv('import_data.csv', header=T)

test <- test.import[-(1:2),]
frac <- 1-as.numeric(test.import[1,2:5])
Enzyme <- as.numeric(test.import[2,2:5])

names(test)<-c("sequence","t0","t1","t2","t3")
rm(filename)

#calculate the summation and mole fraction
sum <- apply(test[,2:5],2,sum)
test$ft0 <- test$t0/sum[1]
test$ft1 <- test$t1/sum[2]
test$ft2 <- test$t2/sum[3]
test$ft3 <- test$t3/sum[4]

#calculate the fraction of individual substrate
test$fr0 <- 1-test$ft0/test$ft0*frac[1]
test$fr1 <- 1-test$ft1/test$ft0*frac[2]
test$fr2 <- 1-test$ft2/test$ft0*frac[3]
test$fr3 <- 1-test$ft3/test$ft0*frac[4]

#convert negative to random small amount in test

for(i in 1:length(test[,1])){
  for(j in 10:13){
   if(test[i,j] < 0){
     test[i,j] <- abs(rnorm(1,0)/100)
   } 
  }
}

#fitting
test$K <- 0
start.values = list(K = 0.01)
for (i in 1:length(test[,1])){
  data.ft <- cbind(Enzyme,t(test[i,10:13]))
  data.ft <- data.frame(data.ft)
  names(data.ft) <- c("Enzyme","f")
  dirf <- nls( f ~ Enzyme/(Enzyme + K), data = data.ft, start = start.values)
  test$K[i] <- coef(dirf)
  
}
finalresult <- test[,c("sequence","K")]
finalresult$KA <- 1/finalresult$K
finalresult$RKA <- finalresult$KA/finalresult$KA[3]

write.csv(finalresult,"output.csv")

hist(finalresult$RKA)
