# 3) Competition Analysis:

# a) Who are the current market leaders?
select Current_brands, count(Respondent_ID) as total_respondents
from fact_survey_responses
group by Current_brands
order by total_respondents desc;

# b) What are the primary reasons consumers prefer those brands over ours? 
with 
	window_by_brands_and_reasons as (
		select Current_brands, Reasons_for_choosing_brands, count(Respondent_ID) over(partition by Current_brands, Reasons_for_choosing_brands) as total_respondents
		from fact_survey_responses
	), 
	top_5_brands as (
		select *, concat(round(total_respondents*100/sum(total_respondents) over(partition by Reasons_for_choosing_brands)),'%') as percent_preference_by_brand, lag(total_respondents) over (partition by Reasons_for_choosing_brands order by total_respondents desc) as leader_brands_respondents
		from window_by_brands_and_reasons
		where Reasons_for_choosing_brands in ("Brand reputation", "Taste/flavor preference", "Effectiveness") and Current_brands in ("Cola-Coka", "Bepsi", "Gangster", "Blue Bull", "CodeX")
		group by Reasons_for_choosing_brands, current_brands
	),
	sum_of_respondents as (
		select *, sum(leader_brands_respondents) over (partition by Reasons_for_choosing_brands) as leader_brands_respondents_total, sum(total_respondents) over(partition by Reasons_for_choosing_brands) as total_respondents_sum
		from top_5_brands
	)
select *, concat(round(leader_brands_respondents_total/total_respondents_sum*100), '%') as total_percent_preference_of_4_leader_brands_over_CodeX
from sum_of_respondents 
order by total_percent_preference_of_4_leader_brands_over_CodeX desc;

# c) What is one reason for consumers over choosing energy drink brands? How effective is it? 
with window_by_brands_and_reasons as (
    select Reasons_for_choosing_brands, count(Respondent_ID) as total_respondents
    from fact_survey_responses
    group by Reasons_for_choosing_brands
    order by total_respondents desc
)
select *, concat(round(total_respondents*100/sum(total_respondents) over()), '%') as percent_contribution_of_consumers
from window_by_brands_and_reasons;
