#find distinct user ID's
SELECT COUNT(DISTINCT id) AS daily_activity_id 
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`;

SELECT COUNT(DISTINCT id) AS daily_calories_id  
FROM `bellabeat-case-study-375620.bellabeat.daily_calories`;

SELECT COUNT(DISTINCT id) AS daily_intensities_id 
FROM `bellabeat-case-study-375620.bellabeat.daily_intensities`;

SELECT COUNT(DISTINCT id) AS daily_sleep_id  
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep`;

SELECT COUNT(DISTINCT id) AS daily_steps_id 
FROM `bellabeat-case-study-375620.bellabeat.daily_steps`;

SELECT COUNT(DISTINCT id) AS hourly_calories_id 
FROM `bellabeat-case-study-375620.bellabeat.hourly_calories`;

SELECT COUNT(DISTINCT id) AS hourly_intensities_id 
FROM `bellabeat-case-study-375620.bellabeat.hourly_intensities`;

SELECT COUNT(DISTINCT id) AS hourly_steps_id 
FROM `bellabeat-case-study-375620.bellabeat.hourly_steps`;

# --------------------------------------------------------------------------------------
# doubble check for duplicates 

SELECT 
  id,
  SleepDay,
  TotalSleepRecords,
  TotalMinutesAsleep,
  TotalTimeInBed, 
  COUNT(*) as count
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep`
group by
  id, 
  SleepDay,
  TotalSleepRecords,
  TotalMinutesAsleep,
  TotalTimeInBed
having count(*) > 1
order by 
  SleepDay;


# --------------------------------------------------------------------------------------
# device usage

#device usage
SELECT 
  id, 
  avg(VeryActiveMinutes/60)*100 as very_active_min, 
  avg(FairlyActiveMinutes/60) as fairly_active_min,
  avg(LightlyActiveMinutes/60) as lightly_active_min,
  avg(SedentaryMinutes/60) as sednetary_min,
  sum(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes) as Total_usage
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
group by id;


#device usage average with sedentary min
SELECT 
  avg(VeryActiveMinutes) as very_active_minutes_avg, 
  avg(FairlyActiveMinutes) as fairly_active_minutes_avg,
  avg(LightlyActiveMinutes) as lightly_active_minutes_avg,
  avg(SedentaryMinutes) as sednetary_minutes_avg,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`;

#device usage w/o sedentary min average
SELECT 
  avg(VeryActiveMinutes) as very_active_minutes_avg, 
  avg(FairlyActiveMinutes) as fairly_active_minutes_avg,
  avg(LightlyActiveMinutes) as lightly_active_minutes_avg,
  #avg(SedentaryMinutes) as sednetary_msum
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`;


#device usage average with sedentary sum
SELECT 
  sum(VeryActiveMinutes) as very_active_minutes_sum, 
  sum(FairlyActiveMinutes) as fairly_active_minutes_sum,
  sum(LightlyActiveMinutes) as lightly_active_minutes_sum,
  sum(SedentaryMinutes) as sednetary_minutes_sum,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`;

#device usage w/o sedentary min sum
SELECT 
  sum(VeryActiveMinutes) as very_active_minutes_sum, 
  sum(FairlyActiveMinutes) as fairly_active_minutes_sum,
  sum(LightlyActiveMinutes) as lightly_active_minutes_sum,
  #avg(SedentaryMinutes) as sednetary_min,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`;


# sum, avg, min, max deveice usage by ID w/o sedentary min (track usage when users are using the watch / not sleeping)
SELECT 
  id,
  sum(LightlyActiveMinutes) as light_active_minutes_sum,
  sum(FairlyActiveMinutes) as fairly_active_minutes_sum,
  sum(VeryActiveMinutes) as Very_active_minutes_sum,
  avg(LightlyActiveMinutes) as light_active_minutes_avg,
  avg(FairlyActiveMinutes) as fairly_active_minutes_avg,
  avg(VeryActiveMinutes) as Very_active_minutes_avg,
  min(LightlyActiveMinutes) as light_active_minutes_min,
  min(FairlyActiveMinutes) as fairly_active_minutes_min,
  min(VeryActiveMinutes) as Very_active_minutes_min,
  max(LightlyActiveMinutes) as light_active_minutes_max,
  max(FairlyActiveMinutes) as fairly_active_minutes_max,
  max(VeryActiveMinutes) as Very_active_minutes_max,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
GROUP BY id;


SELECT 
  id,
  avg(LightlyActiveMinutes) as light_active_minutes_avg,
  avg(FairlyActiveMinutes) as fairly_active_minutes_avg,
  avg(VeryActiveMinutes) as Very_active_minutes_avg,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
GROUP BY id;


SELECT 
  id,
  sum(LightlyActiveMinutes) as light_active_minutes_sum,
  sum(FairlyActiveMinutes) as fairly_active_minutes_sum,
  sum(VeryActiveMinutes) as Very_active_minutes_sum,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
GROUP BY id;


# --------------------------------------------------------------------------------------
# activity, steps, calories by day of week 

# activity amount by day of week
SELECT 
  FORMAT_DATE('%A', DATE(ActivityDate)) AS day_of_week,
  sum(VeryActiveMinutes) as very_active_minutes_sum,
  sum(FairlyActiveMinutes) as fairly_active_minutes_sum,
  sum(LightlyActiveMinutes) as lightly_active_minutes_sum,
  sum(SedentaryMinutes) as sedentary_minutes_sum,
  avg(VeryActiveMinutes) as very_active_minutes_avg,
  avg(FairlyActiveMinutes) as fairly_active_minutes_avg,
  avg(LightlyActiveMinutes) as lightly_active_minutes_avg,
  avg(SedentaryMinutes) as sedentary_minutes_avg
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
group by day_of_week;

# sum activity amount by day of week 3 (no sedentary min)
SELECT  
  FORMAT_DATE('%A', DATE(ActivityDate)) AS day_of_week,
  Sum(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes) as active_total_min,
  AVG(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes) as active_avg_min,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
group by day_of_week;

# sum of steps by day of week
SELECT 
  FORMAT_DATE('%A', DATE(ActivityDay)) AS day_of_week,
  SUM(StepTotal) as sum_of_steps,
  AVG(StepTotal) as avg_of_steps
FROM `bellabeat-case-study-375620.bellabeat.daily_steps`
group by day_of_week;

# calories by day of week 
SELECT 
  FORMAT_DATE('%A', DATE(ActivityDay)) AS day_of_week,
  SUM(Calories) as sum_of_calories,
  AVG(Calories) as avg_of_calories
FROM `bellabeat-case-study-375620.bellabeat.daily_calories`
group by day_of_week;

# all activity levels by day 
SELECT 
  FORMAT_DATE('%A', DATE(ActivityDate)) AS day_of_week,
  VeryActiveMinutes,
  FairlyActiveMinutes,
  LightlyActiveMinutes,
  SedentaryMinutes
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
order by day_of_week ;

#CTE table with activity on weekends 
with weekend as (  
  SELECT
  FORMAT_DATE('%A', DATE(ActivityDate)) AS day_of_week,
  VeryActiveMinutes,
  FairlyActiveMinutes,
  LightlyActiveMinutes,
  SedentaryMinutes
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
)
SELECT * FROM weekend
where (day_of_week = 'Saturday' or day_of_week = 'Sunday');

#CTE table with activity on weekdays
with weekday as (  
  SELECT
  FORMAT_DATE('%A', DATE(ActivityDate)) AS day_of_week,
  VeryActiveMinutes,
  FairlyActiveMinutes,
  LightlyActiveMinutes,
  SedentaryMinutes
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
)
SELECT * FROM weekday
where (day_of_week = 'Monday' or 
      day_of_week = 'Tuesday' or
      day_of_week = 'Wednesday' or
      day_of_week = 'Thursday' or
      day_of_week = 'Friday');

# --------------------------------------------------------------------------------------
# activity, steps, calories by time of day


#intensity by time of day 
SELECT 
  ActivityHour,
  SUM(AverageIntensity) as sum_avg_intensity,
  SUM(TotalIntensity) as sum_total_intensity,
  AVG(TotalIntensity) as avg_total_intensity
FROM `bellabeat-case-study-375620.bellabeat.hourly_intensities`
group by ActivityHour;

#steps by time of day 
SELECT 
  ActivityHour,
  AVG(StepTotal) as avg_step_total,
  SUM(StepTotal) as sum_step_total
FROM `bellabeat-case-study-375620.bellabeat.hourly_steps`
group by ActivityHour;

#calories burnt by time of day 
SELECT 
  ActivityHour,
  AVG(Calories) as avg_calories,
  SUM(Calories) as sum_calories
FROM `bellabeat-case-study-375620.bellabeat.hourly_calories`
group by ActivityHour;

# --------------------------------------------------------------------------------------
# activity, steps vs calories

#calories burnt vs daily intensities (not usable)
SELECT 
  #id,
  sum(Calories) as calories_burnt,
  sum(VeryActiveMinutes/60) as very_active_min, 
  sum(FairlyActiveMinutes/60) as fairly_active_min,
  sum(LightlyActiveMinutes/60) as lightly_active_min,
  sum(SedentaryMinutes/60) as sednetary_min,
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`
#group by id
order by calories_burnt DESC;

# steps vs calories burnt (easy version, from one dataset)
SELECT
  id,
  ActivityDate,
  TotalSteps,
  Calories
FROM `bellabeat-case-study-375620.bellabeat.daily_activity`;

# steps vs calories burnt daily (join two data sets, same as above)

SELECT 
  steps.id,
  steps.ActivityDay,
  steps.StepTotal,
  calories_burnt.Calories
FROM `bellabeat-case-study-375620.bellabeat.daily_steps` as steps
JOIN `bellabeat-case-study-375620.bellabeat.daily_calories` as calories_burnt
on steps.id = calories_burnt.id AND steps.ActivityDay = calories_burnt.ActivityDay
group by 
  steps.id,
  steps.ActivityDay,
  steps.StepTotal,
  calories_burnt.Calories;

#steps vs calories burnt hourly (not going to do hourly steps vs calories)

SELECT 
  steps.id,
  steps.ActivityDate,
  sum(steps.StepTotal) as total_steps,
  sum(calories_burnt.Calories) as total_calories_burnt
FROM `bellabeat-case-study-375620.bellabeat.hourly_steps` as steps
JOIN `bellabeat-case-study-375620.bellabeat.hourly_calories` as calories_burnt
on steps.id = calories_burnt.id and steps.ActivityDate = calories_burnt.ActivityDate
group by 
  steps.id,
  steps.ActivityDate;
  #steps.StepTotal,
  #calories_burnt.Calories;



# intensity vs calories
SELECT  
  activity.id,
  activity.ActivityDay,
  SedentaryMinutes, 
  LightlyActiveMinutes, 
  FairlyActiveMinutes, 
  VeryActiveMinutes,
  Calories
FROM `bellabeat-case-study-375620.bellabeat.daily_intensities` as activity
JOIN `bellabeat-case-study-375620.bellabeat.daily_calories` as calories_burnt
  on activity.id = calories_burnt.id AND activity.ActivityDay = calories_burnt.ActivityDay
group by 
  activity.id,
  activity.ActivityDay,
  SedentaryMinutes, 
  LightlyActiveMinutes, 
  FairlyActiveMinutes, 
  VeryActiveMinutes,
  Calories;




# --------------------------------------------------------------------------------------
# activity, steps, and calories vs sleep

#activities affect on sleep (average by user, not rounded)
SELECT 
  activity.id, 
  AVG(TotalMinutesAsleep) as avg_min_asleep, 
  AVG(TotalTimeInBed) as avg_time_in_bed, 
  AVG(StepTotal) as avg_step_total,
  AVG(SedentaryMinutes) as sedentary_active,
  AVG(LightlyActiveMinutes) as light_activity,
  AVG(FairlyActiveMinutes) as fairly_active,
  AVG(VeryActiveMinutes) as vey_active,
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` as sleep
JOIN `bellabeat-case-study-375620.bellabeat.daily_steps` as activity
on activity.id = sleep.id 
JOIN `bellabeat-case-study-375620.bellabeat.daily_intensities` as intensity
on activity.id = intensity.id
group by activity.id;


# CTE intensities, steps, sleep averages by user 
WITH avg_activity_vs_sleep as (
  SELECT 
    sleep.Id, 
    AVG(TotalMinutesAsleep) as avg_min_asleep, 
    AVG(TotalTimeInBed) as avg_time_in_bed,
    AVG(TotalTimeInBed) - AVG(TotalMinutesAsleep) as avg_time_to_fall_alseep, 
    AVG(StepTotal) as avg_step_total,
    AVG(SedentaryMinutes) as avg_sedentary_active,
    AVG(LightlyActiveMinutes) as avg_light_activity,
    AVG(FairlyActiveMinutes) as avg_fairly_active,
    AVG(VeryActiveMinutes) as avg_very_active,
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` as sleep
JOIN `bellabeat-case-study-375620.bellabeat.daily_steps` as steps
on sleep.id = steps.id 
JOIN `bellabeat-case-study-375620.bellabeat.daily_intensities` as intensity
on sleep.Id = intensity.id
group by sleep.id
)
SELECT 
  id, 
  ROUND(avg_min_asleep, 2) as avg_min_alseep,
  ROUND(avg_time_in_bed, 2) as avg_min_in_bed,
  ROUND(avg_time_to_fall_alseep, 2) as avg_time_to_fall_alseep,
  ROUND(avg_step_total) as avg_step_total,
  ROUND(avg_sedentary_active) as avg_sedentary_active_minutes,
  ROUND(avg_light_activity) as avg_lightly_active_minutes,
  ROUND(avg_fairly_active) as avg_fairly_active_minutes,
  ROUND(avg_very_active) as avg_very_active_minutes,
FROM avg_activity_vs_sleep
GROUP BY 
  id,
  avg_activity_vs_sleep.avg_min_asleep,
  avg_activity_vs_sleep.avg_time_in_bed,
  avg_activity_vs_sleep.avg_time_to_fall_alseep,
  avg_activity_vs_sleep.avg_step_total,
  avg_activity_vs_sleep.avg_sedentary_active,
  avg_activity_vs_sleep.avg_light_activity,
  avg_activity_vs_sleep.avg_fairly_active,
  avg_activity_vs_sleep.avg_very_active;


# time to fall asleep (all)
SELECT 
  id,
  SleepDay, 
  TotalMinutesAsleep as min_alseep, 
  TotalTimeInBed as min_in_bed,
  TotalTimeInBed - TotalMinutesAsleep as time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` 
group by 
  SleepDay,
  id,
  TotalMinutesAsleep,
  TotalTimeInBed;

#time to fall asleep by day of week
SELECT 
  id,
  FORMAT_DATE('%A', DATE(SleepDay)) AS Day, 
  TotalMinutesAsleep as min_alseep, 
  TotalTimeInBed as min_in_bed,
  TotalTimeInBed - TotalMinutesAsleep as time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` 
group by 
  Day,
  id,
  TotalMinutesAsleep,
  TotalTimeInBed;

# Sum time to fall asleep (sum of users)
SELECT 
  id,
  SUM(TotalMinutesAsleep) as min_alseep, 
  SUM(TotalTimeInBed) as min_in_bed,
  SUM(TotalTimeInBed) - SUM(TotalMinutesAsleep) as time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` 
group by 
  id;

# average sleep, time in bed, and min to fall asleep (not rounded)
SELECT 
  id, 
  AVG(TotalMinutesAsleep) as avg_min_alseep, 
  AVG(TotalTimeInBed) as avg_min_in_bed,
  AVG(TotalTimeInBed) - AVG(TotalMinutesAsleep) as avg_time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` 
group by id;

#  Rounded average sleep, time in bed, and min to fall asleep (per user)
WITH sleep_avg as (
  SELECT 
  id, 
  AVG(TotalMinutesAsleep) as avg_min_alseep, 
  AVG(TotalTimeInBed) as avg_min_in_bed,
  AVG(TotalTimeInBed) - AVG(TotalMinutesAsleep) as avg_time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` 
GROUP BY id
)
SELECT 
  id, 
  ROUND(sleep_avg.avg_min_alseep, 2) as avg_min_alseep,
  ROUND(avg_min_in_bed, 2) as avg_min_in_bed,
  ROUND(avg_time_to_fall_alseep, 2) as avg_time_to_fall_alseep
FROM sleep_avg
GROUP BY 
  id,
  sleep_avg.avg_min_alseep,
  sleep_avg.avg_min_in_bed,
  sleep_avg.avg_time_to_fall_alseep;


# time to fall asleep per day vs steps (all)
SELECT 
  sleep.id,
  SleepDay, 
  StepTotal,
  TotalMinutesAsleep, 
  TotalTimeInBed,
  TotalTimeInBed - TotalMinutesAsleep as time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` as sleep
JOIN `bellabeat-case-study-375620.bellabeat.daily_steps` as steps
  on sleep.Id = steps.id and sleep.SleepDay = steps.ActivityDay
group by 
  SleepDay,
  id,
  TotalMinutesAsleep,
  TotalTimeInBed,
  StepTotal;


# time to fall asleep per day vs daily intensities (all)
SELECT 
  sleep.id,
  SleepDay as Date, 
  LightlyActiveMinutes,
  FairlyActiveMinutes,
  VeryActiveMinutes,
  TotalMinutesAsleep, 
  TotalTimeInBed,
  TotalTimeInBed - TotalMinutesAsleep as time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` as sleep
JOIN `bellabeat-case-study-375620.bellabeat.daily_intensities` as activity
  on sleep.Id = activity.id and sleep.SleepDay = activity.ActivityDay
group by 
  SleepDay,
  id,
  TotalMinutesAsleep,
  TotalTimeInBed,
  LightlyActiveMinutes,
  FairlyActiveMinutes,
  VeryActiveMinutes;

# time to fall asleep per day vs calories (all)
SELECT 
  sleep.id,
  SleepDay, 
  Calories,
  TotalMinutesAsleep, 
  TotalTimeInBed,
  TotalTimeInBed - TotalMinutesAsleep as time_to_fall_alseep
FROM `bellabeat-case-study-375620.bellabeat.daily_sleep` as sleep
JOIN `bellabeat-case-study-375620.bellabeat.daily_calories` as calories_burnt
  on sleep.Id = calories_burnt.id and sleep.SleepDay = calories_burnt.ActivityDay
group by 
  SleepDay,
  id,
  TotalMinutesAsleep,
  TotalTimeInBed,
  Calories;




