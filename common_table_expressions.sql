-- list of country and number of matches with more than 10 total goals

WITH h AS (
		SELECT team_api_id, team_long_name
		FROM Team),
a AS (
		SELECT team_api_id, team_long_name
		FROM Team),
c AS (
		SELECT name, country_id
		FROM League)
SELECT  date,
		c.name,
		h.team_long_name as home_team,
		a.team_long_name as away_team,
		home_team_goal as home_goal,
		away_team_goal as away_goal
FROM Match as m
INNER JOIN h
ON m.home_team_api_id = h.team_api_id
INNER JOIN a
ON m.away_team_api_id = a.team_api_id
INNER JOIN c
ON m.country_id = c.country_id
WHERE (home_team_goal + away_team_goal) >= 10;


-- how many matches with 10 goals or more in each country?
WITH match_list AS(
	SELECT country_id, id
	FROM Match
	WHERE (home_team_goal + away_team_goal) >= 10)
SELECT l.name,
		COUNT(ma.country_id) as matches_with_ten_goals
FROM League as l
LEFT JOIN match_list as ma
ON l.country_id = ma.country_id
GROUP BY l.name

