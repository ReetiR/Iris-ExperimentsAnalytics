#install.packages("ggvis")
#install.packages("class")
#install.packages("gmodels")

iris
iris <- read.csv("Documents/Iris/Iris.csv", header= FALSE)
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

#some plots
library(ggvis)
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()
#

str(iris)

#normalize
library(class)
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
summary(iris_norm)
#

#training and testing
set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iris.training <- iris[ind==1, 1:4]
iris.test <- iris[ind==2, 1:4]
iris.trainLabels <- iris[ind==1, 5]
iris.trainLabels
iris.testLabels <- iris[ind==2, 5]
iris.testLabels
#

#building classifier
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)
iris_pred
#

#building classifier
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=4)
iris_pred
#

#evaluation
library(gmodels)
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=TRUE)
#
