CREATE TABLE IF NOT EXISTS sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
);

CREATE TABLE IF NOT EXISTS words (
       word     TEXT,
       japanese TEXT,
       english  TEXT
);
