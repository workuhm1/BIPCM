

## Import Biplot function for BIPC model
source("Biplot_BIPC.R")

## Load NESDA data
NESDA <- read.csv("NESDAbiv.csv")
NESDA <- NESDA[,-1]
colnames(NESDA)[c(2,3,4,5,14)] <- c("AGE","EDU","N", "E", "GEN")

## Keep predictors which are significant on both dimention
X1 <- NESDA[,c(3,4,5)]

## Define model parameters, beta (regression weights) and gamma (class points)
beta_lst <- matrix(c(-2.21,-0.15,1.03,-0.45, 
                     -1.51,-0.12,1.14,-0.14), 
                   nrow=4, ncol=2, byrow=F)

gamma_lst <- matrix(c(0,0,1,0,0,1,1-0.21,1-0.46), 
                    nrow=4,ncol=2,byrow=T)

parms_all <- list(X=X1, B=beta_lst, Z=gamma_lst)

## Get Biplot of fitted BIPC model on the NESDA data
png(filename = "Biplot_BIPC.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = 75, 
    type = "cairo")

Biplot_BIPC(object = parms_all)

dev.off() 




