SELECT *
FROM Nashville_Housing;

--Standardize date format
SELECT SaleDate, CONVERT(DATE, SaleDate)
FROM Nashville_Housing;

UPDATE Nashville_Housing
SET SaleDate = CONVERT(DATE, SaleDate)
----------------------------------------------------------------------------------------------------------------------------------
--Populate property address data
	SELECT *
	FROM Nashville_Housing
	WHERE PropertyAddress IS NULL;

	SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
	FROM Nashville_Housing a
	JOIN Nashville_Housing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
	WHERE a.PropertyAddress IS NULL

	UPDATE a 
	SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
	FROM Nashville_Housing a
	JOIN Nashville_Housing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
	WHERE a.PropertyAddress IS NULL
---------------------------------------------------------------------------------------------------------------------------------
--Breaking out address into indiviual columns Address, City,State
--Splitting Property address using Method 1 (Substring & CharIndex)

SELECT PropertyAddress
	FROM Nashville_Housing
	--WHERE PropertyAddress IS NULL;

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress)+1 , LEN(PropertyAddress)) AS Address
FROM Nashville_Housing


ALTER TABLE Nashville_Housing
ADD PropertySplitAddress NVARCHAR(255) 

UPDATE Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress)-1)

ALTER TABLE Nashville_Housing
ADD PropertySplitCity NVARCHAR(255) 

UPDATE Nashville_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress)+1 , LEN(PropertyAddress))

SELECT *
FROM Nashville_Housing

--Splitting Owner address using Method 2 (Parsename & Replace)

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3),
PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2),
PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)
FROM Nashville_Housing

ALTER TABLE Nashville_Housing
ADD OwnnerSplitAddress NVARCHAR(255) 

UPDATE Nashville_Housing
SET OwnnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3)

ALTER TABLE Nashville_Housing
ADD OwnerSplitCity NVARCHAR(255) 

UPDATE Nashville_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2)

ALTER TABLE Nashville_Housing
ADD OwnerSplitState NVARCHAR(255) 

UPDATE Nashville_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)
--------------------------------------------------------------------------------------------------------------------------------

--change Y and N to yes and No in 'Sold as Vacant' Fields
--My csv file changed this column into 1s and 0s

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Nashville_Housing
GROUP BY SoldAsVacant

SELECT SoldAsVacant, 
CASE When SoldAsVacant = 1 THEN 'Yes' 
	When SoldAsVacant = 0 THEN 'No' 
	ELSE CAST(SoldAsVacant AS VARCHAR)
	END
	FROM Nashville_Housing

ALTER TABLE Nashville_Housing 
ALTER COLUMN SoldAsVacant VARCHAR(3);

UPDATE Nashville_Housing
SET SoldAsVacant = CASE When SoldAsVacant = 1 THEN 'Yes' 
	When SoldAsVacant = 0 THEN 'No' 
	ELSE CAST(SoldAsVacant AS VARCHAR)
	END
	-----------------------------------------------------------------------------------------------------------------------------
	--Remove duplicates

WITH ROWNUMCTE AS(
SELECT *,
	ROW_NUMBER () OVER (
	PARTITION BY ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			ORDER BY 
			UniqueID
			) row_num
FROM Nashville_Housing
--ORDER BY ParcelID
)
SELECT *
From ROWNUMCTE
Where row_num > 1
--Order By PropertyAddress
----------------------------------------------------------------------------------------------------------------------------------

--Delete unused columns
SELECT *
FROM Nashville_Housing

ALTER TABLE Nashville_Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Nashville_Housing
DROP COLUMN SaleDate
