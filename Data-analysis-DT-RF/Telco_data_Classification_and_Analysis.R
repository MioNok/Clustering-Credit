#Libraries I will be using

#install.packages("readr")
#install.packages("rpart")
#install.packages("caTools")
#install.packages("randomForest")
#install.packages("mltools")
#install.packages("ggplot2")
library(readr)
library(rpart)
library(caTools)
library(randomForest)
library(data.table)
library(mltools)
library(ggplot2)


# Importing the telcodata
telcodata = read_delim('Telco-Customer-Churn2.csv', delim = ";")


#Analysis of the data

#Most of the churn happend for Month-to-Month subscibers.
h1 <- ggplot(telcodata, aes(Contract, fill = Churn))+
            geom_histogram(stat = "count", col ="black")+
            theme_bw()+
            scale_fill_manual(values = c("#00AFBB", "#000080"))

#Most of the churn happend for PaperlessBilling
h2 <- ggplot(telcodata, aes(PaperlessBilling, fill = Churn))+
           geom_histogram(stat = "count", col ="black")+
           theme_bw()+
           scale_fill_manual(values = c("#00AFBB", "#000080"))

#Most of the churn happend for cable optic subscribers
h3 <- ggplot(telcodata,aes(InternetService, fill = Churn))+
        geom_histogram(stat = "count", col ="black")+
        theme_bw()+
        scale_fill_manual(values = c("#00AFBB", "#000080"))

#Most of the churn happend to clients with low montly payments and short tenure
sp1 <- ggplot(telcodata, aes(tenure, MonthlyCharges,col = Churn))+
        geom_jitter(alpha = 0.4)+
        geom_smooth()+
        theme_bw()+
        scale_color_manual(values = c("#00AFBB", "#000080"))

# Encoding the target feature as factor
telcodata$Churn= factor(telcodata$Churn, levels = c("No","Yes"),labels = c(0, 1))

#Somehow the total charges was imported as charachers and not num
telcodata$TotalCharges <- as.numeric(telcodata$TotalCharges)

#A few NA:s were present after the conversion to numeric
telcodata <- na.omit(telcodata)


# Splitting the telcodata into the Training data and Test data

set.seed(200)
split = sample.split(telcodata$Churn, SplitRatio = 0.75)
training_data = subset(telcodata, split == TRUE)
test_data = subset(telcodata, split == FALSE)


#Decision tree
tree_classifier = rpart(formula = Churn ~., 
                   data = training_data)


# Predicting the Test data results
y_pred_tree = predict(tree_classifier, newdata = test_data[-20],type ="class")



# Making the Confusion Matrix
unlisted_test<- unlist(test_data[,20])
cm_tree <- table(unlisted_test, y_pred_tree)


#Evaluating the tree
result_tree <-(cm_tree[1]+cm_tree[4])/nrow(test_data)
result_tree

plot(tree_classifier)
text(tree_classifier)


#The random forest

#Using only the variables that the decision tree determied was importand and one hot encoding the categorical variabels
#These were Contract, Internet service, Tenure and tech support.
telcodata_sub <- telcodata[c(5,8,12,15,20)]



#Need to factorize the data for one hot to work
telcodata_sub$InternetService <- factor(telcodata_sub$InternetService)
telcodata_sub$TechSupport <- factor(telcodata_sub$TechSupport)
telcodata_sub$Contract <-  factor(telcodata_sub$Contract)
telcodata_sub$tenure <- as.numeric()

#Splitting to training and test again
set.seed(200)
split = sample.split(telcodata_sub$Churn, SplitRatio = 0.75)
training_data_sub = subset(telcodata_sub, split == TRUE)
test_data_sub = subset(telcodata_sub, split == FALSE)


forest_classifier = randomForest(x = training_data_sub [-5],
                                 y = training_data_sub $Churn,
                                 ntree = 200)

# Predicting the Test data results
y_pred_forest = predict(forest_classifier, newdata = test_data_sub[-5],type ="class")

#Confusion Matrix
cm_forest <- table(unlisted_test, y_pred_forest)

#Evaluating the forest
result_forest <-(cm_forest[1]+cm_forest[4])/nrow(test_data_sub)
result_forest


plot(forest_classifier)
