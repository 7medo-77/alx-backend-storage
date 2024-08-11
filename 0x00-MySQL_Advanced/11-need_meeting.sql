-- SQL script that creates a view need_meeting
CREATE VIEW need_meeting AS
SELECT name
    FROM students
    WHERE score < 80 AND
    ( last_meeting = NULL OR MONTH(DATEDIFF(CURDATE(), last_meeting)) > 1 );
