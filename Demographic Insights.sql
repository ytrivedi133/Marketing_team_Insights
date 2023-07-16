# 1) Demographic Insights:

# a) Who prefers energy drink more? (male/female/non-binary?)
select Gender, count(Respondent_ID) as total_respondents
from dim_respondents
group by gender
order by total_respondents desc;

# b) Which age group prefers energy drinks more? 
select Age, count(Respondent_ID) as total_respondents
from dim_respondents
group by Age
order by total_respondents desc;

# c) Which type of marketing reaches the most Youth (15-30)?
select Marketing_channels, count(Age) as total_youths
from dim_respondents people
	join fact_survey_responses surRes on surRes.Respondent_ID = people.Respondent_ID
where age in ('15-18', '19-30')
group by Marketing_channels
order by total_youths desc;
