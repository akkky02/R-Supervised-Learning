getwd()
library(tidyverse) #use this package for the hands on
diamonds.df <- data.frame(diamonds)
View(diamonds.df)
v <- sapply(diamonds.df,is.numeric)
v
df <- diamonds_df[,sapply(diamonds_df, is.numeric)]
df <- diamonds.df[,sapply(diamonds.df,is.numeric)]
summary(diamonds.df)

diamonds_stats_df <- data.frame(  mean=sapply(df, mean), 
                            median=sapply(df, median), 
                            sd=sapply(df, sd), 
                            variance=sapply(df, var),
                            min=sapply(df, min), 
                            max=sapply(df, max), 
                            count=sapply(df, length),
                            miss.val=sapply(df, function(x) 
                              sum(length(which(is.na(x))))))

View(diamonds_stats_df)
hist(diamonds.df$price, xlab = "Price",col='grey')

par(mfcol = c(2, 2))
boxplot(diamonds.df$price ~ diamonds.df$cut, xlab = "cut", ylab = "price")

boxplot(diamonds.df$price ~ diamonds.df$color, xlab = "color", ylab = "price")

library(ggplot2)
ggplot(diamonds.df) + geom_point(aes(x = carat, y = price), colour = "navy", alpha = 0.2)

plot(diamonds.df[, c(1, 8, 9, 10, 7)])

# scatter plot matrix with GGally 
library(GGally)
ggpairs(diamonds.df[, c(1, 8, 9, 10, 7)])
