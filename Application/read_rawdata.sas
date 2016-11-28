
%macro read_rawdata(dsin      =,
                    dsin_path =,
                    drop_vars =);

  filename nesda "&dsin_path.\&dsin..csv";

  proc import datafile =nesda
                   out =work.nesda
                  dbms =csv replace;             
              getnames =yes;
  run;

  /* Save NESDA in a permanent location */
  libname outdt "&dsin_path";

  data outdt.nesda;
    set work.nesda;
  run;

  /* Keep only DYST and GAD response variables */
  data nesda2;
    set nesda (drop = &drop_vars.);
  run;

  data work.nesda2; 
    set work.nesda2;

    resp=1;
    if dyst=1 and gad=0 then resp=2;
    if dyst=0 and gad=1 then resp=3;
    if dyst=1 and gad=1 then resp=4;
  run;

  /* Save NESDA bivariate in a permanent location */
  data outdt.nesda_biv;
    set work.nesda2;
  run;

%mend  read_rawdata;
