/*

Cleaning Data in SQL Queries

*/


Select *
From Data_cleaning_project.dbo.Nashville_Housing


--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select SaleDate, CONVERT(Date,SaleDate)
From Data_cleaning_project.dbo.Nashville_Housing


Update Nashville_Housing
SET SaleDate = CONVERT(Date,SaleDate)

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From Data_cleaning_project.dbo.Nashville_Housing
Where PropertyAddress is null
order by ParcelID


--Select rows with NULL value in property address , but has a property address for the same Parcel ID
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From Data_cleaning_project.dbo.Nashville_Housing a
JOIN Data_cleaning_project.dbo.Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


--Populate these rows with propety address aquired
Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From Data_cleaning_project.dbo.Nashville_Housing a
JOIN Data_cleaning_project.dbo.Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

--Property Address
Select PropertyAddress
From Data_cleaning_project.dbo.Nashville_Housing

--Select address before "," and after "," until end of length of address
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
From Data_cleaning_project.dbo.Nashville_Housing

--Add columns for address and city
ALTER TABLE Nashville_Housing
Add PropertySplitAddress Nvarchar(255);

Update Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE Nashville_Housing
Add PropertySplitCity Nvarchar(255);

Update Nashville_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))



Select *
From Data_cleaning_project.dbo.Nashville_Housing



--Owner Address
Select OwnerAddress
From Data_cleaning_project.dbo.Nashville_Housing


--Select before first "," then between first and second "," then to the end of the address
SELECT
SUBSTRING(OwnerAddress, 1, CHARINDEX(',', OwnerAddress) -1 ) as Address
, SUBSTRING(OwnerAddress,CHARINDEX(',', OwnerAddress) + 1, CHARINDEX(',', OwnerAddress, CHARINDEX(',', OwnerAddress) + 1) - CHARINDEX(',', OwnerAddress) - 2) AS Address
, SUBSTRING(OwnerAddress,CHARINDEX(',', OwnerAddress, CHARINDEX(',', OwnerAddress) + 1) + 1, LEN(OwnerAddress)) as Address
From Data_cleaning_project.dbo.Nashville_Housing



ALTER TABLE Nashville_Housing
Add OwnerSplitAddress Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitAddress = SUBSTRING(OwnerAddress, 1, CHARINDEX(',', OwnerAddress) -1 )


ALTER TABLE Nashville_Housing
Add OwnerSplitCity Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitCity = SUBSTRING(OwnerAddress,CHARINDEX(',', OwnerAddress) + 1, CHARINDEX(',', OwnerAddress, CHARINDEX(',', OwnerAddress) + 1) - CHARINDEX(',', OwnerAddress) - 1)


ALTER TABLE Nashville_Housing
Add OwnerSplitState Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitState = SUBSTRING(OwnerAddress,CHARINDEX(',', OwnerAddress, CHARINDEX(',', OwnerAddress) + 1) + 1, LEN(OwnerAddress))



Select *
From Data_cleaning_project.dbo.Nashville_Housing




--------------------------------------------------------------------------------------------------------------------------


-- Change 1 and 0 to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant)
From Data_cleaning_project.dbo.Nashville_Housing



Select SoldAsVacant
, CASE When SoldAsVacant = '1' THEN 'Yes'
	   When SoldAsVacant = '0' THEN 'No'
	   END
From Data_cleaning_project.dbo.Nashville_Housing



--Change type to varchar 
ALTER TABLE dbo.Nashville_Housing
ALTER COLUMN SoldAsVacant VARCHAR(10); 


Update Nashville_Housing
SET SoldAsVacant = CASE When SoldAsVacant = '1' THEN 'Yes'
	   When SoldAsVacant = '0' THEN 'No'
	   END

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Data_cleaning_project.dbo.Nashville_Housing)

Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



--Delete duplicate rows
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Data_cleaning_project.dbo.Nashville_Housing)

Delete 
From RowNumCTE
Where row_num > 1



Select *
From Data_cleaning_project.dbo.Nashville_Housing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From Data_cleaning_project.dbo.Nashville_Housing


ALTER TABLE Data_cleaning_project.dbo.Nashville_Housing
DROP COLUMN OwnerAddress, PropertyAddress



Select *
From Data_cleaning_project.dbo.Nashville_Housing

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------