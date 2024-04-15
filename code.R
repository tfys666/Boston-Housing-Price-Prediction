install.packages("car")
install.packages("corrplot")
install.packages("MASS")
library(car)
library(corrplot)
library(MASS)

data_boston = read.csv("boston_housing_data.csv")
is.na(data_boston)

Y=data_boston[,14]
X=data_boston[,c(1:13)]
p=ncol(X)
n=nrow(X)

#一维图
par(mfrow=c(1,3))
hist(Y)
dotchart(Y)
boxplot(Y)
#二维图
pairs(data_boston[,-14])
cor=cor(data_boston[-14,-14])
par(mfrow=c(1,1))
corrplot(cor, method = "color", addCoef.col = "black", number.cex = 0.7, tl.col = "black")

lm1=lm(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PIRATIO+B+LSTAT,data=data_boston)
summary(lm1)
vif(lm1)
aic1=AIC(lm1)
bic1=BIC(lm1)
sbc1=AIC(lm1, k = log(nrow(model.frame(lm1))))
cat("AIC:", aic1, "\n")
cat("BIC:", bic1, "\n")
cat("SBC:", sbc1, "\n")

par(mfrow=c(2,2))
plot(lm1)
par(mfrow=c(1,3))
r=rstandard(lm1)
qqnorm(r,ylab="Standardized residuals")
qqline(r)
Yhat=fitted(lm1)
plot(Yhat,r,xlab="Fitted",
     ylab=expression(paste("Standardized"," residuals")))
plot(r, ylab=expression(paste("Standardized"," residuals")))

X_matrix=model.matrix(lm1)
predictor_names=colnames(X_matrix)[-1]
par(mfrow = c(3,5))
for (i in seq_along(predictor_names)) {
  plot(X_matrix[, i + 1], r, xlab = predictor_names[i], ylab = expression(paste("Standardized residuals")))
}

Leverge=influence(lm1)$hat
C=cooks.distance(lm1)
DFITS=dffits(lm1)
e=lm1$residuals
d_square=(e/sqrt(sum(e^2)))^2
pot=Leverge/(1-Leverge)
res=(p+1)*(1/(1-Leverge))*(d_square/(1-d_square))
H=pot+res

par(mfrow=c(3,2))
plot(r,xlab="observation",ylab="Standardized residuals")
plot(Leverge,xlab="observation",ylab="Leverge")
plot(C,xlab="observation",ylab="Cook's distance")
plot(DFITS,xlab="observation",ylab="Welsch and Kuh measure")
plot(H,xlab="observation",ylab="Hadis' influence measure")
plot(res,pot,xlab="Residual",ylab="Potential")
point=c(9,49,149,155,156,163,164,215,254,365,366,369,370,371,373,378,467,491)
for(i in point){
  text(res[i], pot[i], labels=i,adj=(.05))
}

pos1=which(abs(r)>3)
pos1
pos2=which(Leverge>2*(p+1)/n)
pos2
pos3=which(C>qf(0.5,p+1,n-p-1))
pos3
pos4=which(abs(DFITS)>2*sqrt((p+1)/(n-p-1)))
pos4

data_new=data_boston[-c(9,49,149,155,156,163,164,215,254,365,366,369,370,371,373,378,467,491),]
lm2=lm(MEDV~CRIM+ZN+INDUS+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PIRATIO+B+LSTAT,data=data_new)
summary(lm2)
aic2=AIC(lm2)
bic2=BIC(lm2)
sbc2=AIC(lm2, k = log(nrow(model.frame(lm1))))
cat("AIC:", aic2, "\n")
cat("BIC:", bic2, "\n")
cat("SBC:", sbc2, "\n")
anova(lm2)

lm3=lm(MEDV~CRIM+ZN+RM+AGE+DIS+RAD+TAX+PIRATIO+B+LSTAT,data=data_new)
summary(lm3)
aic3=AIC(lm3)
bic3=BIC(lm3)
sbc3=AIC(lm3, k = log(nrow(model.frame(lm1))))
cat("AIC:", aic3, "\n")
cat("BIC:", bic3, "\n")
cat("SBC:", sbc3, "\n")
anova(lm3)

F=((5316.2-5263.4)/(p-3))/(5263.4/(n-p-1))
F0=qf(0.95,p-3,n-p-1)
print(F)
print(F0)
