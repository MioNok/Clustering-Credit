# Clustering-Credit
Analyzing credit card data whit the help of k-means clustering and graphs.

Simple analysis of credit card data. Used clustering to ultimately group the crdit card users into 8 different groups. Used the Elbow method and the average silhouette method to determine the number of groups. Finally I used ggplot to visualise the different clusters and anlyze the differences between them.

#### Elbow method chart:
![alt text](https://i.imgur.com/J6dCAkW.png)

Acording to the elbow method 8/9/10 culusters seems optimal.


#### Average silhouette method chart:
![alt text](https://i.imgur.com/1I4sAii.png)

Avg silhouette method indicates that 3 or 8 would be optimal.


**Based on these I chose to pursue with 8 clusters/groups.**



# Analyzing the different clusters.

### The distribution of users in each cluster
![alt text](https://i.imgur.com/aur42U7.png)

_Cluster nr 8 is tiny, and 7 is huge._




### Histogram of account balance
![alt text](https://i.imgur.com/IG4qWra.png)

_Cluster nr 6 has the highest balance, and 4 has the lowest._



### Credit limit vs Tenure
![alt text](https://i.imgur.com/zd2btfq.png)

_Customers whit the lowest tenure is grouped in cluster nr 2, they also have the lowest credit limit_



### Payments vs Credit limit
![alt text](https://i.imgur.com/uT7uoeE.png)

_We can se the reason behind the cluster nr 8 now, their payments are in another category_



### Purchases vs One off purchases
![alt text](https://i.imgur.com/uG5NkNO.png)

_We can again see that cluster nr8 has the biggest purchases and the largest one of purchases._
_Cluster nr 1 and 3 spends more than the rest of the users._



### Histogram of Cash in advance
![alt text](https://i.imgur.com/foWDU0D.png)

_Cluster nr 6 takes the most cash in advance._
