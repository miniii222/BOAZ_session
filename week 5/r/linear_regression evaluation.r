#R�� caret package�� ���� ������ ���� ��ü ������ �¿��� trainin data Ȥ�� test data�� �и��� ���� �������� ����� ����
library(caret)

#weight�� bias ����
bias <- 100
w <- 80

#x_data, y_data ����
set.seed(0)
x <- rnorm(100)
y <- w * x + bias + rnorm(100, sd=50)

#x_data, y_data�� dataframe ����
df <- data.frame(x, y)

#������ x_data, y_data plot
plot(x, y, main="Sample Data for Regression")

#linear regression model ����
model <- lm(y ~ ., data=df)
#R_square �� ����
r2 <- summary(model)$r.squared

# y_data ��ü�� 10������� ����
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
