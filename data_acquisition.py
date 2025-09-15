import pandas as pd
import os

def acquire_data(file_path):
    """
    Acquires data from a CSV file.
    
    Parameters:
    - file_path (str): The path to the CSV file.
    
    Returns:
    - pandas.DataFrame: The acquired data.
    """
    try:
        df = pd.read_csv(file_path)
        print(f"Successfully acquired data from {file_path}")
        return df
    except FileNotFoundError:
        print(f"Error: The file at {file_path} was not found.")
        return None

def clean_data(df):
    """
    Performs basic data cleaning and curation.
    
    Parameters:
    - df (pandas.DataFrame): The raw data.
    
    Returns:
    - pandas.DataFrame: The cleaned data.
    """
    if df is None:
        return None
    
    # Fill missing values for 'Treatment' and 'Randomize' to simplify analysis.
    # This is a basic imputation; in a real study, this would be more complex.
    df['Treatment'] = df['Treatment'].fillna(-1) 
    df['Randomize'] = df['Randomize'].fillna(-1)
    
    # Ensure ID is a string for consistent handling
    df['ID'] = df['ID'].astype(str)
    
    print("Data cleaning completed.")
    return df

if __name__ == "__main__":
    # Create a dummy CSV for this demonstration
    data = {
        'ID': [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010],
        'Sex': ['Male', 'Female', 'Male', 'Male', 'Female', 'Male', 'Female', 'Female', 'Female', 'Male'],
        'Age': [55, 45, 64, 56, 43, 63, 59, 62, 51, 49],
        'Screen': [1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
        'Randomize': [1, 0, 1, 1, 1, 0, 1, 1, 1, float('nan')],
        'Treatment': [0, float('nan'), 0, 1, 1, float('nan'), 1, 0, 0, float('nan')]
    }
    raw_df = pd.DataFrame(data)
    raw_df.to_csv('raw_enrollment_data.csv', index=False)
    
    # Execute the pipeline steps
    input_file = 'raw_enrollment_data.csv'
    output_file = 'cleaned_enrollment_data.csv'
    
    # Acquire and clean the data
    raw_df = acquire_data(input_file)
    if raw_df is not None:
        cleaned_df = clean_data(raw_df)
        
        # Save the cleaned data for the next step in the pipeline
        cleaned_df.to_csv(output_file, index=False)
        print(f"\nCleaned data saved to {output_file}")