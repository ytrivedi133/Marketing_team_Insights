# 5) Brand Penetration:
---------------------------------------------------------
# a) What do people think about our brand (overall rating)?
select *, concat(round(total_respondents*100/sum(total_respondents) over ()), '%') as total_respondents_percentage
from (
	select Current_brands, Brand_perception, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	where Current_brands = "codex"
	group by Brand_perception
	order by total_respondents desc
     ) as brand_perception;
---------------------------------------------------------
# b) Which cities do we need to focus more on?
with 
    respondents_by_city as (
	select Current_brands, City, count(fsr.Respondent_ID) as total_respondents
	from dim_respondents dr 
	    join dim_cities dc on dc.City_ID = dr.City_ID
	    join fact_survey_responses fsr using (Respondent_ID)
	where Current_brands = "codex"
	group by City
	order by total_respondents desc
    )
select *, concat(round(total_respondents*100/sum(total_respondents) over ()), '%') as total_respondents_percentage
from respondents_by_city;
