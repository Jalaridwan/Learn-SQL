/* list of matches where total goal scored
is more than 3*average for game in matches 2013/2014 */

SELECT 3*AVG(home_team_goal + away_team_goal)
FROM Match
WHERE season = '2013/2014';

SELECT date, home_team_api_id, away_team_api_id, season, home_team_goal, away_team_goal
FROM Match
WHERE (home_team_goal + away_team_goal) > 
	(SELECT 3*AVG(home_team_goal + away_team_goal)
	FROM Match
	WHERE season = '2013/2014')
AND season = '2013/2014';

-- Generate a list of teams that never played a game in their home city
SELECT team_long_name
FROM Team
WHERE team_api_id NOT IN
	(SELECT DISTINCT home_team_api_id FROM Match);
	
-- matches with 10 or more goals in total
SELECT country_id, match_api_id
FROM Match
WHERE home_team_goal + away_team_goal >= 10;

-- country that has matches with 10 or more goals in total
SELECT c.name, m.match_api_id
FROM Country as c
INNER JOIN (SELECT country_id, match_api_id, home_team_api_id as home, away_team_api_id as away
			FROM Match
			WHERE home_team_goal + away_team_goal >= 10) as m
ON c.id = m.country_id;

-- every teams in matches with 10 or more goals
SELECT m.date, m.match_api_id, th.team_long_name as home, ta.team_long_name as away, m.home_team_goal, m.away_team_goal
FROM Match as m
INNER JOIN (SELECT team_api_id, team_long_name
			FROM Team) as th
ON m.home_team_api_id = th.team_api_id
INNER JOIN (SELECT team_api_id, team_long_name
			FROM Team) as ta
ON m.away_team_api_id = ta.team_api_id
WHERE home_team_goal + away_team_goal >= 10;

-- calculate difference between average goal in each country's league and avarage goal in total, from season 2011/2012
SELECT l.name as league_name,
		AVG(home_team_goal + away_team_goal)as avg_goals_each_league,
		(AVG(home_team_goal + away_team_goal) - 
			(SELECT AVG(home_team_goal + away_team_goal)
			 FROM Match
			 WHERE season = '2011/2012')
		 ) as diff
FROM Match as m
INNER JOIN League as l
ON m.country_id = l.country_id
WHERE season = '2011/2012'
GROUP BY league_name;

-- average goals scored in each stage of a Match in 2011/2012 season
-- does the average number change as the stage get higher?

SELECT  stage,
		AVG(home_team_goal + away_team_goal) as avg_goal,
		(SELECT AVG(home_team_goal + away_team_goal)
		 FROM Match
		 WHERE season = '2011/2012') as overall_avg
FROM Match
WHERE season = '2011/2012'
GROUP BY stage;

-- select stages where avg_goal in stage is higher than overall average goals
SELECT stage
FROM ( SELECT   stage,
				AVG(home_team_goal+away_team_goal) as avg_home_goal_stage
		FROM Match
		WHERE season = '2011/2012'
		GROUP BY stage
	  ) as sub
WHERE avg_home_goal_stage > 
		(SELECT AVG(home_team_goal + away_team_goal)
		FROM Match
		WHERE season = '2011/2012');
		
-- compare avg goal scared in each stage to the total
SELECT stage, avg_home_goal_stage,
		(SELECT AVG(home_team_goal + away_team_goal)
		FROM Match
		WHERE season = '2011/2012') as avg_goal_overall
FROM ( SELECT   stage,
				AVG(home_team_goal+away_team_goal) as avg_home_goal_stage
		FROM Match
		WHERE season = '2011/2012'
		GROUP BY stage
	  ) as sub
WHERE avg_home_goal_stage > 
		(SELECT AVG(home_team_goal + away_team_goal)
		FROM Match
		WHERE season = '2011/2012');