-- SQL script lists all the origins and fans of meta bands

DELIMITER $$
CREATE TRIGGER count_delete
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	DECLARE item_name VARCHAR(255);
	DECLARE item_qty INT;
	DECLARE new_qty INT;

	SET item_name = NEW.item_name;
	SET item_qty= NEW.number;

	SELECT quantity INTO new_qty
	FROM items WHERE
	items.name = item_name;

	SET new_qty = new_qty - item_qty;
	UPDATE items
	SET quantity = new_qty
	WHERE name = item_name;
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
