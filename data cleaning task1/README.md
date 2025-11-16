# 🧹 Task 1: Data Cleaning and Preprocessing — Medical Appointment No Shows

### 🎯 Objective
The goal of this task is to **clean and prepare the raw dataset** by removing inconsistencies, handling missing values, standardizing column names, and correcting data types for further analysis.

---

## 🧰 Tools and Libraries Used
- **Python 3**
- **Pandas**
- **NumPy**
- **Excel (for verification)**

---

## 📁 Dataset Information
**Dataset Name:** Medical Appointment No Shows (from Kaggle)

**Input File:** `Book1.xlsx`  
**Output File:** `cleaned_medical_appointments.xlsx`

---

## ⚙️ Steps Performed in the Code

1. **Imported necessary libraries**
   ```python
   import pandas as pd
   import numpy as np
2. Loaded the dataset

df = pd.read_excel("Book1.xlsx")


3. Explored the dataset

Displayed first few rows (head())

Checked data shape, info, summary statistics

Identified missing values and duplicates

4. Generated a cleaning summary

Total rows

Missing values

Duplicates

Column names

5. Standardized column names

Removed extra spaces and special characters

Converted to lowercase

Replaced spaces and dashes with underscores

df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(' ', '_')
    .str.replace('-', '_')
    .str.replace(r'[^\w_]', '', regex=True)
)


6. Fixed data types

Converted binary columns like scholarship, diabetes, alcoholism, etc. to integers

binary_cols = ['age','scholarship', 'hipertension', 'diabetes', 'alcoholism', 'handcap', 'sms_received']
for col in binary_cols:
    if col in df.columns:
        df[col] = df[col].astype(int)


7. Saved the cleaned dataset

df.to_excel("cleaned_medical_appointments.xlsx", index=False)

8. fixed the date columns as date type in excel.
