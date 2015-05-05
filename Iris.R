#include.packages("neuralnet")
library(neuralnet)
mydata = read.csv("Documents/Iris/Iris.csv", header=TRUE, sep=";")
mydata
data(mydata)
fm <- glm()
library(caret);
install.packages("neuralnet")
library(neuralnet)
data(iris)
factor(iris$Species)
# the data
T<-createDataPartition(y=iris$Species,p=0.75,list=FALSE)
tr<-iris[T,]
test<-iris[-T,]
fit <- glm(Species~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,data=tr,family=binomial())
summary(fit)
wt<-c(0.56,0.56,0.1,0.78)
# training the model
backnet = neuralnet( data= tr,formula=fit,wt, hidden=2, err.fct="sse", linear.output=FALSE, algorithm="backprop", learningrate=0.01)
#nn.bp <- neuralnet(Species~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,data=tr, hidden=2, err.fct="sse",linear.output=FALSE, algorithm="backprop", learningrate=0.01)
#backnet = neuralnet(fm, iris, hidden=10, learningrate=0.01)
print (nn.bp)
valnet = compute(backnet, test)
print (valnet$net.result)