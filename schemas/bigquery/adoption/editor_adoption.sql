-- editor_adoption (view)
-- Review: 27/02/2017
SELECT
  SUM(active_users) AS active_users,
  SUM(editor_users) AS editor_users,
  ROUND(SUM(editor_users)/SUM(active_users), 2) as P_editor_adoption
FROM
  [YOUR_PROJECT_ID:adoption.editor_adoption_per_day_per_ou]
WHERE
  _PARTITIONTIME >= DATE_ADD((SELECT MAX(date) FROM [YOUR_PROJECT_ID:adoption.adoption_30day]),-30,"DAY")