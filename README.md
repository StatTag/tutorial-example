
---

### File: `README.md`
This Markdown file explains the entire data pipeline process, its logic, and the purpose of each script.


# Research Data Pipeline for Drug XYZ Trial

## Project Overview

This project provides a simple, solid representation of a data pipeline for a small-scale research study. It demonstrates how different programming languages and tools can be combined to handle a typical data analysis workflow, from raw data acquisition to final report publication. The pipeline is designed to be a reproducible and modular system, accommodating teams with diverse skill sets in Python, SAS, and R.

The core goal is to inventory and explain a comprehensive data process across multiple files, showcasing how each tool contributes to a specific part of the analysis.

## Pipeline Components and Logic

The data pipeline consists of four main steps, each handled by a dedicated script:

1.  **Data Acquisition and Curation (`data_acquisition.py`)**
    * **Tool:** Python
    * **Libraries:** `pandas`
    * **Functionality:** This script is the entry point for the raw data. It simulates the acquisition of data from a local CSV file. The `pandas` library is leveraged for its powerful data manipulation capabilities to perform initial data cleaning and curation, such as handling missing values.
    * **Output:** A cleaned CSV file (`cleaned_enrollment_data.csv`) that serves as the input for subsequent analysis steps.

2.  **Statistical Analysis (`statistical_analysis.sas`)**
    * **Tool:** SAS
    * **Functionality:** This script takes the cleaned data from the Python script and performs the core statistical calculations. It uses SAS's built-in procedures (`PROC FREQ`, `PROC MEANS`) to generate frequency tables and descriptive statistics (mean and standard deviation) for the participant characteristics, stratified by treatment group.
    * **Output:** A CSV file (`analysis_results.csv`) containing the results of the statistical analysis.

3.  **Data Visualization (`data_visualization.R`)**
    * **Tool:** R
    * **Libraries:** `ggplot2`, `ggplot2`
    * **Functionality:** This script is dedicated to creating high-quality visualizations. It reads the cleaned data and uses the `ggplot2` library to generate an age distribution plot. `ggplot2` is highly regarded for its declarative syntax and ability to create complex, publication-ready graphics.
    * **Output:** A PNG image file (`age_distribution_plot.png`) of the visualization.

4.  **Reporting and Publication (`report.rmd`)**
    * **Tool:** R Markdown
    * **Libraries:** `knitr`, `dplyr`, `kableExtra`
    * **Functionality:** This is the final step where all the pieces come together. R Markdown combines narrative text with code chunks. It imports the analysis results from the SAS script and the visualization from the R script. It uses `knitr` to render the report and `kableExtra` to format the summary tables nicely, producing a comprehensive and reproducible HTML report.
    * **Output:** A final HTML report (`report.html`).

## How to Run the Pipeline

1.  Ensure you have Python, SAS, and R installed with the necessary libraries (`pandas`, `ggplot2`, `knitr`, `dplyr`, `kableExtra`, `tidyverse`).
2.  Run the scripts in the following order:
    * `data_acquisition.py`
    * `statistical_analysis.sas`
    * `data_visualization.R`
    * Render `report.rmd` (e.g., in RStudio, click "Knit to HTML").

This sequential process ensures that the output from each step is correctly used as the input for the next, forming a cohesive data pipeline.