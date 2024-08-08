-- SQL script lists all the origins and fans of meta bands
SELECT origin AS origin, fans AS nb_fans FROM holberton.metal_bands ORDER BY `nb_fans` DESC;
