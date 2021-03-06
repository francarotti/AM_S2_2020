######################
# Pacotes necess�rios
library(car)
library(xtable)
library(plyr)
library(plotrix)

# limpar todas as vari�veis 
rm(list = ls(all.names = TRUE))

#
###############
# Dados da iris
especie <- iris[,5]
n <- nrow(iris)
mx<-as.matrix(iris[,1:4])
nvar<-4
inames <- c("comprimento da s�pala","largura da s�pala","comprimento da p�tala","largura da p�tala")
irisd <- iris[,1:4]
colnames(irisd)<-c("CS","LS","CP","LP")

##########
# Boxplots
par(mfrow =c(2,2))
#
boxplot(iris[,1]~especie,xlab="esp�cie",ylab="comprimento da s�pala",cex=1.3,cex.lab=1.3,cex.axis=1.3)
boxplot(iris[,2]~especie,xlab="esp�cie",ylab="largura da s�pala",cex=1.3,cex.lab=1.3,cex.axis=1.3)
boxplot(iris[,3]~especie,xlab="esp�cie",ylab="comprimento da p�tala",cex=1.3,cex.lab=1.3,cex.axis=1.3)
boxplot(iris[,4]~especie,xlab="esp�cie",ylab="largura da p�tala",cex=1.3,cex.lab=1.3,cex.axis=1.3)
#
#############
# Histogramas
#
# setosa
par(mfrow =c(2,2))
for (j in 1:nvar)
{
  hist(irisd[especie=="setosa",j],xlab=inames[j],ylab="densidade",main="setosa",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
}
# versicolor
par(mfrow =c(2,2))
for (j in 1:nvar)
{
  hist(irisd[especie=="versicolor",j],xlab=inames[j],ylab="densidade",main="versicolor",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
}
# virginica
par(mfrow =c(2,2))
for (j in 1:nvar)
{
  hist(irisd[especie=="virginica",j],xlab=inames[j],ylab="densidade",main="virginica",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
}
#hist(irisd[especie=="setosa",1],xlab="comprimento da s�pala",ylab="densidade",main="setosa",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
#hist(irisd[especie=="setosa",2],xlab="largura da s�pala",ylab="densidade",main="setosa",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
#hist(irisd[especie=="setosa",3],xlab="comprimento da p�tala",ylab="densidade",main="setosa",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
#hist(irisd[especie=="setosa",4],xlab="largura da p�tala",ylab="densidade",main="setosa",probability=TRUE,cex=1.3,cex.lab=1.3,cex.axis=1.3)
#
# Gr�ficos de dispers�o
par(mfrow =c(1,1))
plot(irisd[especie=="setosa",],cex=1.3,cex.axis=1.3,cex.lab=1.3,pch=19,main="Iris setosa")
plot(irisd[especie=="versicolor",],cex=1.3,cex.axis=1.3,cex.lab=1.3,pch=19,main="Iris versicolor")
plot(irisd[especie=="virginica",],cex=1.3,cex.axis=1.3,cex.lab=1.3,pch=19,main="Iris virginica")

####################
# An�lise descritiva
#
# correla��es e covari�ncia
auxc <-by(irisd,especie,cov)
auxcor <-by(irisd,especie,cor)
aux.matrix<- ifelse(lower.tri(as.matrix(auxc$setosa),diag=TRUE),1,0)
aux.matrix1<- ifelse(upper.tri(as.matrix(auxc$setosa)),1,0)
mat.set <- as.matrix(auxc$setosa)*aux.matrix +   as.matrix(auxcor$setosa)*aux.matrix1
mat.set<- round(mat.set,3)
xtable(mat.set)
mat.ver <- as.matrix(auxc$versicolor)*aux.matrix +   as.matrix(auxcor$versicolor)*aux.matrix1
mat.ver<- round(mat.ver,3)
xtable(mat.ver)
mat.vir <- as.matrix(auxc$virginica)*aux.matrix +   as.matrix(auxcor$virginica)*aux.matrix1
mat.vir<- round(mat.vir,3)
xtable(mat.vir)
#
################
# Medidas resumo
CS <- irisd[,1]
datadados<-data.frame(CS,especie)
medados<-ddply(datadados,.(especie),summarise,media=mean(CS),dp=sqrt(var(CS)),vari=var(CS),cv=100*((sqrt(var(CS))/mean(CS))),minimo=min(CS),mediana=quantile(CS,0.5),maximo=max(CS),n=length(CS))
xtable(medados)
#
LS <- irisd[,2]
datadados<-data.frame(LS,especie)
medados<-ddply(datadados,.(especie),summarise,media=mean(LS),dp=sqrt(var(LS)),vari=var(LS),cv=100*((sqrt(var(LS))/mean(LS))),minimo=min(LS),mediana=quantile(LS,0.5),maximo=max(LS),n=length(LS))
xtable(medados)
#
CP <- irisd[,3]
datadados<-data.frame(CP,especie)
medados<-ddply(datadados,.(especie),summarise,media=mean(CP),dp=sqrt(var(CP)),vari=var(CP),cv=100*((sqrt(var(CP))/mean(CP))),minimo=min(CP),mediana=quantile(CP,0.5),maximo=max(CP),n=length(CP))
xtable(medados)
#
LP <- irisd[,4]
datadados<-data.frame(LP,especie)
medados<-ddply(datadados,.(especie),summarise,media=mean(LP),dp=sqrt(var(LP)),vari=var(LP),cv=100*((sqrt(var(LP))/mean(LP))),minimo=min(LP),mediana=quantile(LP,0.5),maximo=max(LP),n=length(LP))
xtable(medados)
#
########################################
# Gr�ficos quantis-quantis com envelopes
par(mfrow=c(2,2)) 
for (j in 1:nvar)
{
  qqPlot(scale(mx[especie=="setosa",j]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o da ",inames[j]),cex=1.2)
}
#
par(mfrow=c(2,2)) 
for (j in 1:nvar)
{
  qqPlot(scale(mx[especie=="versicolor",j]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o da ",inames[j]),cex=1.2)
}
#
par(mfrow=c(2,2)) 
for (j in 1:nvar)
{
  qqPlot(scale(mx[especie=="virginica",j]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o da ",inames[j]),cex=1.2)
}
#
# Envelopes para a forma quadr�tica
par(mfrow=c(1,3))
#
vmu <- apply(mx[especie=="setosa",],2,mean)
s2 <- cov(mx[especie=="setosa",])
n0<-nrow(mx[especie=="setosa",])
mmu <- t(matrix(t(vmu),nvar,n0))
#vF <- apply(((mx-vmu)*(mx-vmu)%*%solve(s2)),1,sum)
#vF<- (n0-nvar)*vF/((n0-1)*nvar)
#qqPlot(vF,dist="f",df1=nvar,df2=n0-nvar,col.lines=1,grid="FALSE",xlab="quantil da distribui��o F",ylab="quantil da forma quadr�tica",cex=1.2,id.cex=1.2)
#vQ <- n*apply(((mx-vmu)*(mx-vmu)%*%solve(s2)),1,sum)
vQ <- n*mahalanobis(mx,center=vmu,cov=s2)
qqPlot(vQ,dist="chisq",df=nvar,col.lines=1,grid="FALSE",xlab="quantil da distribui��o qui-quadrado",ylab="quantil da forma quadr�tica",cex=1.2,main="setosa")

#
vmu <- apply(mx[especie=="versicolor",],2,mean)
s2 <- cov(mx[especie=="versicolor",])
n0<-nrow(mx[especie=="versicolor",])
mmu <- t(matrix(t(vmu),nvar,n0))
#vF <- apply(((mx-vmu)*(mx-vmu)%*%solve(s2)),1,sum)
#vF<- (n0-nvar)*vF/((n0-1)*nvar)
#qqPlot(vF,dist="f",df1=nvar,df2=n0-nvar,col.lines=1,grid="FALSE",xlab="quantil da distribui��o F",ylab="quantil da forma quadr�tica",cex=1.2,id.cex=1.2)
#
#vQ <- n*apply(((mx-vmu)*(mx-vmu)%*%solve(s2)),1,sum)
vQ <- n*mahalanobis(mx,center=vmu,cov=s2)
qqPlot(vQ,dist="chisq",df=nvar,col.lines=1,grid="FALSE",xlab="quantil da distribui��o qui-quadrado",ylab="quantil da forma quadr�tica",cex=1.2,main="versicolor")

vmu <- apply(mx[especie=="virginica",],2,mean)
s2 <- cov(mx[especie=="virginica",])
n0<-nrow(mx[especie=="virginica",])
mmu <- t(matrix(t(vmu),nvar,n0))
#vF <- apply(((mx-vmu)*(mx-vmu)%*%solve(s2)),1,sum)
#vF<- (n0-nvar)*vF/((n0-1)*nvar)
#qqPlot(vF,dist="f",df1=nvar,df2=n0-nvar,col.lines=1,grid="FALSE",xlab="quantil da distribui��o F",ylab="quantil da forma quadr�tica",cex=1.2,id.cex=1.2)
#vQ <- n*apply(((mx-vmu)*(mx-vmu)%*%solve(s2)),1,sum)
vQ <- n*mahalanobis(mx,center=vmu,cov=s2)
qqPlot(vQ,dist="chisq",df=nvar,col.lines=1,grid="FALSE",xlab="quantil da distribui��o qui-quadrado",ylab="quantil da forma quadr�tica",cex=1.2,main="virginica")

#
#
###################################
# An�lise de vari�ncia Multivariada
#
source("./MANOVA_Multivariada_ME_731_2S_2020.R")
source("./Diag Multivariate Linear Models ME 731 2S 2020.R", encoding = "windows-1252")
v.grupos <- cbind(as.numeric(especie))
v.n<-rbind(50,50,50)
G<-3
p<-4
# Teste de iguldade das matrizes de covari�ncia
m.Sigma.P<-Box.teste.Igual.MCov(irisd,v.grupos,v.n,G)$Sigma.P
#
# Compara��o dos vetores de m�dias
fit.model<-m.ajuste <- manova(as.matrix(irisd) ~ especie)
summary.manova(m.ajuste,test="Wilks")
summary.manova(m.ajuste,test="Pillai")
summary.manova(m.ajuste,test="Hotelling-Lawley")
summary.manova(m.ajuste,test="Roy")
library(xtable)
aux<-summary.aov(m.ajuste)
fit.modelLM <- lm(as.matrix(irisd) ~ especie)

########################
# Compara��es m�ltiplas
#
# Vari�vel CS
m.C1 <- cbind(0,1,0) #  Setosa X Versicolor
m.C2 <- cbind(0,0,1) # Setosa X Virginica
m.C3 <- cbind(0,1,-1) # Versicolor X Virginica
m.U <- rbind(1,0,0,0)
m.M <- 0
#
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C1,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C2,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C3,m.U,m.M)
#
# Vari�vel LS
m.C1 <- cbind(0,1,0) #  Setosa X Versicolor
m.C2 <- cbind(0,0,1) # Setosa X Virginica
m.C3 <- cbind(0,1,-1) # Versicolor X Virginica
m.U <- rbind(0,1,0,0)
m.M <- 0
#
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C1,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C2,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C3,m.U,m.M)
#
# Vari�vel CP
m.C1 <- cbind(0,1,0) #  Setosa X Versicolor
m.C2 <- cbind(0,0,1) # Setosa X Virginica
m.C3 <- cbind(0,1,-1) # Versicolor X Virginica
m.U <- rbind(0,0,1,0)
m.M <- 0
#
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C1,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C2,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C3,m.U,m.M)
#
# Vari�vel LP
m.C1 <- cbind(0,1,0) #  Setosa X Versicolor
m.C2 <- cbind(0,0,1) # Setosa X Virginica
m.C3 <- cbind(0,1,-1) # Versicolor X Virginica
m.U <- rbind(0,0,0,1)
m.M <- 0
#
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C1,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C2,m.U,m.M)
TesteF.CBU.M(fit.model,m.Sigma.P,p,G,m.C3,m.U,m.M)
#
# M�dias preditas pelo modelo
m.B <- matrix(coef(fit.model),G,p)
v.beta <- matrix(t(m.B))
m.X <- model.matrix(fit.model)
m.Sigmabeta <- kronecker(solve(t(m.X)%*%m.X),m.Sigma.P)
# CS
m.muCS <- rbind(cbind(1,0,0,0,0,0,0,0,0,0,0,0),cbind(1,0,0,0,1,0,0,0,0,0,0,0),cbind(1,0,0,0,0,0,0,0,1,0,0,0)) 
m.preCS <- m.muCS%*%v.beta
m.epCS <-  sqrt(diag(m.muCS%*%m.Sigmabeta%*%t(m.muCS)))
m.ICCS <- cbind(m.preCS-1.96*m.epCS,m.preCS+1.96*m.epCS)
# LS
m.muLS <- rbind(cbind(0,1,0,0,0,0,0,0,0,0,0,0),cbind(0,1,0,0,0,1,0,0,0,0,0,0),cbind(0,1,0,0,0,0,0,0,0,1,0,0)) 
m.preLS <- m.muLS%*%v.beta
m.epLS <-  sqrt(diag(m.muLS%*%m.Sigmabeta%*%t(m.muLS)))
m.ICLS <- cbind(m.preLS-1.96*m.epLS,m.preLS+1.96*m.epLS)
# CP
m.muCP <- rbind(cbind(0,0,1,0,0,0,0,0,0,0,0,0),cbind(0,0,1,0,0,0,1,0,0,0,0,0),cbind(0,0,1,0,0,0,0,0,0,0,1,0)) 
m.preCP <- m.muCP%*%v.beta
m.epCP <-  sqrt(diag(m.muCP%*%m.Sigmabeta%*%t(m.muCP)))
m.ICCP <- cbind(m.preCP-1.96*m.epCP,m.preCP+1.96*m.epCP)
# LP
m.muLP <- rbind(cbind(0,0,0,1,0,0,0,0,0,0,0,0),cbind(0,0,0,1,0,0,0,1,0,0,0,0),cbind(0,0,0,1,0,0,0,0,0,0,0,1)) 
m.preLP <- m.muLP%*%v.beta
m.epLP <-  sqrt(diag(m.muLP%*%m.Sigmabeta%*%t(m.muLP)))
m.ICLP <- cbind(m.preLP-1.96*m.epLP,m.preLP+1.96*m.epLP)

#
par(mfrow=c(2,2))
plotCI(m.preCS,ui=m.ICCS[,2],li=m.ICCS[,1],axes=FALSE,xlab="esp�cie",ylab="m�dia",pch=19,cex=1.2,cex.lab=1.2,cex.axis=1.2,main="CS")
axis(2,seq(4,7,0.2),cex.axis=1.2)
axis(1,1:3,c("setosa","versicolor","virginica"),cex.axis=1.2)
#
plotCI(m.preLS,ui=m.ICLS[,2],li=m.ICLS[,1],axes=FALSE,xlab="esp�cie",ylab="m�dia",pch=19,cex=1.2,cex.lab=1.2,cex.axis=1.2,main="LS")
axis(2,seq(2,4,0.2),cex.axis=1.2)
axis(1,1:3,c("setosa","versicolor","virginica"),cex.axis=1.2)
#
plotCI(m.preCP,ui=m.ICCP[,2],li=m.ICCP[,1],axes=FALSE,xlab="esp�cie",ylab="m�dia",pch=19,cex=1.2,cex.lab=1.2,cex.axis=1.2,main="CP")
axis(2,seq(1,6,0.2),cex.axis=1.2)
axis(1,1:3,c("setosa","versicolor","virginica"),cex.axis=1.2)
#
plotCI(m.preLP,ui=m.ICLP[,2],li=m.ICLP[,1],axes=FALSE,xlab="esp�cie",ylab="m�dia",pch=19,cex=1.2,cex.lab=1.2,cex.axis=1.2,main="LP")
axis(2,seq(0,3,0.2),cex.axis=1.2)
axis(1,1:3,c("setosa","versicolor","virginica"),cex.axis=1.2)


# Res�duos univariados
mY <- as.matrix(irisd)
mresult<-m.ajuste
typeresid <- "univariate"
wplot <- "diagnostics"
#
# CS
var<-1
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LS
var<-2
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# CP
var<-3
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LP
var<-4
gen.graf.resid(mY,mresult,var,typeresid,wplot)

# Zoom nos envelopes
wplot <- "envelope"
#
# CS
var<-1
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LS
var<-2
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# CP
var<-3
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LP
var<-4
gen.graf.resid(mY,mresult,var,typeresid,wplot)


# Res�duos multivariados

typeresid <- "multivariate"
wplot <- "diagnostics"
#
# CS
var<-1
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LS
var<-2
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# CP
var<-3
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LP
var<-4
gen.graf.resid(mY,mresult,var,typeresid,wplot)

# Zoom nos envelopes
wplot <- "envelope"
#
# CS
var<-1
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LS
var<-2
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# CP
var<-3
gen.graf.resid(mY,mresult,var,typeresid,wplot)
# LP
var<-4
gen.graf.resid(mY,mresult,var,typeresid,wplot)

# Res�duo baseado na dist�ncia Mahalanobis

gen.graf.resid.quad.form(mY,mresult)
  


# Daqui para a frente est� "desativado"

#
#
# Res�duos ordin�rios
m.residuo <- m.ajuste$residuals
m.X <-as.matrix(model.matrix(m.ajuste))
auxres <- diag((diag(n) - m.X%*%solve(t(m.X)%*%m.X)%*%t(m.X)))
m.residuo <- m.residuo/(sqrt((matrix(auxres,150,4))%*%diag(diag(m.Sigma.P))))
#m.residuo <- m.residuo%*%solve(diag(diag(m.Sigma.P)))
#m.residuo <- m.residuo/sqrt(1-matrix(auxres,150,4))
m.ajustado <- fitted.values(m.ajuste)
#
# CS
par(mfrow =c(2,2))
plot(m.residuo[,1],ylim=c(min(-3,min(m.residuo[,1])),max(3,max(m.residuo[,1]))),xlab="�ndice",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
plot(m.ajustado[,1],m.residuo[,1],ylim=c(min(-3,min(m.residuo[,1])),max(3,max(m.residuo[,1]))),xlab="valor ajustado",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
hist(m.residuo[,1],probability=TRUE,xlab="res�duo studentizado",main="",ylab="densidade")
#
qqPlot((m.residuo[,1]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
# LS
par(mfrow =c(2,2))
plot(m.residuo[,2],ylim=c(min(-3,min(m.residuo[,2])),max(3,max(m.residuo[,2]))),xlab="�ndice",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
plot(m.ajustado[,2],m.residuo[,2],ylim=c(min(-3,min(m.residuo[,2])),max(3,max(m.residuo[,2]))),xlab="valor ajustado",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
hist(m.residuo[,2],probability=TRUE,xlab="res�duo studentizado",main="",ylab="densidade")
#
qqPlot((m.residuo[,2]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
# CP
par(mfrow =c(2,2))
plot(m.residuo[,3],ylim=c(min(-3,min(m.residuo[,3])),max(3,max(m.residuo[,3]))),xlab="�ndice",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
plot(m.ajustado[,3],m.residuo[,3],ylim=c(min(-3,min(m.residuo[,3])),max(3,max(m.residuo[,3]))),xlab="valor ajustado",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
hist(m.residuo[,3],probability=TRUE,xlab="res�duo studentizado",main="",ylab="densidade")
#
qqPlot((m.residuo[,3]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
# LP
par(mfrow =c(2,2))
plot(m.residuo[,4],ylim=c(min(-3,min(m.residuo[,4])),max(3,max(m.residuo[,4]))),xlab="�ndice",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
plot(m.ajustado[,4],m.residuo[,4],ylim=c(min(-3,min(m.residuo[,4])),max(3,max(m.residuo[,4]))),xlab="valor ajustado",ylab="res�duo studentizado")
abline(-2,0,lty=2)
abline(2,0,lty=2)
abline(0,0,lty=2)
#
hist(m.residuo[,4],probability=TRUE,xlab="res�duo studentizado",main="",ylab="densidade")
#
qqPlot((m.residuo[,4]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)

#
# Zoom nos envelopes
# CS
par(mfrow =c(1,1))
#
qqPlot((m.residuo[,1]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
# LS
par(mfrow =c(1,1))
#
qqPlot((m.residuo[,2]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
# CP
par(mfrow =c(1,1))
#
qqPlot((m.residuo[,3]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
# LP
par(mfrow =c(1,1))
#
qqPlot((m.residuo[,4]),dist="norm",mean=0,sd=1,col.lines=1,grid="FALSE",xlab="quantil da N(0,1)",ylab=paste("quantil da distribui��o do res�duo studentizado"),cex=1.2)
#
 
##############################################
# Obtendo estimativa dos par�metros do modelo
fit.model<-lm(as.matrix(irisd) ~ especie)
summary(fit.model)
