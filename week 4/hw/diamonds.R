library(ggplot2)
library(dplyr)
#1. cut 데이터의 빈도를 나타내는 histogram을 그리시오
diamonds %>% group_by(cut) %>% summarise(count=n()) %>% 
  ggplot()+geom_bar(aes(cut, count), stat="identity")

#2. cut 데이터의 빈도를 나타내는 Pie Chart를 그리시오
ggplot(diamonds, aes(x = factor(1), fill = cut)) + geom_bar(width = 1) + coord_polar("y")+
xlab("")+ggtitle("pie chart")

#3. carat별로 diamond의 색 분포를 나타내는 histogram을 그리시오
ggplot(diamonds)+geom_histogram(aes(carat, fill = color))

#4. carat과 price에 대한 scatterplot을 그리시오.
ggplot(diamonds)+geom_point(aes(carat,price))

#5. 3캐럿 이상인 다이아몬드들의 carat과 price에 대한 scatterplot을 그리시오. color는 clarity로 하고, point의 size는 cut으로하시오
diamonds %>% filter(carat >=3) %>% ggplot()+geom_point(aes(carat, price, color=clarity, size = cut))
