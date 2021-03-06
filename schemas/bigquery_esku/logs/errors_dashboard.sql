-- errors_dashboard (view)

SELECT
  *
FROM (
  SELECT
    'missing_data_level1' AS error_type,
    MIN(report_date) AS min_date
  FROM
    [YOUR_PROJECT_ID:raw_data.missing_data_level1]
  WHERE
    report_date > DATE(DATE_ADD(DATE(CURRENT_TIMESTAMP()),-DAYS_LOOKBACK,"DAY"))),
  (
  SELECT
    'missing_data_level2' AS error_type,
    MIN(report_date) AS min_date
  FROM
    [YOUR_PROJECT_ID:raw_data.missing_data_level2]
  WHERE
    report_date > DATE(DATE_ADD(DATE(CURRENT_TIMESTAMP()),-DAYS_LOOKBACK,"DAY"))),
  (
  SELECT
    'missing_data_level4' AS error_type,
    MIN(report_date) AS min_date
  FROM
    [YOUR_PROJECT_ID:raw_data.missing_data_level4]
  WHERE
    report_date > DATE(DATE_ADD(DATE(CURRENT_TIMESTAMP()),-DAYS_LOOKBACK,"DAY"))),
  (
  SELECT
    'missing_data_level6' AS error_type,
    MIN(report_date) AS min_date
  FROM
    [YOUR_PROJECT_ID:raw_data.missing_data_level6]
  WHERE
    report_date > DATE(DATE_ADD(DATE(CURRENT_TIMESTAMP()),-DAYS_LOOKBACK,"DAY"))),
  (
  SELECT
    'api_error' AS error_type,
    MIN(daily_status.report_date) AS min_date
  FROM (
        SELECT * FROM (
          SELECT
            report_date,
            FIRST_VALUE(status) OVER (PARTITION BY report_date ORDER BY start_time DESC) AS status
          FROM
            [YOUR_PROJECT_ID:logs.daily_status]
          WHERE
            report_date > DATE(DATE_ADD(DATE(CURRENT_TIMESTAMP()),-DAYS_LOOKBACK,"DAY")) )
        WHERE
          status = 'ERROR'
        GROUP BY
          1,
          2
        ORDER BY
          1 DESC
        ) daily_status
  )