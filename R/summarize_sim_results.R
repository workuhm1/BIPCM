
## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : summarize_sim_results.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com)
##  Date        : 2010 - 2015
##  Description : The script summarizes all results obtained from simulation study.
##  Remarks     : N/A
## ********************************************************************************


## Import source codes
source("bias.R")
source("rmse.R")
source("coverage.R")
source("eval_sim_results.R")


## Import true values
true_val_marg <- read.csv(file = "./sim_data/True_Values_marg.csv")
true_val_asso <- read.csv(file = "./sim_data/True_Values_asso.csv")
true_val_3D   <- read.csv(file = "./sim_data/True_Values_3D.csv")

## Import combined data
IPC2D_indep     <- read.csv(file = "../SAS/Outputs/IPC2D_indep/combined_IPC2D_indep.csv")
IPC2D_free_marg <- read.csv(file = "../SAS/Outputs/IPC2D_free_marg/combined_IPC2D_free_marg.csv")
IPC2D_free_asso <- read.csv(file = "../SAS/Outputs/IPC2D_free_asso/combined_IPC2D_free_asso.csv")
BIPC_marg       <- read.csv(file = "../SAS/Outputs/BIPC_marg/combined_BIPC_marg.csv")
BIPC_asso       <- read.csv(file = "../SAS/Outputs/BIPC_asso/combined_BIPC_asso.csv")
IPC3D           <- read.csv(file = "../SAS/Outputs/IPC3D/combined_IPC3D.csv")


## ------------ ##
## IPC2D_indep  ##
## ------------ ##
out_IPC2D_indep <- eval_sim(true_vect = true_val_marg, type_parm = 1, dsin = IPC2D_indep)
write.table(x = out_IPC2D_indep, file = "../SAS/Outputs/IPC2D_indep/out_IPC2D_indep.csv",
            sep = ",", row.names = FALSE, col.names = TRUE)

## ----------------- ##
## IPC2D_free_marg   ##
## ----------------- ##
out_IPC2D_free_marg <- eval_sim(true_vect = true_val_marg, type_parm = 1, dsin = IPC2D_free_marg)
write.table(x = out_IPC2D_free_marg, file = "../SAS/Outputs/IPC2D_free_marg/out_IPC2D_free_marg.csv",
            sep = ",", row.names = FALSE, col.names = TRUE)

## ----------------- ##
## IPC2D_free_asso   ##
## ----------------- ##
out_IPC2D_free_asso <- eval_sim(true_vect = true_val_asso, type_parm = 2, dsin = IPC2D_free_asso)
write.table(x = out_IPC2D_free_asso, file = "../SAS/Outputs/IPC2D_free_asso/out_IPC2D_free_asso.csv",
            sep = ",", row.names = FALSE, col.names = TRUE)

## ----------- ##
## BIPC_marg   ##
## ----------- ##
out_BIPC_marg <- eval_sim(true_vect = true_val_marg, type_parm = 1, dsin = BIPC_marg)
write.table(x = out_BIPC_marg, file = "../SAS/Outputs/BIPC_marg/out_BIPC_marg.csv",
            sep = ",", row.names = FALSE, col.names = TRUE)

## ----------- ##
## BIPC_asso   ##
## ----------- ##
out_BIPC_asso <- eval_sim(true_vect = true_val_asso, type_parm = 2, dsin = BIPC_asso)
write.table(x = out_BIPC_asso, file = "../SAS/Outputs/BIPC_asso/out_BIPC_asso.csv",
            sep = ",", row.names = FALSE, col.names = TRUE)

## ----------- ##
## IPC3D       ##
## ----------- ##
out_IPC3D <- eval_sim(true_vect = true_val_3D, type_parm = 3, dsin = IPC3D)
write.table(x = out_IPC3D, file = "../SAS/Outputs/IPC3D/out_IPC3D.csv",
            sep = ",", row.names = FALSE, col.names = TRUE)


