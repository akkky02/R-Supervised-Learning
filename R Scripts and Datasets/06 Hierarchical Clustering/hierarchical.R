#import utilities.df
utilities.df <- read.csv("Utilities.csv")
View(utilities.df)

# set row names to the Company name column
row.names(utilities.df) <- utilities.df[,1]

# remove the Company name column
utilities.df <- utilities.df[,-1]
d <- dist(utilities.df, method = "euclidean")
print(d)

# normalize utilities.df variables so all variables have mean of 0 and sd of 1
utilities.df.norm <- scale(utilities.df, center = TRUE, scale = TRUE)
View(utilities.df.norm)

# calculate normalized distance based on all 8 variables  
d.norm <- dist(utilities.df.norm, method = "euclidean")
m <- as.matrix(d.norm)



#In hclust() set argument method = to "ward.D", "single", "complete", "average", "median", or "centroid"
#Hierarchical clustering using "single" distance measure
hc1 <- hclust(d.norm, method = "single")

hc1
str(hc1)
#display dendogram of hc1
#hang: hang -1 adjusts cluster names so that names appear on x axis
#ann: a logical value indicating whether the default annotation (title and x and y axis labels) 
#should appear on the plot.
plot(hc1, hang = -1, ann = FALSE)

#Hierarchical clustering using "average" distance measure
hc2 <- hclust(d.norm, method = "average")
plot(hc2, hang = -1, ann = FALSE)

plot(hc2)
#assign observations to '6' clusters using splits depicted in map
memb <- cutree(hc1, k = 4)

View(memb)
write.csv(memb, "hc_single.csv")

#assign observations to '6' clusters using splits depicted in map
memb_average <- cutree(hc2, k = 4)
View(memb_average)
write.csv(memb_average, "hc_avg.csv")

# label clusters and add company name
row.names(utilities.df.norm) <- paste(memb_average, ": ", row.names(utilities.df.norm), sep = "")
View(utilities.df.norm)

# plot heatmap 
# rev() reverses the color mapping to large = dark
heatmap(as.matrix(utilities.df.norm), Colv = NA, hclustfun = hclust, 
        col=rev(paste("gray",1:99,sep="")))


#calculate cluster centers
library(dplyr)
cluster_v <- substr(row.names(utilities.df.norm), 1, 1)
df <- data.frame(cluster_v, utilities.df.norm)
cluster_centers <- df %>% group_by(cluster_v) %>% summarise(FixedChargeMean = mean(Fixed_charge),
                                                            RoRMean = mean(RoR),
                                                            CostMean = mean(Cost),
                                                            LoadFactorMean = mean(Load_factor),
                                                            DemandGrowthMean = mean(Demand_growth),
                                                            SalesMean = mean(Sales),
                                                            NuclearMean = mean(Nuclear),
                                                            FuelCostMean = mean(Fuel_Cost)
)
View(cluster_centers)    
write.csv(cluster_centers,'cluster_centers.csv')
