-- SQL script lists all the origins and fans of meta bands
SELECT origin AS origin,
	SUM(fans) AS nb_fans
FROM holberton.metal_bands
GROUP BY `origin`
ORDER BY `nb_fans` DESC;
