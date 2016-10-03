/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : fit_BIPC.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program fits a BIPC model on simulated data.
  Remarks    : N/A
********************************************************************************
  Input : ds_analyze [M]: Simulated data for analysis.
					root_path [M]: The directory where outputs are stored.
					loop [M]: The current replication number.
  Output: The parameter estimates of fitted BIPC model.
********************************************************************************/

%macro fit_bipc(ds_analyze =,
                root_path  =,
                loop       =);



%mend  fit_bipc;
