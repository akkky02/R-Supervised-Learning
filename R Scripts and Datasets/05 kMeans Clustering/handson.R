#import utilities.df
utilities.df <- read.csv("Utilities.csv")

# set row names in utilities.df to values stored in the Company name column
row.names(utilities.df) <- utilities.df[,1]
View(utilities.df)

# remove the Company name column
utilities.df <- utilities.df[,-c(1)]
View(utilities.df)

#get the first seven rows of the dataframe to illustrate calculations
utilities.df.first <- utilities.df[1:7,]
#utilities.df.first <- utilities.df[1:7,]
View(utilities.df.first)


# compute Euclidean distance using all seven variables to further illustrate calculations
d.all <- dist(utilities.df.first, method = "euclidean")
print(d.all)

#set k = 6 to create 6 clusters.  The nstart paramater specifies the number of times to run the cluster analysis with
#different starting points (seeds). 
kmu_5 <- kmeans(utilities.df, 5, nstart = 100)
print(sort(kmu_5$cluster))

# show cluster membership
View(kmu_5$cluster)
write.csv(kmu_5$cluster, "clusters.csv")

# get centroids
View(kmu_5$centers)
write.csv(kmu_5$centers, "clustercenters.csv")


# plot an empty scatter plot
plot(c(0), xaxt = 'n', ylab = "", type = "l", 
     ylim = c(min(kmu_5$centers), max(kmu_5$centers)), xlim = c(0, 8))

# label x-axes
axis(1, at = c(1:8), labels = names(utilities.df))

# plot centroids for n = 6
for (i in c(1:5))
  lines(kmu_5$centers[i,], lty = i, lwd = 2, col = ifelse(i %in% c(1, 3, 5),
                                                        "black", "dark grey"))

# name clusters
text(x = 0.5, y = kmu_5$centers[, 1], labels = paste("Cluster", c(1:5)))


#distance between centers
dist(kmu_5$centers)


#Create an elbow chart to select the best k
#Elbow chart calculates the weighted sum of squares for each cluster.
#Look for change in slope from steep to flat
library(factoextra)
fviz_nbclust(utilities.df, kmeans, method = "wss") + theme_minimal() + ggtitle("Elbow Chart")

#based on elbow chart, set k = 5
kmu_5 <- kmeans(utilities.df, 5, nstart = 100)
print(sort(kmu_5$cluster))

print(kmu_5$centers)
print(dist(kmu_5$centers))

# plot an empty scatter plot
plot(c(0), xaxt = 'n', ylab = "", type = "l", 
     ylim = c(min(kmu_5$centers), max(kmu_5$centers)), xlim = c(0, 8))


# label x-axes
axis(1, at = c(1:8), labels = names(utilities.df))

# plot centroids for n = 
for (i in c(1:5))
  lines(kmu_5$centers[i,], lty = i, lwd = 2, col = ifelse(i %in% c(1, 3, 5),
                                                         "black", "dark grey"))

# name clusters
text(x = 0.5, y = kmu_5$centers[, 1], labels = paste("Cluster", c(1:5)))




#create a plot of the clusters using fviz.  If more than 2 variables are used, fviz uses the 
#first two principal components for the x and y axis
fviz_cluster(kmu_5, data = utilities.df)








