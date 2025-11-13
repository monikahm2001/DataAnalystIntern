import pandas as pd
import numpy as np

df = pd.read_excel("C:/Users/MONIKA\DataAnalyst/ElevateLabsInternship/data cleaning task1/Book1.xlsx")
# "C:\Users\MONIKA\DataAnalyst\ElevateLabsInternship\data cleaning task1\Book1.xlsx"
print(df.head())
print(df.shape)
print(df.info())
print(df.describe()
)
print(df.isnull().sum())
print(df.duplicated().sum())
summary = {
    "Total Rows After Cleaning": len(df),
    "Missing Values (Post-Cleaning)": df.isnull().sum().sum(),
    "Duplicates Remaining": df.duplicated().sum(),
    "Column Names": list(df.columns)
}
print("\n📊 Summary of Cleaning:\n", summary)

df.columns = (
    df.columns
    .str.strip()                 # remove leading/trailing spaces
    .str.lower()                 # convert to lowercase
    .str.replace(' ', '_')       # replace spaces with underscores
    .str.replace('-', '_')       # replace dashes with underscores
    .str.replace(r'[^\w_]', '', regex=True)  # remove special characters
)

print(df.columns)

binary_cols = ['age','scholarship', 'hipertension', 'diabetes', 'alcoholism', 'handcap', 'sms_received']
for col in binary_cols:
    if col in df.columns:
        df[col] = df[col].astype(int)


df.to_excel("cleaned_medical_appointments.xlsx", index=False)
