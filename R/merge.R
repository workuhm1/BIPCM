
## ********************************************************************************
## Copyright: FSW, Leiden University, The Netherlands
## ********************************************************************************
##  Program     : merge.R
##  Author      : Hailemichael M. Worku (hmetiku@yahoo.com) 
##  Date        : 2010 - 2015
##  Description : The script merges all simulation results
##  Remarks     : N/A
## ********************************************************************************
##  Input : Nrep [M]      - number of replication
##          type [M]      - type of analysis (e.g., IPC2D_indep, etc)
##          file_name [O] - file name for output file
##  Output: A comma-separated txt dataset.
##  ********************************************************************************


Mres = function(Nrep, type, file_name=NULL){
  
  ## Check if the user specifies file name for output dataset
  if(is.null(file_name)){
    file_name <- Nrep
  }
  
  ## Merge
  for(loop in 1:Nrep){
    
    res_path <- paste("../SAS/Outputs/", type, "/", sep = "")
    temp_data <- read.csv(file = paste(res_path, type, "_", loop, ".csv", sep = ""))
    
    write.table(cbind(temp_data), 
                paste(res_path, file_name,".csv",sep=""),
                append=TRUE, sep=",", row.names = FALSE,
                col.names = if(loop==1){
                  TRUE
                } else {FALSE})
  }
  
}