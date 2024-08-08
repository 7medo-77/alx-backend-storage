-- SQL script that creates a new table called users
-- with constraints for id an email columns
CREATE TABLE IF NOT EXISTS users (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255) NOT NULL UNIQUE,
	country ENUM('US', 'CO', 'TN') NOT NULL,
)
