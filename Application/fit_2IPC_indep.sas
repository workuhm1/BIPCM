
       
%macro fit_2IPC_indep(dsin         =,
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
  %put ### Model: fit_2IPC_indep     ;
  %put ### ------------------------- ; 

  /* Fit 2-dimensional IPC model on NESDA data. */
  /* FIXED CLASS POINTS */
  PROC NLMIXED data=&dsin;
    TITLE "Model: 2-Dimensional IPC Model with Fixed Class Points";
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
      %end;
      %else %do;
        &parms_lst.
      %end;
    ;

    /* Define class points. */
    z11 = 0; z12 = 0; 
    z21 = 1; z22 = 0;   
    z31 = 0; z32 = 1; 
    z41 = 1; z42 = 1; 

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
    ods output ParameterEstimates=&dsout;
  run;

  /* Export marginal parameter estimates. */
  proc export data=&dsout
    outfile="&root_path./SAS/Outputs/&dsout..csv"
    dbms=csv
    replace;
  run;

%mend  fit_2IPC_indep;