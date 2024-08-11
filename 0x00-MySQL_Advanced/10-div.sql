-- SQL script which creates a function that divides two numbers safely
DELIMITER $$
CREATE FUNCTION SafeDiv (a INT, b INT)
RETURNS FLOAT
BEGIN
    DECLARE result FLOAT DEFAULT 0;

    SET result = IF(a = 0 OR b = 0, 0, a / b);
    RETURN result;
END $$
DELIMITER ;
