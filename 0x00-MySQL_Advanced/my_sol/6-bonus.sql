-- SQL stored procedure
DELIMITER $$
CREATE PROCEDURE AddBonus (
	user_id INT,
	project_name VARCHAR(255),
	score FLOAT
)
BEGIN
	IF NOT EXISTS project_name
	INSERT INTO corrections (user_id, project_name, score) values (user_id, project_name, score);
END
DELIMITER ;
