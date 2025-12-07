# TA Analyst Project – Intern Applications Dashboard

## About This Project
This project showcases my skills in **data analysis, SQL, and Power BI dashboard development**.  
I analyzed intern application data for a fictional company to generate actionable insights for a recruitment team.  
It includes recruitment funnels, KPIs, and visual breakdowns by university, location, and gender.

The focus of the project is on:
- **Data preparation and cleaning** using PostgreSQL
- **Metric calculations** such as total applications, hires, offer acceptance rates, and average days to hire
- **Visual storytelling** with interactive Power BI dashboards, highlighting trends and recruitment funnels by location, university, and gender

This project demonstrates my ability to combine **technical skills** with **business understanding** to deliver meaningful insights.

## Files in the Repository
- `intern_applications.csv` – The used dataset which was generated with the help of ChatGPT.
- `intern_applications_full.sql` – SQL script to create and analyse the dataset
- `intern_applications_powerbi.sql` – SQL script where I refined my query to prepare the dataset for Power BI.
- `intern_applications.pbix` – Power BI dashboard file.
- `README.md` – This file.

## Project Overview
The project covers:
- Cleaning and preparing intern application data in PostgreSQL
- Calculating key metrics:
  - Total applications and hires
  - Offer acceptance rate
  - Average days to hire
- Creating stage-wise recruitment funnels (Applications → Phone Screen → Interview → Offer → Hired)
- Building interactive Power BI visuals:
  - Maps by location (Used a custom map of Portugal's Districts)
  - Recruitment funnel chart
  - KPI cards
  - Line and column charts for applications and average days to hire
  - Gender and university breakdowns

## How to Run / View
1. Load the `intern_applications.sql` script in PostgreSQL to create and prepare the dataset.
2. Open `intern_applications.pbix` in Power BI to explore the dashboard.
3. Optionally, import the CSV file `intern_applications.csv` directly into Power BI if you do not have a PostgreSQL setup.

## Key Insights / Features
- Monthly applications and hires
- Recruitment funnel showing candidate progression
- Average days to hire per month
- Interactive visuals with slicers for filtering by university, location, gender, and offer acceptance

## Dashboard Preview
![Dashboard Screenshot](images/dashboard.png)

## Notes
- Dataset is fictional; no sensitive data included.
- This project demonstrates SQL data preparation and Power BI dashboard building skills.









# Intern Applications Analysis Project

This repository contains SQL scripts and data preparation for an intern recruitment analysis project. The data and scripts were used to create a dashboard in Power BI for tracking applications, hires, and recruitment funnel metrics.

## Files

### SQL Files

1. **`intern_applications_full.sql`**
   - Contains the full SQL workflow:
     - Table creation
     - Data cleaning (fixing messy names)
     - Adding calculated columns (days to hire, application month, stage flags)
     - Queries for applications, hires, and offer acceptance metrics
   - Used to prepare and explore data.

2. **`intern_applications_powerbi.sql`**
   - Condensed query optimized for Power BI:
     - Combines multiple metrics into a single query
     - Provides data for visualizations such as applications by month, gender, location, university, and recruitment funnel stages
   - Used directly as a source in Power BI.

## Purpose

- The goal of this project is to demonstrate the use of SQL to clean, transform, and summarize recruitment data.
- The processed data can be visualized in Power BI for dashboards showing recruitment KPIs, time metrics, and breakdowns by location, university, and gender.

## Notes

- The data used is **non-sensitive and was generated with the help of chatgpt**.
- This repository is intended for learning, demonstration, and portfolio purposes.
