-- SQL script which creates a function that divides two numbers safely
DELIMITER $$
CREATE FUNCTION SafeDiv (a INT, b INT)
RETURNS FLOAT
BEGIN
    RETURN IF(a = 0 OR b = 0, 0, a / b);
END
DELIMITER ;
