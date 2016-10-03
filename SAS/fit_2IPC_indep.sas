/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : fit_2IPC_indep.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program fits a 2-dimensional IPC model with fixed class points
               (IPC2D_indep) on simulated data.
  Remarks    : N/A
********************************************************************************
  Input : ds_analyze [M]: Simulated data for analysis.
					root_path [M]: The directory where outputs are stored.
					loop [M]: The current replication number.
  Output: The parameter estimates of fitted IPC model.
********************************************************************************/


%macro fit_ipc2D_indep(ds_analyze =,
                       root_path  =,
                       loop       =);

    /* Fit 2-dimensional IPC model on simulated data. */
    /* FIXED CLASS POINTS */
    PROC NLMIXED data=work.&ds_analyze;
		PARMS 
		b01 - b02 = 0
		b11 - b12 = 0
		b21 - b22 = 0
		b31 - b32 = 0
		b41 - b42 = 0
		b51 - b52 = 0
        ;

		/* Define class points. */
		z11 = 0; z12 = 0; 
		z21 = 1; z22 = 0;   
		z31 = 0; z32 = 1; 
		z41 = 1; z42 = 1; 

		/* Define Ideal Points. */
		/* Dimension 1 */
		eta1 = b01 + b11*X1 + b21*X2 + b31*X3 + b41*X4 + b51*X5;
		/* Dimension 2 */
		eta2 = b02 + b12*X1 + b22*X2 + b32*X3 + b42*X4 + b52*X5;
		
		/* Define squared distances. */
		dist1 = (eta1-z11)*(eta1-z11) + (eta2-z12)*(eta2-z12);
		dist2 = (eta1-z21)*(eta1-z21) + (eta2-z22)*(eta2-z22);
		dist3 = (eta1-z31)*(eta1-z31) + (eta2-z32)*(eta2-z32);
		dist4 = (eta1-z41)*(eta1-z41) + (eta2-z42)*(eta2-z42);

		/* Specify probabilities. */
		denom = exp(-0.5*dist1) + exp(-0.5*dist2) + exp(-0.5*dist3) + exp(-0.5*dist4);
			 if (resp = 1) then  p = exp(-0.5*dist1)/denom;
		else if (resp = 2) then  p = exp(-0.5*dist2)/denom;
		else if (resp = 3) then  p = exp(-0.5*dist3)/denom;
		else if (resp = 4) then  p = exp(-0.5*dist4)/denom;
		
		ll = log(p);
		model resp ~ general (ll);
		ods output ParameterEstimates=IPC2D_indep;
	run;

    /* Export marginal parameter estimates. */
    data work.IPC2D_indep;
      length loop 8;
      set work.IPC2D_indep;

      loop = &loop;
    run;

    proc export data=work.IPC2D_indep
      outfile="&root_path./SAS/Outputs/IPC2D_indep/IPC2D_indep_&loop..csv"
      dbms=csv
      replace;
    run;

    /* Delete temporary dataset(s). */
    proc datasets library=work nolist;
      delete IPC2D_indep;
    quit;
    run;

%mend  fit_ipc2D_indep;  
