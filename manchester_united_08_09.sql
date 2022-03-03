-- Kita akan melihat bagaimana hasil pertandingan manchester united
-- selama musim 2008/2009


-- select EPL country id
SELECT country_id
FROM League
WHERE name == 'England Premier League';

--select semua pertandingan EPL
SELECT id, country_id, league_id, season, date,
		match_api_id, home_team_api_id, away_team_api_id,
		home_team_goal, away_team_goal
FROM Match
WHERE country_id == (
	SELECT country_id
	FROM League
	WHERE name == 'England Premier League'
);

-- select team_id dan team_name dari EPL
SELECT DISTINCT t.team_api_id, t.team_long_name, t.team_short_name
FROM Match as m
INNER JOIN Team as t
ON m.home_team_api_id = t.team_api_id
WHERE m.country_id == (
	SELECT country_id
	FROM League
	WHERE name == 'England Premier League'
);

-- Melihat semua hasil pertandingan home Manchester United tahun 2008/2009
SELECT season, team_long_name as tim_away, 
		home_team_goal, away_team_goal,
		CASE WHEN home_team_goal > away_team_goal THEN 'M.Utd Menang'
			 WHEN home_team_goal < away_team_goal THEN 'M.Utd Kalah'
			 ELSE 'Imbang' END AS hasil
FROM epl_matches as m
INNER JOIN epl_teams as t
ON m.away_team_api_id = t.team_api_id
WHERE m.home_team_api_id == 10260 AND season = '2008/2009';

-- Melihat semua hasil pertandingan away manchester United tahun 2008/2009
SELECT season, team_long_name as tim_home, 
		home_team_goal, away_team_goal,
		CASE WHEN home_team_goal < away_team_goal THEN 'M.Utd Menang'
			 WHEN home_team_goal > away_team_goal THEN 'M.Utd Kalah'
			 ELSE 'Imbang' END AS hasil
FROM epl_matches as m
INNER JOIN epl_teams as t
ON m.home_team_api_id = t.team_api_id
WHERE m.away_team_api_id == 10260 AND season = '2008/2009';

-- Performa Manchester United saat pertandingan home dibandingkan tim lainnya tahun 2008/2009
SELECT team_long_name as home_team,
		SUM(home_team_goal) as total_gol,
		SUM(away_team_goal) as total_kebobolan,
		ROUND(AVG(home_team_goal),2) as avg_gol,
		ROUND(AVG(away_team_goal),2) as avg_kebobolan
FROM epl_matches as m
INNER JOIN epl_teams as t
ON m.home_team_api_id = t.team_api_id
WHERE season = '2008/2009'
GROUP BY team_long_name
ORDER BY avg_gol DESC;


-- Performa Manchester United saat pertandingan away dibandingkan tim lainnya tahun 2008/2009
SELECT team_long_name as away_team,
		SUM(away_team_goal) as total_gol,
		SUM(home_team_goal) as total_kebobolan,
		ROUND(AVG(away_team_goal),2) as avg_gol,
		ROUND(AVG(home_team_goal),2) as avg_kebobolan
FROM epl_matches as m
INNER JOIN epl_teams as t
ON m.away_team_api_id = t.team_api_id
WHERE season = '2008/2009'
GROUP BY team_long_name
ORDER BY avg_gol DESC;
