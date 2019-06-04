# Data_analysis_DT_RF
Brief analysis of the Telco dataset from kaggle. Using graphs, decision trees and random forest to determine customer churn.

This repo is a explanatory demo in analysing this dataset from kaggle:

https://www.kaggle.com/blastchar/telco-customer-churn

My objective was to determine which variables effect the customer churn. 
I decided to first use basic graphs to visualise some of the variables, then I used a decicsion tree on the dataset and lastly I checked if a random forest would achieve better results than the decision tree.

## Results from the graphs:
#### Most of the churn happend for the Month-to-Month subscibers.
![alt text](https://i.imgur.com/n8y2lIp.png)

#### Most of the churn happend for customers using PaperlessBilling
![alt text](https://i.imgur.com/1yyYfgk.png)

#### Most of the churn happend for cable optic subscribers
![alt text](https://i.imgur.com/lTLcVIg.png)

#### Most of the churn happend to clients with low montly payments and short tenure
![alt text](https://i.imgur.com/oqxHhHg.png)

The conclusion from all this is that a customer that pays month to month, uses parpeless billing, is an cable optic subsciber with low tenure and low montly paymentys is most likely to leave.

## Results from the decision tree and random forest
The graph show the variables that the decision tree decided that had enough weight to effect the churn. This is according to my current understanding deceided based on the p-value of the variable in contrast to the depentand variable. For further research, pruning the decision tree might imporve the results.
![alt text](https://i.imgur.com/H64izHh.png)

About 200 iterations seemd to be enough, but in most cases decision trees do not overfit easily.
![alt text](https://i.imgur.com/gRNhaCH.png)

## The end result
Confusion matrises for the different methods. We can see that the random forest was in this case slightly better.
![alt text](https://i.imgur.com/7L7hl2M.png)

The accuracy of the **random forest** was **78.2%** and the **decision tree** had an accuracy of **77.8%**.
