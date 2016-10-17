
## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : summarize_sim_results.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com)
##  Date        : 2010 - 2015
##  Description : The script calculates bias, rmse and coverage of simulation 
##                results obtained from 2-dimensional IPC model with 
##                fixed class points (IPC2D_indep).
##  Remarks     : N/A
## ********************************************************************************

## Import source codes
source("merge_sim_results.R")
source("bias.R")
source("rmse.R")
source("coverage.R")

## Merge all simulation estimates
Mres(Nrep = 2, type="IPC2D_indep",     file_name = "combined_IPC2D_indep")
Mres(Nrep = 2, type="IPC2D_free_marg", file_name = "combined_IPC2D_free_marg")
Mres(Nrep = 2, type="IPC2D_free_asso", file_name = "combined_IPC2D_free_asso")
Mres(Nrep = 2, type="BIPC_marg",       file_name = "combined_BIPC_marg")
Mres(Nrep = 2, type="BIPC_asso",       file_name = "combined_BIPC_assoc")
Mres(Nrep = 2, type="IPC3D",           file_name = "combined_IPC3D")


## Import combined results for analysis
IPC2D_indep <- read.csv(file = "../SAS/Outputs/IPC2D_indep/combined_IPC2D_indep.csv")


## ----------------------------- ##
## b0r: Bias, RMSE and Coverage  ##
## ----------------------------- ##
b01_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b01", ]
b02_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b02", ]

## b01
Bias(dat = b01_IPC2D_indep, beta_true = -1.7)
RMSE(dat = b01_IPC2D_indep, beta_true = -1.7)
coverage(dat = b01_IPC2D_indep, beta_true = -1.7)

## b02
Bias(dat = b02_IPC2D_indep, beta_true = -1.0)
RMSE(dat = b02_IPC2D_indep, beta_true = -1.0)
coverage(dat = b02_IPC2D_indep, beta_true = -1.0)


## ----------------------------- ##
## b1r: Bias, RMSE and Coverage  ##
## ----------------------------- ##
b11_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b11", ]
b12_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b12", ]

## b11
Bias(dat = b11_IPC2D_indep, beta_true = 0.0)
RMSE(dat = b11_IPC2D_indep, beta_true = 0.0)
coverage(dat = b11_IPC2D_indep, beta_true = 0.0)

## b12
Bias(dat = b12_IPC2D_indep, beta_true = -0.25)
RMSE(dat = b12_IPC2D_indep, beta_true = -0.25)
coverage(dat = b12_IPC2D_indep, beta_true = -0.25)


## ----------------------------- ##
## b2r: Bias, RMSE and Coverage  ##
## ----------------------------- ##
b21_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b21", ]
b22_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b22", ]

## b21
Bias(dat = b21_IPC2D_indep, beta_true = 0.2)
RMSE(dat = b21_IPC2D_indep, beta_true = 0.2)
coverage(dat = b21_IPC2D_indep, beta_true = 0.2)

## b22
Bias(dat = b22_IPC2D_indep, beta_true = 0.0)
RMSE(dat = b22_IPC2D_indep, beta_true = 0.0)
coverage(dat = b22_IPC2D_indep, beta_true = 0.0)


## ----------------------------- ##
## b3r: Bias, RMSE and Coverage  ##
## ----------------------------- ##
b31_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b31", ]
b32_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b32", ]

## b31
Bias(dat = b31_IPC2D_indep, beta_true = -0.15)
RMSE(dat = b31_IPC2D_indep, beta_true = -0.15)
coverage(dat = b31_IPC2D_indep, beta_true = -0.15)

## b32
Bias(dat = b32_IPC2D_indep, beta_true = -0.15)
RMSE(dat = b32_IPC2D_indep, beta_true = -0.15)
coverage(dat = b32_IPC2D_indep, beta_true = -0.15)


## ----------------------------- ##
## b4r: Bias, RMSE and Coverage  ##
## ----------------------------- ##
b41_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b41", ]
b42_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b42", ]

## b41
Bias(dat = b41_IPC2D_indep, beta_true = 1.05)
RMSE(dat = b41_IPC2D_indep, beta_true = 1.05)
coverage(dat = b41_IPC2D_indep, beta_true = 1.05)

## b42
Bias(dat = b42_IPC2D_indep, beta_true = 1.15)
RMSE(dat = b42_IPC2D_indep, beta_true = 1.15)
coverage(dat = b42_IPC2D_indep, beta_true = 1.15)


## ----------------------------- ##
## b5r: Bias, RMSE and Coverage  ##
## ----------------------------- ##
b51_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b51", ]
b52_IPC2D_indep <- IPC2D_indep[IPC2D_indep$Parameter=="b52", ]

## b51
Bias(dat = b51_IPC2D_indep, beta_true = -0.45)
RMSE(dat = b51_IPC2D_indep, beta_true = -0.45)
coverage(dat = b51_IPC2D_indep, beta_true = -0.45)

## b52
Bias(dat = b52_IPC2D_indep, beta_true = -0.15)
RMSE(dat = b52_IPC2D_indep, beta_true = -0.15)
coverage(dat = b52_IPC2D_indep, beta_true = -0.15)

