
## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : generate_palmgren.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com)
##  Date        : 2010 - 2015
##  Description : The script generates bivariate binary responses (y1_i, y2_i) 
##                following a Bivariate Logistic Regression (BLR) model (sometimes  
##                referred to as Palmgren Model). The association model, i.e., 
##                log(tau_i)=eta_i, is a constrained model whose parameters 
##                are defined as function of the marginal parameters following
##                a 2-dimensional IPC model.
##  Remarks     : N/A
## ********************************************************************************


## Load VGAM package for generating bivariate binary responses following BLR 
library(VGAM)

## Load source code
source("generate.R")

## Environmental settings
setwd("C:/Users/HW1/Desktop/PhD_project_backup/Subproject_1/CodesInSubmittedPaper_R3_20160924/simulation-2_Modified_20160924/R")

## Set number of replications
Nrep = 1000

## Generate and save seed numbers
seed_list = round(runif(Nrep)*1000)
write.table(x = seed_list, file = "sim_data/seed_values.txt", row.names = FALSE, col.names = "seed")

## Set file name
file_name = "sim_data"

## Start simulation
for(rep in 1:Nrep){
  
  ## Get the seed number 
  seed = seed_list[rep]
  
  ## Generate Bivariate Binary responses following BLR model
  sim_data_i <- gen_palm(seedIN=seed)
  
  ## Export simulated dataset <i>
  write.table(x = cbind(rep, seed, sim_data_i), 
              file = paste("./sim_data/", file_name,"_",Nrep,"_",rep,".csv",sep=""),
              sep=",", row.names = FALSE)
}


