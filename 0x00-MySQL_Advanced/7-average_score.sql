-- SQL stored procedure

-- DELIMITER $$
--
-- DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
-- CREATE PROCEDURE ComputeAverageScoreForUser(
--     user_id INT
-- )
-- BEGIN
--     DECLARE total_score INT DEFAULT 0;
--     DECLARE user_count INT DEFAULT 0;
--     DECLARE avg_score FLOAT DEFAULT 0;
--
--     SELECT SUM(score)
--         INTO total_score
--         FROM corrections
--         WHERE user_id = user_id;
--
--     SELECT COUNT(*)
--         INTO user_count
--         FROM corrections
--         WHERE corrections.user_id = user_id;
--
--     SET avg_score = total_score / user_count;
--
--     UPDATE users
--         SET average_score = IF(avg_score = 0, 0, avg_score)
--         WHERE id = user_id;
--
-- END $$
-- DELIMITER ;


DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser (user_id INT)
BEGIN
    DECLARE total_score INT DEFAULT 0;
    DECLARE projects_count INT DEFAULT 0;

    SELECT SUM(score)
        INTO total_score
        FROM corrections
        WHERE corrections.user_id = user_id;
    SELECT COUNT(*)
        INTO projects_count
        FROM corrections
        WHERE corrections.user_id = user_id;

    UPDATE users
        SET users.average_score = IF(projects_count = 0, 0, total_score / projects_count)
        WHERE users.id = user_id;
END $$
DELIMITER ;
