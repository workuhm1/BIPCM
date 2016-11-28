/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : fit_NESDA.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program fits (B)IPC models on NESDA data.
  Remarks    : N/A
********************************************************************************/

/* ----------------------- */
/* Environmental settings. */
/* ----------------------- */
%global root_path olog;

%let root_path  = G:\PhD_project\subproject_1\Codes;
%let rawdata    = &root_path.\NESDA;
%let olog       = &root_path.\SAS;
%let prog_name  = fit_NESDA;

/* --------------------------------------------- */
/* Import main macros for fitting (B)IPC models. */
/* --------------------------------------------- */
%include "&root_path.\SAS\read_rawdata.sas";
%include "&root_path.\SAS\fit_2IPC_indep.sas";
%include "&root_path.\SAS\fit_2IPC_free.sas";
%include "&root_path.\SAS\fit_3IPC.sas";
%include "&root_path.\SAS\fit_BIPC.sas";

/* Save log and list files */
%let progname = fit_nesda;

filename logout "&olog.\&progname..log";
filename lstout "&olog.\&progname..lst";

/* Save log and list files */
proc printto log=logout print=lstout new;
run;


/* ---------------- */
/* Read NESDA data  */
/* ---------------- */
%read_rawdata(dsin=NESDA, dsin_path=&rawdata, drop_vars =%str(mdd pd sp));


/* --------------------------------------------------- */
/* Fit 2-dimensional IPC model with fixed class points */
/* --------------------------------------------------- */
* All predectors ;
%fit_2IPC_indep(dsin=work.nesda2, is_parms_all=Y, parms_lst=, is_var_all=Y, eta_lst=, dsout=out_2IPC_indep_all,
                debugme=N);

* Final model ;
%let parms_in = %NRSTR(b01 - b02 = 0
                       b11 - b12 = 0
                       b21 - b22 = 0
                       b31 - b32 = 0
                       b41 - b42 = 0
                       b51 - b52 = 0);

%let eta_in = %NRSTR(eta1 = b01 + b11*gender + b21*age + b31*edu + b41*neurot + b51*extrave ;
                     eta2 = b02 + b12*gender + b22*age + b32*edu + b42*neurot + b52*extrave ;
                    );

%fit_2IPC_indep(dsin=work.nesda2, is_parms_all=N, parms_lst=&parms_in., is_var_all=N, eta_lst=&eta_in., dsout=out_2IPC_indep_final,
                debugme=N);


/* --------------------------------------------------- */
/* Fit 2-dimensional IPC model with free class points  */
/* --------------------------------------------------- */
* All predectors ;
%fit_ipc2D_free(dsin=work.nesda2, is_parms_all=Y, parms_lst=, is_var_all=Y, eta_lst=, dsout=out_2IPC_free_all,
                debugme=N);

* Final model ;
%let parms_in = %NRSTR(b01 - b02 = 0
                       b11 - b12 = 0
                       b21 - b22 = 0
                       b31 - b32 = 0
                       b41 - b42 = 0
                       b51 - b52 = 0
                       phi1 = 0.01
                       phi2 = 0.01);

%let eta_in = %NRSTR(eta1 = b01 + b11*gender + b21*age + b31*edu + b41*neurot + b51*extrave ;
                     eta2 = b02 + b12*gender + b22*age + b32*edu + b42*neurot + b52*extrave ;
                    );

%fit_ipc2D_free(dsin=work.nesda2, is_parms_all=N, parms_lst=&parms_in., is_var_all=N, eta_lst=&eta_in., dsout=out_2IPC_free_final,
                debugme=N);


/* ---------------------------------------------------- */
/* Fit 3-dimensional IPC model with fixed class points  */
/* ---------------------------------------------------- */
* All predectors ;
%fit_ipc3D(dsin=work.nesda2, is_parms_all=Y, parms_lst=, is_var_all=Y, eta_lst=, dsout=out_3IPC_all,
           debugme=N);

* Final model ;
%let parms_in = %NRSTR(b01 - b03 = 0
                       b11 - b13 = 0
                       b21 - b23 = 0
                       b31 - b33 = 0
                       b41 - b43 = 0
                       b51 - b53 = 0);

%let eta_in = %NRSTR(eta1 = b01 + b11*gender + b21*age + b31*edu + b41*neurot + b51*extrave ;
                     eta2 = b02 + b12*gender + b22*age + b32*edu + b42*neurot + b52*extrave ;
                     eta3 = b03 + b13*gender + b23*age + b33*edu + b43*neurot + b53*extrave ;
                     );

%fit_ipc3D(dsin=work.nesda2, is_parms_all=N, parms_lst=&parms_in., is_var_all=N, eta_lst=&eta_in., dsout=out_3IPC_final,
           debugme=N);


/* --------------- */
/* Fit BIPC model  */
/* --------------- */
* All predectors ;
%fit_bipc(dsin=work.nesda2, is_parms_all=Y, parms_lst=, is_var_all=Y, eta_lst=, dsout=out_BIPC_all,
          debugme=N);

* Final model ;
%let parms_in = %NRSTR(b01 - b02 = 0
                       b11 - b12 = 0
                       b21 - b22 = 0
                       b31 - b32 = 0
                       b41 - b42 = 0
                       b51 - b52 = 0
                       phi1 = 0.01
                       phi2 = 0.01);

%let eta_in = %NRSTR(eta1 = b01 + b11*gender + b21*age + b31*edu + b41*neurot + b51*extrave ;
                     eta2 = b02 + b12*gender + b22*age + b32*edu + b42*neurot + b52*extrave ;
                    );

%fit_bipc(dsin=work.nesda2, is_parms_all=N, parms_lst=&parms_in., is_var_all=N, eta_lst=&eta_in., dsout=out_BIPC_final,
          debugme=N);


proc printto log=log print=print;
run;

filename logout;
filename lstout;