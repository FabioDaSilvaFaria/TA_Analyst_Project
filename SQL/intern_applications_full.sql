CREATE TABLE intern_applications ( -- create table
    candidate_id INT,
    application_date DATE,
    stage TEXT,
    university TEXT,
    gender TEXT,
    offer_accepted TEXT,
	offer_acceptance_date DATE,
    location TEXT
); 

------------------------------------------------------------------------------------------------
SELECT *
FROM intern_applications
ORDER BY candidate_id;

SELECT 
	DISTINCT location
FROM intern_applications;

UPDATE intern_applications -- Update the messy location names
SET location = CASE
    WHEN location = 'SantarÃ©m' THEN 'Santarém'
	WHEN location = 'Ã‰vora' THEN 'Évora'
    WHEN location = 'SetÃºbal' THEN 'Setúbal'
    ELSE location
END;

UPDATE intern_applications -- Update the messy university names
SET university = CASE
	WHEN university = 'Universidade de Ã‰vora' THEN 'Universidade de Évora'
    ELSE university
END;
------------------------------------------------------------------------------------------------
ALTER TABLE intern_applications -- Add days to hire column and calculation
ADD COLUMN days_to_hire INT;

UPDATE intern_applications
SET days_to_hire = (offer_acceptance_date - application_date)
WHERE offer_acceptance_date IS NOT NULL;

------------------------------------------------------------------------------------------------
ALTER TABLE intern_applications -- Add a column to extract the application month
ADD COLUMN application_month TEXT;

UPDATE intern_applications
SET application_month = TRIM(TO_CHAR(application_date, 'Month')); -- ensures no spaces after month name

ALTER TABLE intern_applications
ADD COLUMN application_month_num INT;

UPDATE intern_applications
SET application_month_num = EXTRACT(MONTH FROM application_date);

SELECT -- Look at number of applications per month
	application_month, 
	COUNT(*) AS num_applications 
FROM intern_applications
GROUP BY application_month, application_month_num
ORDER BY application_month_num;

------------------------------------------------------------------------------------------------
SELECT -- AVG days to hire by month
    application_month,
    COUNT(*) AS num_applications,
    CAST(AVG(days_to_hire) AS INT) AS avg_days_to_hire
FROM intern_applications
WHERE days_to_hire IS NOT NULL
GROUP BY application_month, application_month_num
ORDER BY application_month_num;

SELECT -- Total AVG days to hire
	CAST(AVG(days_to_hire) AS INT) AS avg_days_to_hire 
FROM intern_applications
WHERE days_to_hire IS NOT NULL;

------------------------------------------------------------------------------------------------
ALTER TABLE intern_applications -- look at the funnels for each stage of the recruitment process
ADD COLUMN stage_phone_screen BOOLEAN,
ADD COLUMN stage_interview BOOLEAN,
ADD COLUMN stage_offer BOOLEAN,
ADD COLUMN stage_hired BOOLEAN;

UPDATE intern_applications
SET 
    stage_phone_screen = CASE WHEN stage IN ('Phone Screen','Interview','Offer','Hired') THEN TRUE ELSE FALSE END,
    stage_interview = CASE WHEN stage IN ('Interview','Offer','Hired') THEN TRUE ELSE FALSE END,
    stage_offer = CASE WHEN stage IN ('Offer','Hired') THEN TRUE ELSE FALSE END,
    stage_hired = CASE WHEN stage = 'Hired' THEN TRUE ELSE FALSE END;

SELECT -- Calculate the number of candidate by each stage
    COUNT(*) FILTER (WHERE stage_phone_screen) AS num_phone_screen,
    COUNT(*) FILTER (WHERE stage_interview) AS num_interview,
    COUNT(*) FILTER (WHERE stage_offer) AS num_offer,
    COUNT(*) FILTER (WHERE stage_hired) AS num_hires,
    ROUND(100.0 * COUNT(*) FILTER (WHERE stage_hired) / COUNT(*), 2) AS overall_hire_rate
FROM intern_applications;

------------------------------------------------------------------------------------------------
ALTER TABLE intern_applications -- Create a new column to be used as a metric to calculate the offer acceptance rate
ADD COLUMN offer_accepted_metric INT;

UPDATE intern_applications
SET offer_accepted_metric = CASE 
	WHEN offer_accepted = 'Yes' THEN 1
	WHEN offer_accepted = 'No' THEN 0
	ELSE NULL
END;

SELECT -- Calculate the offer acceptance percentage 
	ROUND(AVG(offer_accepted_metric) * 100, 2) AS offer_acceptance_percentage
FROM intern_applications
WHERE offer_accepted_metric IS NOT NULL;

SELECT * -- Looks at cases where offer was accepted by candidate has not been moved to hired stage (should be flagged and questioned)
FROM intern_applications
WHERE offer_accepted = 'Yes' AND stage_hired = FALSE;

------------------------------------------------------------------------------------------------
SELECT -- Applications by university
	university,
	COUNT(*) AS num_applications
FROM intern_applications
GROUP BY university
ORDER BY num_applications DESC;

SELECT -- Hires per university
	university,
	COUNT(*) AS num_hires
FROM intern_applications
WHERE stage_hired = TRUE
GROUP BY university
ORDER BY num_hires DESC;

------------------------------------------------------------------------------------------------
SELECT -- Applications by location
	location,
	COUNT(*) AS num_applications
FROM intern_applications
GROUP BY location
ORDER BY num_applications DESC;

SELECT -- Hires by location
	location,
	COUNT(*) AS num_hires
FROM intern_applications
WHERE stage_hired = TRUE
GROUP BY location
ORDER BY num_hires DESC;

------------------------------------------------------------------------------------------------
SELECT -- Application & Offer acceptance split by gender
    gender,
    COUNT(*) AS num_applications,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total_applications,
    COUNT(*) FILTER (WHERE offer_accepted IS NOT NULL) AS total_offers,
    COUNT(*) FILTER (WHERE offer_accepted = 'Yes') AS offer_accepted,
    COUNT(*) FILTER (WHERE offer_accepted = 'No') AS offer_rejected,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE offer_accepted = 'Yes') / 
        NULLIF(COUNT(*) FILTER (WHERE offer_accepted IS NOT NULL), 0),
        2
    ) AS pct_offer_accepted
FROM intern_applications
GROUP BY gender
ORDER BY gender;

------------------------------------------------------------------------------------------------

