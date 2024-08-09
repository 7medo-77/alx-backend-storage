-- SQL script lists all the origins and fans of meta bands

DELIMITER $$
CREATE TRIGGER count_delete
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	UPDATE items
	SET quantity = quantity - NEW.number;
	WHERE name = NEW.item_name;
END
$$
DELIMITER ;

-- DROP TRIGGER IF EXISTS reduce_quantity;
-- DELIMITER $$
-- CREATE TRIGGER reduce_quantity
-- AFTER INSERT ON orders
-- FOR EACH ROW
-- BEGIN
--     UPDATE items
--         SET quantity = quantity - NEW.number
--         WHERE name = NEW.item_name;
-- END $$
-- DELIMITER ;
