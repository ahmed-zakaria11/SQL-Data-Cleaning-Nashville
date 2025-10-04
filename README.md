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
