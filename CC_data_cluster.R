#K-means clustering of Credit card data

library(readr)
library(cluster)
cc_data <- data.frame(read_csv("CC GENERAL.csv"))


#Noticed that almost all of the NA:s are in MinPayments, changing thema all to 0
cc_data$MINIMUM_PAYMENTS[is.na(cc_data$MINIMUM_PAYMENTS)] <- 0

#One NA left, ins credit limit, just going to omit it
cc_data <- na.omit(cc_data)

#Turing cust_ID to row name
rownames(cc_data) <- cc_data[,1]

cc_data <- cc_data[-1]

cc_data_scaled <- scale(cc_data)

#Using the elbow method


#Calculating withings sum of squares on different amount of centers
tot_wss <- function(n_centers,data){
  kmeans(data, n_centers, nstart = 50 )
}

#Will take a while to run
tot_wss_cc_data <- sapply(2:20, tot_wss, cc_data_scaled)

tot_wss_results <- vector()

#Extracting the tot.wss from the kmeans elements
counter = 1
for (element in tot_wss_cc_data) {
  tot_wss_results <- append(tot_wss_results, tot_wss_cc_data[,counter]$tot.withinss)
  counter = counter + 1
  if (counter == 20) break
}

tot_wss_results_df <- data.frame(tot_wss_results)



p <- ggplot(tot_wss_results_df, aes(x = c(2:20), y = tot_wss_results))+
      geom_line(col = "red")+
      geom_point()+
      theme_bw()
p + xlab("Number of centers") + ylab("WSS of clusters") + ggtitle("Elbow method")

#Acording to the elbow method 8 culusters seems optimal

#Using average silhouette method

avg_sil <- function(n_centers, data){
  kmeans_res <-kmeans(data,n_centers, nstart =50)
  sil_conf <- silhouette(kmeans_res$cluster, dist(data))
  mean(sil_conf[ ,3])
}
# Grab a coffee
avg_sil_confs <- sapply(2:20, avg_sil, data = cc_data_scaled)

avg_sil_confs_df <- data.frame(avg_sil_confs)

p2 <- ggplot(avg_sil_confs_df , aes(x = c(2:20), y = avg_sil_confs))+
  geom_line(col = "red")+
  geom_point()+
  theme_bw()
p2 + xlab("Number of centers") + ylab("Avg sil conf") + ggtitle("Silhouette method")

#Avg silhouette method indicates that 3 or 8 would be optimal.

k8 <- kmeans(cc_data_scaled, centers = 8, nstart = 50)

cc_data["cluster"] <- k8$cluster
# Analyzing the clusters with graphs

#Cluster nr 8 is tiny, and 7 is huge.
ggplot(cc_data, aes(cluster))+
  geom_histogram(stat = "count")


#Cluster nr 6 has the highest balance, and 4 has the lowest.
bal_hist <- ggplot(cc_data, aes(x = BALANCE))+
            geom_histogram()+
            facet_wrap(~ cluster)+
            theme_bw()

bal_hist

# Customers with the lowest tenure is grouped in cluster nr 2, they also have the lowest credit limit
credit_scatter <- ggplot(cc_data,aes(CREDIT_LIMIT,TENURE))+
                  geom_jitter(alpha = 0.3)+
                  facet_wrap(~ cluster)+
                  theme_bw()


credit_scatter

# We can se the reason behind the cluster nr 8 now, their payments are in another category
payments_scatter <- ggplot(cc_data,aes(PAYMENTS,CREDIT_LIMIT))+
                    geom_jitter(alpha = 0.3)+
                    facet_wrap(~ cluster)+
                    theme_bw()


payments_scatter

#We can again see that cluster nr8 has the biggest purchases and the largest one of purchases.
#Cluster nr 1 and 3 spends more than the rest of the users.
purchases_scatter <- ggplot(cc_data,aes(PURCHASES,ONEOFF_PURCHASES))+
                     geom_jitter(alpha = 0.3)+
                     facet_wrap(~ cluster)+
                     theme_bw()


purchases_scatter

#Cluster nr 6 takes the most cash in advance.
cashaadv_hist <- ggplot(cc_data,aes(CASH_ADVANCE))+
                 geom_histogram()+
                 facet_wrap(~ cluster)+
                 theme_bw()


cashaadv_hist



