-- Condensed query table for Power BI
WITH cleaned_data AS (
    SELECT
        candidate_id,
        application_date,
        stage,
        university,
        gender,
        offer_accepted,
        offer_acceptance_date,
        location,
		-- Cleaned numeric month and text month
        EXTRACT(MONTH FROM application_date) AS application_month_num,
        TRIM(TO_CHAR(application_date, 'Month')) AS application_month,
        -- Days to hire
        CASE WHEN offer_acceptance_date IS NOT NULL 
             THEN (offer_acceptance_date - application_date)
             ELSE NULL END AS days_to_hire,
        -- Stage flags
        CASE WHEN stage IN ('Phone Screen','Interview','Offer','Hired') THEN TRUE ELSE FALSE END AS stage_phone_screen,
        CASE WHEN stage IN ('Interview','Offer','Hired') THEN TRUE ELSE FALSE END AS stage_interview,
        CASE WHEN stage IN ('Offer','Hired') THEN TRUE ELSE FALSE END AS stage_offer,
        CASE WHEN stage = 'Hired' THEN TRUE ELSE FALSE END AS stage_hired,
        -- Offer accepted numeric
        CASE WHEN offer_accepted = 'Yes' THEN 1
             WHEN offer_accepted = 'No' THEN 0
             ELSE NULL END AS offer_accepted_metric
    FROM intern_applications
    -- Clean locations and universities
    WHERE location IS NOT NULL
)
SELECT 
    'Applications by Month' AS metric_name,
    COUNT(*) AS metric_value,
    'Month' AS category_type,
    application_month AS category_value,
    application_month_num AS sort_order
FROM cleaned_data
GROUP BY application_month, application_month_num

UNION ALL

SELECT
    'Average Days to Hire by Month' AS metric_name,
    CAST(AVG(days_to_hire) AS INT) AS metric_value,
    'Month' AS category_type,
    application_month AS category_value,
    application_month_num AS sort_order
FROM cleaned_data
WHERE days_to_hire IS NOT NULL
GROUP BY application_month, application_month_num

UNION ALL

SELECT
    'Applications by Gender' AS metric_name,
    COUNT(*) AS metric_value,
    'Gender' AS category_type,
    gender AS category_value,
    NULL AS sort_order
FROM cleaned_data
GROUP BY gender

UNION ALL

SELECT
    'Offer Acceptance by Gender (%)' AS metric_name,
    ROUND(AVG(offer_accepted_metric)*100, 2) AS metric_value,
    'Gender' AS category_type,
    gender AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE offer_accepted_metric IS NOT NULL
GROUP BY gender

UNION ALL

SELECT
    'Applications by Location' AS metric_name,
    COUNT(*) AS metric_value,
    'Location' AS category_type,
    location AS category_value,
    NULL AS sort_order
FROM cleaned_data
GROUP BY location

UNION ALL

SELECT
    'Hires by Location' AS metric_name,
    COUNT(*) AS metric_value,
    'Location' AS category_type,
    location AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE stage_hired = TRUE
GROUP BY location

UNION ALL

SELECT
    'Applications by University' AS metric_name,
    COUNT(*) AS metric_value,
    'University' AS category_type,
    university AS category_value,
    NULL AS sort_order
FROM cleaned_data
GROUP BY university

UNION ALL

SELECT
    'Hires by University' AS metric_name,
    COUNT(*) AS metric_value,
    'University' AS category_type,
    university AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE stage_hired = TRUE
GROUP BY university

UNION ALL

SELECT
    'Recruitment Funnel - Phone Screen' AS metric_name,
    COUNT(*) AS metric_value,
    'Stage' AS category_type,
    'Phone Screen' AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE stage_phone_screen = TRUE

UNION ALL

SELECT
    'Recruitment Funnel - Interview' AS metric_name,
    COUNT(*) AS metric_value,
    'Stage' AS category_type,
    'Interview' AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE stage_interview = TRUE

UNION ALL

SELECT
    'Recruitment Funnel - Offer' AS metric_name,
    COUNT(*) AS metric_value,
    'Stage' AS category_type,
    'Offer' AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE stage_offer = TRUE

UNION ALL

SELECT
    'Recruitment Funnel - Hired' AS metric_name,
    COUNT(*) AS metric_value,
    'Stage' AS category_type,
    'Hired' AS category_value,
    NULL AS sort_order
FROM cleaned_data
WHERE stage_hired = TRUE

ORDER BY category_type, sort_order, category_value;
