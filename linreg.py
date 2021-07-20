import pandas as pd 
from sklearn import datasets
from sklearn.model_selection import train_test_split 
from sklearn.linear_model import LinearRegression  
import numpy as np  
from sklearn.metrics import mean_squared_error, r2_score
import csv

dataset = pd.read_csv('data_air_quality.csv',names = ['A_PM10','A_SO2', 'A_NOX', 'A_O3' ,'A_HS', 'A_RY', 'A_RH', 'A_BN', 'A_HB', 'B_PM10', 'B_SO2','B_NO','B_NO2','B_NOX','B_O3','B_HS','B_RY','B_RH','B_BN','B_HB','B_UZ','C_PM2','C_SO2','C_NO','C_NO2','C_NOX','C_O3','C_HS','C_RY','C_RH','C_BN','C_HB','C_UZ','D_PM10','D_SO2','D_NO','D_NO2','D_NOX','D_CO','D_HS','D_RY','D_RH','D_BN','D_HB','D_UZ'])


X = dataset[['A_PM10','A_SO2','A_HS', 'A_RY', 'A_RH','A_BN', 'A_HB']]
y = dataset[['C_NOX']]



X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0) 

from sklearn.preprocessing import StandardScaler
sc_X=StandardScaler()
x_train=sc_X.fit_transform(X_train)
x_test=sc_X.transform(X_test)



from sklearn.linear_model import LinearRegression
regressor = LinearRegression()

#regressor = LinearRegression() 
#print dataset.isnull().any()
regressor.fit(x_train, y_train)
y_pred = regressor.predict(x_test)


#print('Coefficients: \n', regressor.coef_)
# The mean squared error
from sklearn import metrics  

print('Mean Absolute Error:', metrics.mean_absolute_error(y_test, y_pred))  
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))  
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))



# # Explained variance score: 1 is perfect prediction
print('Variance score: %.2f' % r2_score(y_test, y_pred))
