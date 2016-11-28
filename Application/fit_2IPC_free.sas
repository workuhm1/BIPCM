
       
%macro fit_ipc2D_free(dsin         =,
                      is_parms_all =,
                      parms_lst    =,
                      is_var_all   =,
                      eta_lst      =,
                      dsout        =,
                      debugme      =);
  
  %if       %upcase(&debugme) = Y %then %do;
    options mprint mlogic symbolgen;
  %end;
  %else %if %upcase(&debugme) = N %then %do;
    options nomprint nomlogic nosymbolgen;
  %end;

  %put ### ------------------------- ;
  %put ### Model: fit_ipc2D_free     ;
  %put ### ------------------------- ; 

  /* Fit 2-dimensional IPC model on NESDA data. */
  /* FREE CLASS POINTS */
  PROC NLMIXED data=&dsin;
    TITLE "Model: 2-Dimensional IPC Model with Free Class Points";
    PARMS 
      %if %upcase(&is_parms_all.) = Y %then %do;
        b01 - b02 = 0
        b11 - b12 = 0
        b21 - b22 = 0
        b31 - b32 = 0
        b41 - b42 = 0
        b51 - b52 = 0
        b61 - b62 = 0
        b71 - b72 = 0
        b81 - b82 = 0
        phi1 = 0.01
        phi2 = 0.01
      %end;
      %else %do;
        &parms_lst.
      %end;
    ;

    /* Define class points. */
    z11 = 0; z12 = 0; 
    z21 = 1; z22 = 0;   
    z31 = 0; z32 = 1; 
    z41 = 1+phi1; z42 = 1+phi2; 

    /* Define Ideal Points. */
    %if %upcase(&is_var_all.) = Y %then %do;
      /* Dimension 1 */
      eta1 = b01 + b11*gender + b21*age + b31*edu + b41*neurot + b51*extrave + b61*openes + b71*agreeab + b81*conscie;

      /* Dimension 2 */
      eta2 = b02 + b12*gender + b22*age + b32*edu + b42*neurot + b52*extrave + b62*openes + b72*agreeab + b82*conscie;
    %end;
    %else %do;
      &eta_lst.
    %end;

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
 
    /* Estimate association parameters. */
    estimate 'b03' phi1*b01 + phi2*b02 - 0.5*(phi1**2) - 0.5*(phi2**2) - phi1 - phi2;
    estimate 'b13' phi1*b11 + phi2*b12;
    estimate 'b23' phi1*b21 + phi2*b22;
    estimate 'b33' phi1*b31 + phi2*b32;
    estimate 'b43' phi1*b41 + phi2*b42;
    estimate 'b53' phi1*b51 + phi2*b52;
    
    %if %upcase(&is_var_all.) = Y %then %do; 
      estimate 'b63' phi1*b61 + phi2*b62;
      estimate 'b73' phi1*b71 + phi2*b72;
      estimate 'b83' phi1*b81 + phi2*b82;
    %end;

    ods output ParameterEstimates=&dsout._marg AdditionalEstimates=&dsout._asso;
  run;

  /* Export marginal parameter estimates. */
  proc export data=&dsout._marg
    outfile="&root_path./SAS/Outputs/&dsout._marg.csv"
    dbms=csv
    replace;
  run;

  /* Export association parameter estimates. */
  proc export data=&dsout._asso
    outfile="&root_path./SAS/Outputs/&dsout._asso.csv"
    dbms=csv
    replace;
  run;

%mend  fit_ipc2D_free;
