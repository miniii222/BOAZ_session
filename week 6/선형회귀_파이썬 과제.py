from sklearn import datasets
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error
import matplotlib.pyplot as plt
import pandas as pd

# load data
boston = datasets.load_boston()

X = pd.DataFrame(boston.data, columns=boston.feature_names)
y = pd.DataFrame(boston.target, columns=['y'])

data = pd.concat([X, y], axis=1)

#1. boston 데이터에 column 중 하나인 LSTAT와 y의 선형회귀 수행
import numpy as np

lr = LinearRegression()
X_lstat = np.array(X['LSTAT']).reshape(-1,1)
lr.fit(X_lstat,y)

print("intercept : ", lr.intercept_)
print("coef : ", lr.coef_)


#2. 위 회귀분석의 r2 score와 mean_squared_error 출력
y_pred = lr.predict(X_lstat)
r1 = r2_score(y_pred,y)
mse1 = mean_squared_error(y_pred,y)
print("r-squared : ",r1)
print("mse : ",mse1)

#3. 회귀선과 LSTAT와 y의 산점도를 한 그래프에 시각화
plt.scatter(X_lstat, y)
plt.show()

#4. LSTAT와의 피어슨 상관계수 절대값이 가장 낮은 column 찾기
np.abs(X.corr())['LSTAT'].argmin()
#'CHAS'가 가장 작다.

#5. 4번에서 찾은 column + LSTAT와 y의 다중회귀 수행
lr.fit(X[['LSTAT','CHAS']], y)
print("intercept : ", lr.intercept)
print("coef : ", lr.coef)

#6. 위 회귀분석의 r2 score와 mean_squared_error 출력하고, 2번의 결과와 비교
y_pred2 = lr.predict(X[['LSTAT','CHAS']])
r2 = r2_score(y_pred2,y)
mse2 = mean_squared_error(y_pred2,y)

pd.DataFrame({'r_squared' : [r1,r2], 'mse' : [mse1,mse2]},
              index=['lstat','lstat & CHAS'])

#r-squared값은 커지고, mse는 작아짐.
