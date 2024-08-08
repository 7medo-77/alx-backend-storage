-- SQL script lists all the origins and fans of meta bands
SELECT band_name,
	-- (IF(split=NULL, 2022, split) - formed) AS lifespan
	(IFNULL(split, 2020) - formed) AS lifespan
	-- (split - formed) AS lifespan
FROM metal_bands
WHERE style LIKE '%Glam rock%'
ORDER BY lifespan DESC;
