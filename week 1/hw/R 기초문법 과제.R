###과제

# 1. sum() 함수와 똑같은 기능을 하는 함수를 for문을 이용하여 작성하시오.

mysum<-function(x){
  n<-length(x); ss<-0
  
  for(i in 1:n) ss<-ss+x[i]
  
  return(ss)
}



# 2. which.max() 함수와 똑같은 기능을 하는 함수를 for문, if문을 이용하여 작성하시오.

mymax<-function(x){
  
  n<-length(x); j<-1; temp<-x[1]
  
  for(i in 1:(n-1)){
      if(temp<x[i+1]){
          temp<-x[i+1]
          j<-i+1
      }
  }
  
  return(j)
}


#3.for문을 이용하여 피보나치 수열을 작성하시오.

fibo<-function(n,x1,x2){
  temp1<-x1; temp2<-x2
  if(n==1) return(x1)
  else if(n==2) return(x2)
  else{
    for(i in 1:(n-2)){
      temp3<-temp1+temp2
      temp1<-temp2
      temp2<-temp3
    }
    return(temp3)
  }
}



#4. 1 + 1/(1+2) + 1/(1+2+3) +...+ 1/(1+2+..+N) 을 함수로 구현하시오.

myfunc<-function(n){
  a<-rep(NA,n)
  
  for(i in 1:n){
  a[i]<-1/sum(1:i)
}

  sum(a)
}

#5. for 문을 활용해서  *         만들어주세요!!
#                      **
#                      ***
#                      ****
#                      *****

for(i in 1:5){
  for(j in 1:i) cat("*")
  cat('\n')
}
