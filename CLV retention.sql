SELECT
  DATE_TRUNC(subscription_start, WEEK(SUNDAY)) subscription_start_week,
  COUNT(user_pseudo_id) week_0,
  SUM(CASE
      WHEN subscription_end > DATE_ADD(DATE_TRUNC(subscription_start, WEEK(SUNDAY)), INTERVAL 1 WEEK) OR subscription_end IS NULL THEN 1
    ELSE
    0
  END
    ) week_1,
  SUM(CASE
      WHEN subscription_end > DATE_ADD(DATE_TRUNC(subscription_start, WEEK(SUNDAY)), INTERVAL 2 WEEK) OR subscription_end IS NULL THEN 1
    ELSE
    0
  END
    ) week_2,
  SUM(CASE
      WHEN subscription_end > DATE_ADD(DATE_TRUNC(subscription_start, WEEK(SUNDAY)), INTERVAL 3 WEEK) OR subscription_end IS NULL THEN 1
    ELSE
    0
  END
    ) week_3,
  SUM(CASE
      WHEN subscription_end > DATE_ADD(DATE_TRUNC(subscription_start, WEEK(SUNDAY)), INTERVAL 4 WEEK) OR subscription_end IS NULL THEN 1
    ELSE
    0
  END
    ) week_4,
  SUM(CASE
      WHEN subscription_end > DATE_ADD(DATE_TRUNC(subscription_start, WEEK(SUNDAY)), INTERVAL 5 WEEK) OR subscription_end IS NULL THEN 1
    ELSE
    0
  END
    ) week_5,
  SUM(CASE
      WHEN subscription_end > DATE_ADD(DATE_TRUNC(subscription_start, WEEK(SUNDAY)), INTERVAL 6 WEEK) OR subscription_end IS NULL THEN 1
    ELSE
    0
  END
    ) week_6
FROM
  `tc-da-1.turing_data_analytics.subscriptions`
GROUP BY
  1