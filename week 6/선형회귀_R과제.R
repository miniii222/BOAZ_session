setwd("C:/Users/wjssm/Desktop/boaz/week 6")
sales<-read.csv('sales.csv')

#1,
##a)
plot(sales$x,sales$y)

##b)
lm1<-lm(y~x, data=sales)
### 최종 모형 : y_hat = -17.891+2.481 * x

##C)
summary(lm1)
#p-value = 2.426e-08 <0.05 유의함

#2.
library(readr)
multiple <- read_table2("multiple.txt")
multiple<-multiple[-15,]


##a)
plot(multiple$x1, multiple$y)
plot(multiple$x2, multiple$y)

##b)
lm2<-lm(y~., data=multiple)
### 최종 모형 : y_hat = 62.39738+x1*0.74071+x2*-0.08067  

##c)
###backward elimination
step(lm2)
###forward selection
step(lm(y~1, data=multiple),direction='forward',scope=formula(lm2))
###stepwise
step(lm2, direction="both")

### 최종 모형 : y_hat = 0.7347 * x1