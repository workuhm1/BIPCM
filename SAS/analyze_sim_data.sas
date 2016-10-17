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

*options mprint mlogic symbolgen;

/* ----------------------- */
/* Environmental settings. */
/* ----------------------- */
%let root_path  = C:\Users\HW1\Desktop\PhD_project_backup\Subproject_1\CodesInSubmittedPaper_R3_20160924\simulation-2_Modified_20160924;
%let olog       = &root_path.\SAS;
%let prog_name  = analyze_sim_data;

/* --------------------------------------------- */
/* Import main macros for fitting (B)IPC models. */
/* --------------------------------------------- */
filename MACRO "&root_path.\SAS";
%include MACRO(read_rawdata.sas);
%include MACRO(fit_2IPC_indep.sas);
%include MACRO(fit_2IPC_free.sas);
%include MACRO(fit_3IPC.sas);
%include MACRO(fit_BIPC.sas);

/* --------------------------------------------- */
/* Macro for fitting different dimensional IPC   */
/* models and IPC model on simulated data.       */
/* --------------------------------------------- */
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

				%if %upcase(&type) = IPC2D_INDEP %then
				%do;
				
					/* Fit 2-dimensional IPC model with fixed class points. */
          %fit_ipc2D_indep(ds_analyze =ds_sim_&i,
                           root_path  =&&root_path,
                           loop       =&i);
													 
				%end;
				%else %if %upcase(&type) = IPC2D_FREE %then
				%do;
				
					/* Fit 2-dimensional IPC model with fixed class points. */
          %fit_ipc2D_free(ds_analyze =ds_sim_&i,
                          root_path  =&&root_path,
                          loop       =&i);
													
				%end;
				%else %if %upcase(&type) = IPC3D %then
				%do;
				
					/* Fit 3-dimensional IPC model. */
          %fit_ipc3D(ds_analyze =ds_sim_&i,
                     root_path  =&&root_path,
                     loop       =&i);
										 
				%end;
				%else %if %upcase(&type) = BIPC %then
				%do;
				
					/* Fit BIPC model. */
          %fit_bipc(ds_analyze =ds_sim_&i,
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


/* ----------------------------------------------------------------- */
/* Fitting different dimensional IPC models and BIPC model on        */
/* simulated data.                                                   */
/* ----------------------------------------------------------------- */

/* Fit 2-dimensional IPC model with fixed class points, IPC2D_INDEP. */
filename logout1 "&olog.\&prog_name._IPC2D_Indep.log";

proc printto log=logout1;
run;

%analyze_sim_data(num_sim =1000, type=ipc2d_indep, analyze_until =2);

proc printto log=log;
run;

filename logout1;


/* Fit 2-dimensional IPC model with free class points, IPC2D_FREE. */
filename logout2 "&olog.\&prog_name._IPC2D_Free.log";

proc printto log=logout2;
run;

%analyze_sim_data(num_sim =1000, type=ipc2d_free, analyze_until =2);

proc printto log=log;
run;

filename logout2;


/* Fit 3-dimensional IPC model, IPC3D. */
filename logout3 "&olog.\&prog_name._IPC3D.log";

proc printto log=logout3;
run;

%analyze_sim_data(num_sim =1000, type=ipc3d, analyze_until =2);

proc printto log=log;
run;

filename logout3;


/* Fit Bivariate IPC model, BIPC. */
filename logout4 "&olog.\&prog_name._BIPC.log";

proc printto log=logout4;
run;

%analyze_sim_data(num_sim =1000, type=bipc, analyze_until =2);

proc printto log=log;
run;

filename logout4;
