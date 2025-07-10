# Nashville Housing Data Cleaning Project

![SQL Data Cleaning](https://img.shields.io/badge/SQL-Data%20Cleaning-blue) 
![Microsoft SQL Server](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?logo=microsoft-sql-server&logoColor=white)

A guided data cleaning workflow for Nashville housing data, that uses essential SQL techniques to handle real-world data.

## 📋 Project Overview
- **Raw Dataset**: [Nashville Housing (Excel)](/Files/data/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)
- **Cleaned Dataset**: [Nashville Housing (Csv)](/Files/data/Nashville%20Housing%20Cleaned.csv)
- **Script**: [`Data cleaning script`](/Files/scripts/cleaning.sql)
- **Key Operations**:
  - Missing data imputation
  - Date standardization
  - Address parsing
  - Categorical value normalization
  - Deduplication
  - Schema optimization

## 🧹 Data Cleaning Highlights

### 1. Structural Improvements
- Standardized date formats for consistency
- Populated missing property addresses using intelligent matching
- Split composite address fields into discrete components
- Normalized "SoldAsVacant" categorical values

### 2. Data Quality Enhancements
- Identified and removed duplicate records
- Validated address completeness
- Ensured consistent value representations

### 3. Schema Optimization
- Removed redundant columns
- Created properly typed columns
- Improved table structure for analysis

## 🛠️ Implementation
The complete implementation is available in the [`Data cleaning script`](/Files/scripts/cleaning.sql) file, which includes:

1. Date format standardization
2. Missing address imputation using self-joins
3. Address parsing with both:
   - `SUBSTRING()`/`CHARINDEX()` method
   - `PARSENAME()`/`REPLACE()` method
4. Categorical value normalization
5. Duplicate detection and removal
6. Schema optimization through column removal

## 💡 Key Takeaways
This project demonstrates:
- Practical approaches to common data quality issues
- Multiple SQL techniques for string manipulation
- Data validation strategies
- Schema optimization considerations

