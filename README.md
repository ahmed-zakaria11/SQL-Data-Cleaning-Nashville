# 🏡 SQL Data Cleaning – Nashville Housing Dataset

This project focuses on **data cleaning using SQL** on the Nashville Housing dataset.  
The goal was to transform raw housing data into a cleaner, more structured format ready for analysis.  

---

## 📊 Dataset
- **Name:** Nashville Housing Dataset  
- **Source:** [Provided as part of SQL practice project]  
- **Rows before cleaning:** ~56,000  
- **Key Issues:** Inconsistent date formats, missing property addresses, concatenated fields, duplicate records, unused columns.  

---

## 🔧 Cleaning Steps
The following cleaning operations were applied in SQL:

1. **Standardized Date Format**  
   - Converted `SaleDate` into proper `Date` format.  

2. **Populated Missing Property Addresses**  
   - Filled null addresses by joining on matching `ParcelID`.  

3. **Split Address Fields**  
   - Broke down `PropertyAddress` into `PropertySplitAddress` and `PropertySplitCity`.  
   - Broke down `OwnerAddress` into `OwnerSplitAddress`, `OwnerSplitCity`, and `OwnerSplitState`.  

4. **Normalized Values**  
   - Converted `SoldAsVacant` field from `1/0` to `Yes/No`.  

5. **Removed Duplicates**  
   - Used `ROW_NUMBER()` with `PARTITION BY` to identify and delete duplicate records.  

6. **Dropped Unused Columns**  
   - Removed redundant columns (`OwnerAddress`, `PropertyAddress`) after splitting.  

---

## 📂 Repository Structure
📂 Data_after_cleaning
📂 Dataset
📄 Data_Cleaning_Project_Nashville .sql
📄 README.md


---

## 📌 Insights
- Clean dataset is now **free of duplicates** and **standardized**.  
- Address fields are split into structured columns for easier analysis.  
- Boolean fields like "Sold As Vacant" are now human-readable.  
- Dataset ready for visualization or integration into BI tools.  

---

## 🚀 Tools Used
- **SQL Server Management Studio (SSMS)**  
- **T-SQL**  

---

## 📖 Learning Outcome
This project was a **practice exercise** in applying SQL data cleaning techniques:  
- Handling missing values  
- Standardizing formats  
- Using string functions for feature engineering  
- Removing duplicates with CTEs  
- Improving dataset readability and usability  

---

