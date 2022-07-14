library(readxl)
netflix.df <- read_excel("Netflix.xlsx")
View(netflix.df)
str(netflix.df)

#show how to coerce read_excel to a data frame (not needed but good to know)
netflix.df <- as.data.frame(read_excel("Netflix.xlsx"))
View(netflix.df)
str(netflix.df)

#R studio also has "import dataset feature

#add customerID as a row label store row names and col names in a vector for later use
row.names <- netflix.df[,1]
str(row.names)
col.names <- names(netflix.df)
str(col.names)
print(row.names)
print(col.names)

net.df <- data.frame(netflix.df[,2:10], row.names = row.names)

#two mechanisms for calculating collaborative filter: by hand and using recommender lab package
#for each approach, we can calculate item based (distance and/or correlations) and 
#user based (distance and/or correlation). Goal is to find the closest item(s) and/or user(s)
#we recommend the closest items if using item based. User based requires an additional step.
#for user based, we find the closest (most similar) user and identify the highest ranked items
#for that user that the current user has not watched (purchased). These are the items we recommend

#calculate correlation between items (movies) to get item based recommendations. remove first column as it is customerID
ibcf <- cor(netflix.df[,2:10], method = c("pearson"), use = c("pairwise.complete.obs"))
print(ibcf)
#what movie would you recommend for someone had watched/purchased M28?

netflixt.df <- t(netflix.df[,2:10])
View(netflixt.df)

#calculate distance between items (movies) to get item based recommendations. remove first column as it is customerID
dist(t(netflix.df[,2:10]), method = "euclidean", diag = TRUE)
#what movie would you recommend for someone had watched/purchased M28?

#calculate correlation between users (customers) to get nearest users. remove first column 
#as it is customerID
ubcf <- cor(t(netflix.df[,2:10]), method = c("pearson"), use = c("pairwise.complete.obs"))
print(ubcf)
#which user is most similar to user 1 using correlation?

#calculate distance between users (customers) to get nearest users. remove first column as it is customerID
dist(netflix.df[,2:10], method = "euclidean", diag = TRUE)
#which user is most similar to user 1 using distance?
#what movie would you recommend for user 1?




#can do the same with recommenderlab package
#load recommender lab library to calculate user based collaborative filter
library(recommenderlab)
m <- as.matrix(netflix.df[2:10])
str(m)
View(m)
r <- as(m, "realRatingMatrix")
str(r)


# user-rating based recommendation for user 1
# will compute the predicted ratings of movies that are the closest from among the movies not watched by user 1
# the ratings will be predicted by taking the weighted average of movie ratings for similar users
# r[1,] stands for the 1st row/user, n = 3 stands for 3 nearest neighbors, type = "topNList" stands for the closest n neighbours
UB.Rec <- Recommender(r, "UBCF")
pred <- predict(UB.Rec, r[1,], n = 3, type = "topNList")
as(pred, "matrix")

 

