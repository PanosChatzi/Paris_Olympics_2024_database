-- Find the names of all Greek athletes that participated in the 2024 Tokyo Olympics
SELECT "name", "disciplines", "events"
FROM "athletes"
WHERE "country" = 'Greece';

-- Find the total number of Greek athletes
SELECT COUNT("name") AS "Total_Greek_Athletes"
FROM "athletes"
WHERE "country" = 'Greece';

-- Find the athlete name, medal type, discipline and event of individual Greek athletes
SELECT "athlete_name", "medal_type", "discipline", "event"
FROM "medals"
WHERE "athlete_name" LIKE '%TENTOGLOU';

-- Find the athlete name, medal type, discipline and event of all Greek athletes
SELECT "athlete_name", "medal_type", "discipline", "event"
FROM "medals"
WHERE "country" = 'Greece'
ORDER BY "medal_type" DESC;

-- Find all atletes who participated in Athletics and their respective event
SELECT DISTINCT "athlete_name", "event"
FROM "medals"
WHERE "discipline" = 'Athletics';

-- Find the athlete who won the most medals
SELECT "athlete_name", COUNT("medal_type") AS "total_medals"
FROM "medals"
GROUP BY "athlete_name"
ORDER BY "total_medals" DESC
LIMIT 1;

-- Find total medals by type
SELECT "medal_type", COUNT("medal_type") AS "total_medals"
FROM "medals"
WHERE "country" = 'Greece'
GROUP BY "medal_type"
ORDER BY "medal_type" DESC;

-- Double check with the total medals table
SELECT "gold_medal", "silver_medal", "bronze_medal", "total"
FROM "medals_total"
WHERE "country" = 'Greece';

-- It seems two medals are missing from the medals table

-- Find the top 10 countries sorted by total medals
SELECT "country", "gold_medal", "silver_medal", "bronze_medal", "total"
FROM "medals_total"
ORDER BY "total" DESC
LIMIT 10;

-- Find the top 10 countries sorted by gold medals
SELECT "country", "gold_medal", "silver_medal", "bronze_medal", "total"
FROM "medals_total"
ORDER BY "gold_medal" DESC
LIMIT 10;

-- Find the country with the most medals
SELECT "country", MAX("gold_medal") AS "max_gold_medals"
FROM "medals_total"
GROUP BY "country"
ORDER BY "max_gold_medals" DESC
LIMIT 1;

-- Find all athletes who won a medal in a specific discipline (e.g., "Athletics") and their medal type
-- The medals table already has athlete_name, but use JOIN with the athletes just for practice.
SELECT
    "athletes"."name" AS "athlete_name",
    "medals"."medal_type",
    "medals"."discipline",
    "medals".event
FROM "medals"
JOIN "athletes" ON "medals"."athlete_code" = "athletes"."code"
WHERE "medals"."discipline" = 'Athletics';

-- Find the total number of athletes that participated vs the total medallists
SELECT
    COUNT(DISTINCT "athletes"."code") AS "total_participants",
    COUNT(DISTINCT "medals"."athlete_code") AS "total_medallists"
FROM "athletes"
LEFT JOIN "medals" ON "athletes"."code" = "medals"."athlete_code";

-- Find the total male and female participants
SELECT COUNT("gender") AS "Total_female_male_athletes"
FROM "athletes"
GROUP BY "gender";

-- Create a view of the top ten countries
CREATE VIEW "top_10_medal_countries" AS
SELECT
    "country",
    "gold_medal",
    "silver_medal",
    "bronze_medal",
    "total"
FROM "medals_total"
ORDER BY "total" DESC
LIMIT 10;
