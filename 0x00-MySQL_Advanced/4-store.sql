-- SQL script lists all the origins and fans of meta bands
DELIMITER $$
CREATE TRIGGER count_delete
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	DECLARE item_name;
	DECLARE item_qty;
	DECLARE new_qty INT;

	SET item_name = NEW.item_name;
	SET item_qty= NEW.number;

	SELECT quantity INTO new_qty
	FROM items WHERE
	items.name = item_name;

	SET new_qty = new_qty + item_qty;
	UPDATE items
	SET quantity = new_qty
	WHERE name = item_name;
END
$$

-- CREATE TRIGGER set_default_status
-- BEFORE INSERT ON orders
-- FOR EACH ROW
-- BEGIN
--     IF NEW.status IS NULL THEN
--         SET NEW.status = 'Pending';
--     END IF;
-- END;
