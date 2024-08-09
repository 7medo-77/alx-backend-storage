-- SQL script which defines a trigger that reduces the
-- quantity of an item when a new order is made
DROP TRIGGER IF EXISTS change_mail;
DELIMITER $$
CREATE TRIGGER change_mail
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	IF OLD.email != NEW.email THEN
		SET NEW.valid_email = 0;
		IF OLD.valid_email != 0
			SET NEW.valid_email = 0;
		END IF;
	END IF;
END $$
DELIMITER ;
