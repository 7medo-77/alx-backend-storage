-- SQL script which creates an index on the columns names and score
CREATE INDEX idx_name_first_score ON names(names(1), score);
