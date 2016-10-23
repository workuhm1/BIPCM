## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : merge_sim_results.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com) 
##  Date        : 2010 - 2015
##  Description : The script merges all simulation results
##  Remarks     : N/A
## ********************************************************************************


## Import source code
source("merge.R")

## number of simulation
num_rep <- 2

## Merge simulation results
Mres(Nrep = num_rep, type="IPC2D_indep",     file_name = "combined_IPC2D_indep")
Mres(Nrep = num_rep, type="IPC2D_free_marg", file_name = "combined_IPC2D_free_marg")
Mres(Nrep = num_rep, type="IPC2D_free_asso", file_name = "combined_IPC2D_free_asso")
Mres(Nrep = num_rep, type="BIPC_marg",       file_name = "combined_BIPC_marg")
Mres(Nrep = num_rep, type="BIPC_asso",       file_name = "combined_BIPC_asso")
Mres(Nrep = num_rep, type="IPC3D",           file_name = "combined_IPC3D")
