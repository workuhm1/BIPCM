/*******************************************************************************
  Copyright: FSW, Leiden University, The Netherlands
********************************************************************************
  Program    : read_rawdata.sas
  Author     : Hailemichael M. Worku (hmetiku@yahoo.com)
  Date       : 2010 - 2015
  Description: The program imports simulated data and converts to SAS dataset
	             for analysis. The multinomial response (RESP_i) is also obtained  
							 using bivariate binary responses (y1_i, y2_i).
  Remarks    : N/A
********************************************************************************
  Input : root_path [M]: The directory where simulated data is stored.
					NRep [M]: Number of replication used in the simulation.
					data_i [M]: The current imported simulated data.
					ds_out [M]: The SAS dataset with imported values.
  Output: A SAS dataset with multinomial response variable used for analysis.
********************************************************************************/


%macro read_rawdata(root_path =,
                    NRep      =,
                    data_i    =,
                    ds_out    =);

    filename rdata "&root_path.\R\sim_data\sim_data_&NRep._&data_i..csv";

    proc import datafile =rdata
                     out =work.&ds_out
                    dbms =csv replace;             
                getnames =yes;
    run;

    /* Create multinomial response variable from Bivariate Binary responses. */
    data work.&ds_out; 
    	set work.&ds_out;

    	resp=1;
    	if y1=1 and y2=0 then resp=2;
    	if y1=0 and y2=1 then resp=3;
    	if y1=1 and y2=1 then resp=4;
    run;

%mend  read_rawdata;
