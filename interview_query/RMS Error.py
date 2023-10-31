Write a function calculate_rmse to calculate the root 
mean squared error of a regression model. The function 
should take in two lists, one that represents the 
predictions y_pred and another with the target values y_true.


def calculate_rmse(y_pred, y_true):

    res = 0
    n = len(y_pred)
    for i in range(n):

        res+=((y_true[i]-y_pred[i])**2)/n
    
    res = round(res**0.5,2)
    return res
-----------------------------------------------------------------------------------------
import math

def calculate_rmse(y_pred, y_true):
    if len(y_true) != len(y_pred):
        print("Length of predictions are different sizes")
        return
    # loop through both lists and square the results and sum them
    squares = sum((x - y)**2 for x, y in zip(y_true, y_pred))
    # apply the square root and divide by the number of values in the list
    return round(math.sqrt(squares / len(y_true)),2)
