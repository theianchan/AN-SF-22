
-- It's 2010
-- Research Question: For its next version, should Firefox focus on revamping the bookmark experience or supporting a large number of tabs?

-- 1
-- Describe the users represented in the data. Do you think they're representative of the population of Firefox users?
-- Describe any initial findings related to your research questions.
-- Describe what you still need to do for your presentation in order to make a sound recommendation.

-- Describe:
-- The overall population of Firefox users

select
	count(id)
from users;
-- 27267

-- The subset of users in the events table
-- The subset of users in the survey table

select
	user_id,
	event_code,
	data1,
	data2,
	data3,
	timestamp,
	to_timestamp(timestamp / 1000),
	to_timestamp(timestamp / 1000)::date,
	session_id
from events
limit 1;

-- 2
-- Review the Users table. Summarize the users represented in the survey.
-- Review the Survey table. How many of the total users completed the survey?
-- Of users who completed the survey, identify the number of users who are new to Firefox, as well as those who are longtime users.

-- Bookmarks suggestions:
-- What's the median number of bookmarks? What’s the average number?
-- What fraction of users launched at least one bookmark during the sample week?
-- What fraction of users created new bookmarks?
-- What's the distribution of how often bookmarks are used?
-- How does number of bookmarks correlate with how long the user has been using Firefox?

-- Browser tabs suggestions:
-- What's the distribution of the maximum number of tabs?
-- Are there users who regularly have more than 10 tabs open?
-- What fraction of user have ever had more than five tabs open? What fraction of users have ever had more than 10 tabs open? What fraction of users have had more than 15 tabs open?

-- Recommendation
-- Do you agree or disagree with your opinionated colleague?
-- Do you think the team should go in a different direction?

