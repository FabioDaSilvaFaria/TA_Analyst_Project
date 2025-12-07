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
