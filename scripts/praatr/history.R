source('D:/R-course/corr.R')
corr()
source('D:/R-course/complete.R')
corr()
source('D:/R-course/corr.R')
corr(1:4)
corr(500)
corr(threshold=500)
source('D:/R-course/corr.R')
corr(threshold=500)
source('D:/R-course/corr.R')
corr(threshold=500)
mdata <- read.csv("specdata/001.csv")
mdata
head(mdata)
mydata$sulfate
mdata$sulfate
class(mdata$sulfate)
source('D:/R-course/corr.R')
corr(threshold=500)
corr(threshold=150)
source('D:/R-course/corr.R')
corr(threshold=150)
corr(threshold=400)
corr(threshold=5000)
corr(threshold=0)
source('D:/R-course/corr.R')
corr(threshold=0)
source('D:/R-course/corr.R')
corr(threshold=0)
corr(threshold=150)
corr(threshold=5000)
source('D:/R-course/corr.R')
submit()
source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
submit()
str(corrvect)
str(corr)
makeVector <- function(x = numeric()) {
m <- NULL
set <- function(y) {
x <<- y
m <<- NULL
}
get <- function() x
setmean <- function(mean) m <<- mean
getmean <- function() m
list(set = set, get = get,
setmean = setmean,
getmean = getmean)
}
cachemean <- function(x, ...) {
m <- x$getmean()
if(!is.null(m)) {
message("getting cached data")
return(m)
}
data <- x$get()
m <- mean(data, ...)
x$setmean(m)
m
}
makeVector(1:4)
vect <- makeVector()
cachemean(vect)
cachemean(vect,1)
cachemean(vect,1:4)
x <<- 1:4
x
cachemean(vect)
x
m
vect$set(1:4)
vect$set(1:6)
x
y
traceback()
m
vect$get
vect$get()
vect$getmean()
vect$setmean()
vect$setmean(mean(vect$get()))
vect$getmean()
cachemean(vect)
vect$set(1:5)
cachemean(vect)
source('D:/R-course/pa2-repo/cachematrix.R')
cm <- makeCacheMatrix()
cm$set(matrix(1:9,3,3))
cm$get()
cacheSolve(cm)
cm$set(matrix(1,3,3))
cacheSolve(cm)
mm <- c(1,0,5,2,1,6,3,4,0)
cm$set(matrix(mm,3,3))
cm$get()
cacheSolve(cm)
source('D:/R-course/pa2-repo/cachematrix.R')
m
m <- c(1,0,5,2,1,6,3,4,0)
cm <- makeCacheMatrix()
cm$set(matrix(m,3,3))
cm$get()
source('D:/R-course/pa2-repo/cachematrix.R')
cacheSolve(cm)
source('D:/R-course/pa2-repo/cachematrix.R')
cacheSolve(cm)
cm$set(matrix(m,3,3))
cacheSolve(cm)
swirl()
library(swirl)
ls()
rm(list=ls())
swirl()
ls()
class(plants)
dim(plants)
nrow(plants)
ncol(plants)
object.size(plants)
names(plants)
head(plants)
head(plants,10)
tail(plants,15)
summary(plants)
table(plants$Active_Growth_Period)
str(plants)
?sample
sample(1:6,4,replace=TRUE)
sample(1:20,10)
LETTERS
sample(LETTERS)
sample(c(0,1),100,replace=TRUE,prob=c(0.3,0.7))->flips
flips
sum(flips)
?rbinom
rbinom(1,size=100,prob=0.7)
rbinom(100,size=1,prob=0.7)->flips2
flips2
sum(flips2)
?rnorm
rnorm(10)
rnorm(10,100,25)
?rpois
rpois(5,lambda=10)
replicate(rpois(5,lambda=10))->my_pois
replicate(100,rpois(5,lambda=10))->my_pois
replicate(100,rpois(5,10))->my_pois
my_pois
cm<-colMeans(my_pois)
hist(cm)
d1<-Sys.Date()
class(d1)
unclass(d1)
d1
d2<-as.Date("1969-01-01")
unclass(d2)
Sys.time()
Sys.time()->t1
t1
class(t1)
unclass(t1)
as.POSIXlt(Sys.time())->t2
class(t2)
unclass(t2)
t2
unclass(t2)
str(unclass(t2))
t2$min
weekday(d1)
weekdays(d1)
weekdays(t1)
months(t1)
quarters(t2)
t3<-"October 17, 1986 08:24"
strptime(t3, "%B %d, %Y %H:%M")->t4
t4
class(t4)
Sys.time() > t1
Sys.time() - t1
difftime(Sys.time(), t1, units='days')
data(cars)
?cars
head(cars)
plot(cars)
?plot
plot(x=cars$speed,y=cars$dist)
plot(y=cars$speed,X=cars$dist)
plot(y=cars$speed,x=cars$dist)
plot(x=cars$speed,y=cars$dist,xlab = "Speed")
plot(x=cars$speed,y=cars$dist,xlab = "Speed",ylab = "Stopping Distance")
plot(x=cars$speed,y=cars$dist,ylab = "Stopping Distance")
plot(x=cars$speed,y=cars$dist,xlab = "Speed",ylab = "Stopping Distance")
plot(cars,main="My Plot")
plot(cars,sub="My Plot Subtitle")
plot(cars,col=2)
plot(cars,xlim=c(10,15))
plot(cars,pch=2)
data(mtcars)
play()
head(mtcars)
dim(mtcars)
nxt()
?boxplot
boxplot(data=mtcars, formula=mpg~cyl)
boxplot(mtcars, formula=mpg~cyl)
boxplot(formula=mpg~cyl, data=mtcars)
hist(mtcars$mpg)
library(phonR)
library(rggobi)
install.packages(rggobi)
install.packages("rggobi")
library(rggobi)
remove.packages(rggobi)
remove.packages("rggobi")
remove.packages("RGtk2")
install.packages("RIGHT")
install.packages("car")
install.packages("RIGHT")
install.packages("car")
install.packages("C:\DSTB\PROG\r-interactive-graphics-via-html-master.zip")
install.packages("C:/DSTB/PROG/r-interactive-graphics-via-html-master.zip")
install.packages("C:/DSTB/PROG/car_2.0-25.zip")
install.packages("car")
install.packages("C:/DSTB/PROG/car_2.0-25.zip")
install.packages("car")
install.packages("RIGHT")
install.packages("rgl")
install.packages("languageR")
source('D:/R-course/praatr/00-pre-phonetic.R')
source('D:/R-course/praatr/01-load_data.R')
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
myplot.gg(speaker = "PSX",formants = "two.three")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX",formants = "two.three")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX",formants = "two.three")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX",formants = "two.three")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX",formants = "two.three")
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
source('D:/R-course/praatr/00-pre-phonetic.R')
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
??geom
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
??element_rect
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
source('D:/R-course/praatr/02-plot_identify.R')
myplot.gg(speaker = "PSX")
myplot.gg(speaker = "PSX",formants = "two.three")
myplot.gg(speaker = "PSX")
myplot.gg(speaker = "PSX",formants = "two.three")
myplot.gg(speaker = "HDK")
myplot.gg(speaker = "HDK",formants = "two.three")
myplot.gg(speaker = "JSP")
myplot.gg(speaker = "JSP",formants = "two.three")
View(data.c)
table(rpois(100, 5))
table(data.c[c(1:2,9),])
table(data.c[1:2,])
data.sum <- data.c[1:2,]
data.sum
data.sum <- data.c[,1:2]
data.sum
data.sum <- data.c[,c(1:2,9)]
table(data.sum)
table(data.sum[data.sum$speaker=="JSP"])
table(data.sum[data.sum$speaker=="JSP"],)
table(data.sum[data.sum$speaker=="JSP",])
data.sum.J <- data.J[,c(2,9)]
table(data.sum.J)
View(data.J)
data.sum.J <- data.J[,c(19,9)]
table(data.sum.J)
data.sum <- data.c[,c("grps","long","speaker")]
table(data.sum)
data.sum <- data.c[,c("long","grps","speaker")]
table(data.sum)
data.sum <- data.c[,c("grps","speaker")]
table(data.sum)
savehistory("D:/R-course/praatr/history.R")
