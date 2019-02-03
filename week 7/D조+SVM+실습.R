install.packages("e1071")
library(e1071)

tra<-read.csv(file='train.csv',header=T) #train data 불러오기
test<-read.csv(file='test.csv',header=T) #test data 불러오기
real<-read.csv(file='rreal.csv',header=T) #실제 값 불러오기


tra$Age[is.na(tra$Age)] <- median(tra$Age,na.rm = T) 
test$Age[is.na(test$Age)] <- median(test$Age,na.rm = T)
test$Fare[is.na(test$Fare)]<-median(test$Fare,na.rm=T)
#Age 변수 중앙값으로 대체


Survived<-real$Survived

tra<-tra[,-c(1,4,9,11)]
test<-test[,-c(1,3,8,10)]

#승객 ID, 이름, 좌석번호, cabin 변수 삭제

sex<-transform(tra$Sex,
               Sex_1=ifelse(tra$Sex=='male',1,0),
               Sex_2=ifelse(tra$Sex=='female',1,0))

tsex<-transform(test$Sex,
               Sex_1=ifelse(test$Sex=='male',1,0),
               Sex_2=ifelse(test$Sex=='female',1,0))
sex<-sex[,-1]
tsex<-tsex[,-1]

tra$Embarked[c(62,830)]<-'C'


Embarked<-transform(tra$Embarked,
               Embarked_S=ifelse(tra$Embarked=='S',1,0),
               Embarked_C=ifelse(tra$Embarked=='C',1,0),
               Embarked_Q=ifelse(tra$Embarked=='Q',1,0))

tEmbarked<-transform(test$Embarked,
                    Embarked_S=ifelse(test$Embarked=='S',1,0),
                    Embarked_C=ifelse(test$Embarked=='C',1,0),
                    Embarked_Q=ifelse(test$Embarked=='Q',1,0))
               
Embarked<-Embarked[,-1]
tEmbarked<-tEmbarked[,-1]
#성별 및 출발지 가변수화

tra<-cbind(tra,sex,Embarked)
test<-cbind(test,tsex,tEmbarked,Survived) #가변수 원 데이터에 붙이기


tra<-tra[,-c(3,8)]
test<-test[,-c(2,7)] #가변수화 시킨 Sex, Embarked 변수 삭제

test$Survived<-as.factor(test$Survived) #수치형으로 적용된 survived 변수 Factor변환




# Q1. r패키지 "e1070"의 svm()함수를 이용해 svm분류 수행
svm.e1071 <- svm(Survived ~ ., data = tra,
                 type = "C-classification", kernel = "radial",
                 cost = 100, gamma = 0.1)
# type : svm()의 수행방법 채택 (디폴트는 C-classification 또는 eps-regression 이다.)
# kernel : 훈련과 예측에 사용되는 커널
#          'radial'옵션은 가우시안 RBF를 의미
# cost : 제약 위배의 비용(디폴트 1)
# gamma : 선형을 제외한 모든 커널에 요구되는 모수(디폴트 : 1/데이터차원)

summary(svm.e1071)

pred <- predict(svm.e1071, tra, decision.values = TRUE) #predict 함수를 이용하여 예측값 구하기
(acc <- table(pred,tra$Survived)) #실제값과 비교

pred<-predict(svm.e1071,test[,c(1:10)]) #predict 함수를 이용하여 test (new data) 검정
(acc <- table(pred,test$Survived)) # 실제 값과 비교


# classAgreement() : 모형의 정확도 확인
classAgreement(acc)

install.packages('caret')
library(caret)

confusionMatrix(acc) #혼동행렬 구해주는 caret 패키지의 confusionMartix 함수


# tuned() : 최적의 모수를 제공, 동시에 여러 모수값에 대한 검정 결과 제공 
tuned <- tune.svm(Survived~., data = tra, gamma = 10^(-6:-1),
                  cost = 10^(1:2))
# 6×2=12개의 조합에서 모수조율이 이루어짐
summary(tuned)

tuned$best.parameters



# Q2. r패키지 "kernlab"의 ksvm()함수를 이용해 svm분류 수행
install.packages("kernlab")
library(kernlab)

svm.kernlab <- ksvm(Survived ~ ., data = tra, type = "C-bsvc",
                      kernel = "rbfdot", kpar = list(sigma = 0.1),
                      C = 10, prob.model = TRUE)
svm.kernlab



# predidct() : 새로운 자료에 대한 분류 수행 가능
ksvm.acc<-table(predict(svm.kernlab, test), test$Survived) 

classAgreement(ksvm.acc)
