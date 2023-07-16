# 7) Product Development:
---------------------------------------------------------
# a) Which area of business should we focus more on our product development (Branding/taste/availability)?
select *, concat(round(total_respondents*100/sum(total_respondents) over ()), '%') as total_respondents_percentage
from (
	select Current_brands, Reasons_for_choosing_brands, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	where Current_brands = "codex" and Reasons_for_choosing_brands in ('Brand reputation', 'Taste/flavor preference', 'Availability')
	group by Reasons_for_choosing_brands
	order by total_respondents desc
    ) as top_3_reasons_for_choosing_CodeX;
---------------------------------------------------------
# b) Which aspect of taste should we focus more on improving?
with 
    improvements_desired as (
	select Current_brands, Improvements_desired, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	where Current_brands = "codex"
	group by Improvements_desired
	order by total_respondents desc
    )
select *, concat(round(total_respondents*100/sum(total_respondents) over ()), '%') as total_respondents_percentage
from improvements_desired;
