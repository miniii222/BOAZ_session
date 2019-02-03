#R의 caret package는 교차 검증을 위해 전체 데이터 셋에서 trainin data 혹은 test data를 분리해 내는 여러가지 방법을 제공
library(caret)

#weight와 bias 설정
bias <- 100
w <- 80

#x_data, y_data 생성
set.seed(0)
x <- rnorm(100)
y <- w * x + bias + rnorm(100, sd=50)

#x_data, y_data로 dataframe 생성
df <- data.frame(x, y)

#생성된 x_data, y_data plot
plot(x, y, main="Sample Data for Regression")

#linear regression model 생성
model <- lm(y ~ ., data=df)
#R_square 값 도출
r2 <- summary(model)$r.squared

# y_data 전체를 10등분으로 나눔
folds <- createFolds(y, k=10)


total_R2 <- vector()

for (x in folds){
  train <- df[-x, ]
  validation <- df[x, ]
  
  linear_model <- lm(y ~ ., data=train)
  
  label <- validation$y
  prediction <- predict(linear_model, newdata=validation)
  
  TSS <- sum((label - mean(label))^2)
  RSS <- sum((prediction - label)^2)
  R2 <- 1 - RSS/TSS
  
  total_R2 <- append(total_R2, R2)
}

total_R2
