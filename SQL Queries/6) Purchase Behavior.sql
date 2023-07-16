# 6) Purchase Behavior:
---------------------------------------------------------
# a) Where do respondents prefer to purchase energy drinks?
with total_respondents_by_purchase_location as (
	select Purchase_location, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	group by Purchase_location
	order by total_respondents desc
)
select *, concat(round(total_respondents*100/sum(total_respondents) over()), '%') as total_respondents_percentage
from total_respondents_by_purchase_location;
---------------------------------------------------------
# b) What are the typical consumption situations for energy drinks among respondents?
with total_respondents_by_situations as (
	select Typical_consumption_situations, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	group by Typical_consumption_situations
	order by total_respondents desc
)
select *, concat(round(total_respondents*100/sum(total_respondents) over ()), '%') as total_respondents_percentage
from total_respondents_by_situations;
---------------------------------------------------------
# c) What factors influence respondents' purchase decisions, such as price range and limited edition packaging?

# Query for price range
select *, concat(round(total_respondents*100/sum(total_respondents) over()), '%') as total_respondents_percentage
from (
	select Price_range, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	group by Price_range
	order by total_respondents desc
     ) as total_respondents_by_price;

# Query for limited edition packaging
select *, concat(round(total_respondents*100/sum(total_respondents) over()), '%') as total_respondents_percentage
from (
	select Limited_edition_packaging, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	group by Limited_edition_packaging
	order by total_respondents desc
     ) as total_respondents_by_LEP;
