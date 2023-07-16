# 4) Marketing Channels and Brand Awareness:
---------------------------------------------------------
# a) Which marketing channel can be used to reach more customers?
select Current_brands, Marketing_channels, count(Respondent_ID) as respondents_by_channels
from fact_survey_responses
where Current_brands = "CodeX"
group by Marketing_channels
order by respondents_by_channels desc;
---------------------------------------------------------
# b) How effective are different marketing strategies and channels in reaching our customers?
with 
    top_marketing_channels_by_respondents as (
	select Current_brands, Marketing_channels, count(Respondent_ID) as total_respondents
	from fact_survey_responses
	where Current_brands = "CodeX"
	group by Marketing_channels
    )
select *, concat(round(total_respondents*100/total_respondents_of_CodeX), '%') as marketing_channel_percent_contribution
from (
	select *, sum(total_respondents) over() as total_respondents_of_CodeX
	from top_marketing_channels_by_respondents
     ) as total_respondents_by_brand
order by total_respondents desc;
---------------------------------------------------------
# c) List each marketing channel for all the current brands and their effectiveness.
with 
    top_marketing_channels_by_respondents as (
	select Current_brands, Marketing_channels, count(Respondent_ID) as total_respondents, rank() over(partition by Current_brands order by count(Respondent_ID) desc) as top_marketing_channels
	from fact_survey_responses
	group by Marketing_channels, Current_brands
    )
select *, concat(round(total_respondents*100/total_respondents_by_brand), '%') as marketing_channel_percent_contribution_by_brand
from (
	select *, sum(total_respondents) over(partition by Current_brands) as total_respondents_by_brand
	from top_marketing_channels_by_respondents
     ) as total_respondents_by_brand
order by total_respondents_by_brand desc, top_marketing_channels;
