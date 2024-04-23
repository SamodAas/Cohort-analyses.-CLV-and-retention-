# getting the first customer visit
WITH
  FirstVisit AS(
  SELECT
    DISTINCT(user_pseudo_id) user_id,
    MIN(DATE_TRUNC(PARSE_DATE('%Y%m%d',event_date), WEEK(SUNDAY))) first_visit
  FROM
    `tc-da-1.turing_data_analytics.raw_events`
  WHERE
    DATE_TRUNC(PARSE_DATE('%Y%m%d',event_date), WEEK(SUNDAY)) < '2021-01-31'
  GROUP BY
    1 ),

# counting all customer purchases
Purchases AS (
  SELECT
    user_pseudo_id,
    purchase_revenue_in_usd,
    DATE_TRUNC(PARSE_DATE('%Y%m%d',event_date), WEEK(SUNDAY)) event_date
  FROM
    `turing_data_analytics.raw_events`
  WHERE
    event_name = "purchase"
    AND purchase_revenue_in_usd > 0
    AND DATE_TRUNC(PARSE_DATE('%Y%m%d',event_date), WEEK(SUNDAY)) < "2021-01-31"
)

# applying cohorts
SELECT
  fv.first_visit cohort,
  COUNT(fv.user_id) user_registration_count,
  SUM(CASE
        WHEN p.event_date <= fv.first_visit THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week0,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 1 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week1,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 2 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week2,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 3 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week3,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 4 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week4,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 5 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week5,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 6 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week6,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 7 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week7,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 8 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week8,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 9 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week9,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 10 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week10,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 11 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week11,
  SUM(CASE
        WHEN p.event_date <= DATE_ADD(fv.first_visit,INTERVAL 12 WEEK) THEN p.purchase_revenue_in_usd
        ELSE 0
      END) Week12,
      
FROM
  FirstVisit fv
LEFT JOIN
  Purchases p
ON
  fv.user_id = p.user_pseudo_id
GROUP BY 
  cohort
ORDER BY 
  cohort

