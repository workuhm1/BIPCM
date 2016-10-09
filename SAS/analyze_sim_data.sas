/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : analyze_sim_data.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program fits (B)IPC models on simulated bivariate binary 
               data.
  Remarks    : N/A
********************************************************************************
  Input : num_sim [M]: Number of replications used to simulate the data.
					type [M]: Type of Analysis (e.g., IPC2D_indep, etc).
					analyze_until [M]: The number of simulated data to analyze.
  Output: The parameter estimates of fitted (B)IPC model.
********************************************************************************/


/* Environmental settings. */
%let root_path  = ..main_path;
%let olog       = &root_path.\SAS;
%let prog_name  = analyze_sim_data;

/* Save log file to permanent location. */
filename logout "&olog.\&prog_name..log";

proc printto log=logout;
run;

/* Import main macros for fitting (B)IPC models. */
filename MACRO "&root_path.\SAS";
%include MACRO(read_rawdata.sas);
%include MACRO(fit_2IPC_indep.sas);
%include MACRO(fit_2IPC_free.sas);

%macro analyze_sim_data(num_sim       =, 
												type          =,
                        analyze_until =);

    %do i=1 %to &analyze_until;

        /* Simulation data for loop &i. */
        %read_rawdata(root_path=&root_path, NRep=&num_sim, data_i=&i, ds_out =ds_sim_&i);
				
        %put |*----------------------------------------------*|;
        %put |* Dataset: ds_sim_&i                           *|;
        %put |* Type of Analysis: &type                      *|;
        %put |*----------------------------------------------*|;

				%if %upcase(&type) = IPCTWODINDEP %then
				%do;
					/* 2-dimensional IPC model with fixed class points. */
          %fit_ipc2D_indep(ds_analyze =ds_sim_&i,
                           root_path  =&&root_path,
                           loop       =&i);
				%end;
				%else %if %upcase(&type) = IPCTWODFREE %then
				%do;
					/* 2-dimensional IPC model with fixed class points. */
          %fit_ipc2D_free(ds_analyze =ds_sim_&i,
                          root_path  =&&root_path,
                          loop       =&i);
				%end;

        /* Delete temporary dataset. */
        proc datasets library=work nolist;
          delete ds_sim_&i;
        quit;
        run;

    %end;

%mend  analyze_sim_data;

/* Fit 2-dimensional IPC model with fixed class points. */
%analyze_sim_data(num_sim =1000, type=ipctwodindep, analyze_until =1000);

proc printto log=log;
run;

filename logout;
