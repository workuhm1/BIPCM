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

    /* Fit 3-dimensional IPC model on simulated data. */
    PROC NLMIXED data=work.&ds_analyze;
		  PARMS 
		    b01 - b03 = 0
		    b11 - b13 = 0
		    b21 - b23 = 0
		    b31 - b33 = 0
		    b41 - b43 = 0
		    b51 - b53 = 0
		  ;

		  /* Define class points. */
		  z11 = 0; z12 = 0; z13 = 0; 
		  z21 = 1; z22 = 0; z23 = 0;   
		  z31 = 0; z32 = 1; z33 = 0;
		  z41 = 1; z42 = 1; z43 = 1; 

		  /* Define Ideal Points. */
		  /* Dimension 1 */
		  eta1 = b01 + b11*X1 + b21*X2 + b31*X3 + b41*X4 + b51*X5;
		  /* Dimension 2 */
		  eta2 = b02 + b12*X1 + b22*X2 + b32*X3 + b42*X4 + b52*X5;
		  /* Dimension 3 */
		  eta3 = b03 + b13*X1 + b23*X2 + b33*X3 + b43*X4 + b53*X5;
		
		  /* Define squared distances. */
		  dist1 = (eta1-z11)*(eta1-z11) + (eta2-z12)*(eta2-z12) + (eta3-z13)*(eta3-z13);
		  dist2 = (eta1-z21)*(eta1-z21) + (eta2-z22)*(eta2-z22) + (eta3-z23)*(eta3-z23);
		  dist3 = (eta1-z31)*(eta1-z31) + (eta2-z32)*(eta2-z32) + (eta3-z33)*(eta3-z33);
		  dist4 = (eta1-z41)*(eta1-z41) + (eta2-z42)*(eta2-z42) + (eta3-z43)*(eta3-z43);

		  /* Specify probabilities. */
		  denom = exp(-0.5*dist1) + exp(-0.5*dist2) + exp(-0.5*dist3) + exp(-0.5*dist4);
			if      (resp = 1) then  p = exp(-0.5*dist1)/denom;
		  else if (resp = 2) then  p = exp(-0.5*dist2)/denom;
		  else if (resp = 3) then  p = exp(-0.5*dist3)/denom;
		  else if (resp = 4) then  p = exp(-0.5*dist4)/denom;
		
		  ll = log(p);
		  model resp ~ general (ll);

      /* Output model estimates (both marginal and association parameters). */
		  ods output ParameterEstimates=IPC3D;
    run;

    /* Export parameter estimates. */
    data work.IPC3D;
      length loop 8;
      set work.IPC3D;

      loop = &loop;
    run;

    proc export data=work.IPC3D
      outfile="&root_path./SAS/Outputs/IPC3D/IPC3D_&loop..csv"
      dbms=csv
      replace;
    run;

    /* Delete temporary dataset(s). */
    proc datasets library=work nolist;
      delete IPC3D
			;
    quit;
    run;

%mend  fit_ipc3D;
