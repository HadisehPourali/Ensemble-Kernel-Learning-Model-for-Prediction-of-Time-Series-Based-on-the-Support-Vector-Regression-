# Ensemble Kernel Learning Model for Prediction of Time Series Based on the Support Vector Regression
Time series prediction based on support vector regression

article address: https://jsdp.rcisp.ac.ir/article-1-1162-fa.html

# Background
Time series prediction is a process which predicted future system values based on information obtained from past and present data points. 
The main purpose of using different models for time series prediction is making the forecast with the greatest accuracy.

In this repository, a new model for time series prediction is presented based on support vector regression and weighted combination of different kernels and optimization 
of parameters and their weights by the optimizer. In successive iterations of the competency function, the optimizer learns the optimal values of the particle array 
and uses those values to evaluate the test data.

# Data Set
CO2 (ppm) at Mauna Loa

Monthly closings of the Dow-Jones industrial index

Monthly critical radio frequencies

Sunspot time series

Monthly milk production per cow

# Method
In this method we have preprocessing phase which includes normalizing data and separating data for testing and training. In proposed model, Five kernels were selected as the best kernels by trial and error, and these kernels are applied to data. There may be only a few of the kernels that are useful for the problem, and we are not aware of which kernels are useful for our problem, so kernel outputs aggregate by applying coefficients. This combination creates a new secondary space. The output is given to support vector regression to construct a model that predicts values exactly ɛ accurate, which means the predicted values do not deviate more than ɛ from the original data. This model predicts values by using a leave one out model. Each kernel has parameters that need to be set to optimum values in order to get the best results. Hence in the proposed model, the kernel parameters and their weights are learned by the Gray Wolf Optimizer. By running program in consecutive iterations and examining the different values of the parameters, the optimizer learns the best of them which prediction error has been reduced, and finally returns their best value. 

# Result
The proposed model is implemented on five standard time series and compared to other method, test based on the RMSE criterion for DJ time series, improved by 1.58 point, Radio time series, improved by 0.178 point, and Sunspot time series, improved by 1.709 point.
