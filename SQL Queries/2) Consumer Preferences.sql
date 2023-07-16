# 2) Consumer Preferences:
---------------------------------------------------------
# a) What are the preferred ingredients of energy drinks among respondents?
select Ingredients_expected as Ingredients, count(Respondent_ID) as total_respondents
from fact_survey_responses
group by Ingredients_expected
order by total_respondents desc;
---------------------------------------------------------
# b) What packaging preferences do respondents have for energy drinks?
select Packaging_preference, count(Respondent_ID) as total_respondents
from fact_survey_responses
group by Packaging_preference
order by total_respondents desc;
