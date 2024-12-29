-- CREATE the database
CREATE DATABASE tokyo_olympics_2024;

-- USE the tokyo_olympics_2024 database
\c tokyo_olympics_2024;

-- CREATE tables
-- Athletes
CREATE TABLE athletes (
    code SERIAL PRIMARY KEY,
    current BOOLEAN,
    name VARCHAR(255),
    name_short VARCHAR(255),
    name_tv VARCHAR(255),
    gender VARCHAR(10),
    function VARCHAR(50),
    country_code CHAR(3),
    country VARCHAR(100),
    country_long VARCHAR(100),
    nationality_code VARCHAR(100),
    nationality VARCHAR(100),
    nationality_long VARCHAR(100),
    height NUMERIC,
    weight NUMERIC,
    disciplines TEXT[],
    events TEXT[],
    birth_date DATE,
    birth_place VARCHAR(255),
    birth_country VARCHAR(100),
    residence_place VARCHAR(255),
    residence_country VARCHAR(100),
    nickname TEXT,
    hobbies TEXT,
    occupation TEXT,
    education TEXT,
    family TEXT,
    lang TEXT,
    coach TEXT,
    reason TEXT,
    hero TEXT,
    influence TEXT,
    philosophy TEXT,
    sporting_relatives TEXT,
    ritual TEXT,
    other_sports TEXT
);

-- Events
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    event VARCHAR(255),
    tag VARCHAR(50),
    sport VARCHAR(100),
    sport_code CHAR(3),
    sport_url TEXT
);

-- Medallists
CREATE TABLE medallists (
    id SERIAL PRIMARY KEY,
    medal_date DATE,
    medal_type VARCHAR(50),
    medal_code NUMERIC,
    athlete_code INT REFERENCES athletes(code),
    gender VARCHAR(10),
    country_code CHAR(3),
    country VARCHAR(100),
    country_long VARCHAR(100),
    nationality_code CHAR(3),
    nationality VARCHAR(100),
    nationality_long VARCHAR(100),
    team VARCHAR(255),
    team_gender VARCHAR(10),
    discipline VARCHAR(100),
    event VARCHAR(255),
    event_type VARCHAR(10),
    url_event TEXT,
    birth_date DATE,
    is_medallist BOOLEAN
);

-- Medals
CREATE TABLE medals (
    id SERIAL PRIMARY KEY,
    medal_type VARCHAR(50),
    medal_code NUMERIC,
    medal_date DATE,
    athlete_name VARCHAR(255),
    gender CHAR(1),
    discipline VARCHAR(100),
    event VARCHAR(255),
    event_type VARCHAR(10),
    url_event TEXT,
    athlete_code INT REFERENCES athletes(code),
    country_code CHAR(3),
    country VARCHAR(100),
    country_long VARCHAR(100)
);

-- Medals Total
CREATE TABLE medals_total (
    id SERIAL PRIMARY KEY,
    country_code CHAR(3),
    country VARCHAR(100),
    country_long VARCHAR(100),
    gold_medal INT,
    silver_medal INT,
    bronze_medal INT,
    total INT
);

-- Teams
CREATE TABLE teams (
    code VARCHAR(50) PRIMARY KEY,
    current BOOLEAN,
    team VARCHAR(255),
    team_gender CHAR(1),
    country_code CHAR(3),
    country VARCHAR(100),
    country_long VARCHAR(100),
    discipline VARCHAR(100),
    disciplines_code CHAR(3),
    events TEXT,
    athletes TEXT,
    coaches TEXT,
    athletes_codes TEXT,
    num_athletes NUMERIC,
    coaches_codes TEXT,
    num_coaches NUMERIC
);

-- Create indexes to speed up common searches
-- Index for searching by athlete code in the medals and medallists tables
CREATE INDEX idx_athlete_code_medals ON medals (athlete_code);
CREATE INDEX idx_athlete_code_medallists ON medallists (athlete_code);

-- Index for searching by country code in the medals, medallists, and medals_total tables
CREATE INDEX idx_country_code_medals ON medals (country_code);
CREATE INDEX idx_country_code_medallists ON medallists (country_code);
CREATE INDEX idx_country_code_medals_total ON medals_total (country_code);

-- Index for searching by medal type in the medals table
CREATE INDEX idx_medal_type ON medals (medal_type);

-- Index for searching by discipline and event in the medals and medallists tables
CREATE INDEX idx_discipline_event_medals ON medals (discipline, event);
CREATE INDEX idx_discipline_event_medallists ON medallists (discipline, event);

-- Index for searching by country code and discipline in the medallists table
CREATE INDEX idx_country_discipline_medallists ON medallists (country_code, discipline);

-- INSERT data from csv files
-- change date format to match the csv data
SET datestyle = 'DMY';

-- athletes table
\copy athletes (code, current, name, name_short, name_tv, gender, function, country_code, country, country_long, nationality_code, nationality, nationality_long, height, weight, disciplines, events, birth_date, birth_place, birth_country, residence_place, residence_country, nickname, hobbies, occupation, education, family, lang, coach, reason, hero, influence, philosophy, sporting_relatives, ritual, other_sports)
FROM '/mnt/cs50sql/project/data/athletes.csv'
DELIMITER ';'
CSV HEADER;

-- events table
\copy events (event, tag, sport, sport_code, sport_url)
FROM '/mnt/cs50sql/project/data/events.csv'
DELIMITER ','
CSV HEADER;

-- medallists table
\copy medallists (id, medal_date, medal_type, medal_code, athlete_code, gender, country_code, country, country_long, nationality_code, nationality, nationality_long, team, team_gender, discipline, event, event_type, url_event, birth_date, is_medallist)
FROM '/mnt/cs50sql/project/data/medallists.csv'
DELIMITER ','
CSV HEADER;

-- medals table
\copy medals (medal_type, medal_code, medal_date, athlete_name, gender, discipline, event, event_type, url_event, athlete_code, country_code, country, country_long)
FROM '/mnt/cs50sql/project/data/medals.csv'
DELIMITER ';'
CSV HEADER;

-- total medals table
\copy medals_total (country_code, country, country_long, gold_medal, silver_medal, bronze_medal, total)
FROM '/mnt/cs50sql/project/data/medals_total.csv'
DELIMITER ','
CSV HEADER;

-- teams table
\copy teams (code, current, team, team_gender, country_code, country, country_long, discipline, disciplines_code, events, athletes, coaches, athletes_codes, num_athletes, coaches_codes, num_coaches)
FROM '/mnt/cs50sql/project/data/teams.csv'
DELIMITER ','
CSV HEADER;
