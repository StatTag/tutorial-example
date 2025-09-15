/*
This script performs basic statistical analysis on the cleaned data.
It reads the CSV file from the data acquisition step, calculates
summary statistics, and exports the results for use in other parts of the pipeline.
*/

* Define the path for the input and output files;
%let cleaned_data_path = 'cleaned_enrollment_data.csv';
%let analysis_output_path = 'analysis_results.csv';

* Import the cleaned data;
proc import datafile="&cleaned_data_path"
    out=work.enrollment
    dbms=csv
    replace;
run;

* Perform frequency analysis for Sex and Treatment;
proc freq data=work.enrollment;
    tables Sex*Treatment / out=work.sex_counts;
run;

* Generate descriptive statistics for Age by Treatment group;
proc means data=work.enrollment noprint;
    class Treatment;
    var Age;
    output out=work.age_summary (drop=_type_ _freq_) mean=Age_Mean stddev=Age_StdDev;
run;

* Combine the results into a single table for export;
data analysis_results;
    set work.sex_counts;
    * Append age summary data;
    if _n_ = 1 then set work.age_summary;
run;

* Export the analysis results to a CSV file;
proc export data=analysis_results
    outfile="&analysis_output_path"
    dbms=csv
    replace;
run;

%put "Statistical analysis completed. Results saved to &analysis_output_path.";