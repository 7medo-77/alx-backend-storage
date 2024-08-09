-- SQL script which defines a trigger that reduces the
-- quantity of an item when a new order is made
DELIMITER $$
CREATE TRIGGER count_delete
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	UPDATE items
		SET quantity = quantity - NEW.number
	WHERE items.name = NEW.item_name;
END
$$
DELIMITER ;
