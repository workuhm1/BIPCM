/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : fit_3IPC.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program fits a 3-dimensional IPC model on simulated data.
  Remarks    : N/A
********************************************************************************
  Input : ds_analyze [M]: Simulated data for analysis.
					root_path [M]: The directory where outputs are stored.
					loop [M]: The current replication number.
  Output: The parameter estimates of fitted IPC model.
********************************************************************************/

%macro fit_ipc3D(ds_analyze =,
                 root_path  =,
                 loop       =);



%mend  fit_ipc3D;
