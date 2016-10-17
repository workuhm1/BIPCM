/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : fit_BIPC.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program fits a Bivariate IPC (BIPC) model on simulated data.
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

    /* Fit BIPC model on simulated data. */
    PROC NLMIXED data=work.&ds_analyze;
	    PARMS
		    b01 - b02 = 0
		    b11 - b12 = 0
		    b21 - b22 = 0
		    b31 - b32 = 0
		    b41 - b42 = 0
		    b51 - b52 = 0
        phi1 = 0.01
        phi2 = 0.01
			;

	    /* Define class points. */
	    z11 = 0; z12 = 0; 
	    z21 = 1; z22 = 0; 
	    z31 = 0; z32 = 1; 
	    z41 = 1+phi1; z42 = 1+phi2;

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

	    /*	Logistic models for marginal probabilities	*/
	    p1 = exp(eta1 - 0.5)/(1 + exp(eta1 - 0.5));
	    p2 = exp(eta2 - 0.5)/(1 + exp(eta2 - 0.5));

	    /*	Association model	*/
	    tau = exp(-0.5*dist4 - 0.5*dist1 + 0.5*dist2 + 0.5*dist3);
	
	    /*	quadratic formula (Mardia1967)	*/
	    if (tau ^= 1) then
		  do;
			  w = 1 - (1-tau)*(p1 + p2);
			  p11 = (w - ((w**2 - 4*tau*(tau-1)*p1*p2)**0.5)) / (2 * (tau-1));
		  end;
	    else p11 = p1*p2;

	    /* specify probabilities */
 	    if      (resp = 4) then  p = p11;
		  else if (resp = 2) then  p = p1 - p11;
			else if (resp = 3) then  p = p2 - p11;
		  else if (resp = 1) then  p = 1 - p1 - p2 + p11;

	    if (p > 1e-8) then ll = log(p);
		  else               ll = -1e100;
	    model resp ~ general (ll);
			
	    /* Estimate association parameters. */
		  estimate 'b03' phi1*b01 + phi2*b02 - 0.5*(phi1**2) - 0.5*(phi2**2) - phi1 - phi2;
      estimate 'b13' phi1*b11 + phi2*b12;
      estimate 'b23' phi1*b21 + phi2*b22;
      estimate 'b33' phi1*b31 + phi2*b32;
      estimate 'b43' phi1*b41 + phi2*b42;
      estimate 'b53' phi1*b51 + phi2*b52;

      /* Output model estimates (both marginal and association parameters). */
		  ods output ParameterEstimates=BIPC_marg AdditionalEstimates=BIPC_asso;
    run;

    /* Export marginal parameter estimates. */
    data work.BIPC_marg;
      length loop 8;
      set work.BIPC_marg;

      loop = &loop;
    run;

    proc export data=work.BIPC_marg
      outfile="&root_path./SAS/Outputs/BIPC_marg/BIPC_marg_&loop..csv"
      dbms=csv
      replace;
    run;

    /* Export association parameter estimates. */
    data work.BIPC_asso;
      length loop 8;
      set work.BIPC_asso;

      loop = &loop;
    run;

    proc export data=work.BIPC_asso
      outfile="&root_path/SAS/Outputs/BIPC_asso/BIPC_asso_&loop..csv"
      dbms=csv
      replace;
    run;

    /* Delete temporary dataset(s). */
    proc datasets library=work nolist;
      delete BIPC_marg
             BIPC_asso
      ;
    quit;
    run;

%mend  fit_bipc;
