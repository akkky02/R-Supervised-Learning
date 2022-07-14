#open RidingMowers and assign it to a data frame
mower_df <- read.csv("RidingMowers.csv")
mower_df$rowNames <- rownames(mower_df)

#use the sample function to randomly select x% of the rows
#store the resulting row numbers the index to use for selecting the training partition
set.seed(1)
numberOfRows <- nrow(mower_df)
train.index <- sample(numberOfRows, numberOfRows*0.6)

#partition the data into training and validation
train_df <- mower_df[train.index,]
validation_df <- mower_df[-train.index,]

library(ggplot2)

#Blue dot is an example of an observation we are trying to predict
ggplot(mower_df, aes(y = Income, x = Lot_Size, color= Ownership)) +
  geom_point(alpha = 0.5) +
  geom_point(mapping = aes(y = 90, x = 17), color = "Blue") + 
  geom_text(aes(label = rowNames), size = 2, nudge_x = 0.5)


ggplot(train_df, aes(y = Income, x = Lot_Size, color= Ownership)) +
  geom_point(alpha = 0.5) +
  geom_point(mapping = aes(y = 90, x = 17), color = "Blue") + 
  geom_text(aes(label = rowNames), size = 2, nudge_x = 0.5)



#Blue dot is the new observation we are trying to predict

# use knn() to compute k nearest neighbors. 
# knn() is available in library FNN (provides a list of the nearest neighbors)
# and library class (allows a numerical output variable).
library(FNN)

#Add column to help keep track of index number.  Index is the row number in the training partition
train_df$Index <- c(1:14)


#get nearest neighbors for test value.  Try changing k to see what happens
nn <- knn(train = train_df[, c(2,1)], test = c(17, 90), 
          cl = train_df[, 3], k = 1, algorithm = c("brute"))
str(nn)

#get the predicted value for the observation
nn[1]

#get the IDs of the closest neighbors
row.names(train_df)[attr(nn, "nn.index")]


library(caret)
library(e1071)


# compute predicted values for different values of k on validation
# compare predicted with actual value


knn.pred <- knn(train_df[, c(2,1)], test = validation_df[, c(2,1)], 
                cl = train_df[, 3], k = 3)
confusionMatrix(knn.pred, as.factor(validation_df$Ownership))


#as a class exercise, rewrite the above code to standardize all values
#see if the results change




