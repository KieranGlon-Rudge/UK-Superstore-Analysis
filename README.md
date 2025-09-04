# UK Superstore Sales Analysis

## Project Overview
This project analyzes sales data from a UK superstore to uncover insights on sales trends, profitability, top-performing categories, customers, products, and shipping efficiency. The goal is to demonstrate some of my current data analysis skills, including data cleaning, querying, exploratory data analysis (EDA), and visualization.

Key insights include:
- Total sales: £528.6K
- Total profit: £111.9K
- Average profit margin: 21.2%
- Top category by profit: Technology
- Regional performance: England dominates with 99.28% of total profit

## Skills Demonstrated
- **SQL (T-SQL in SSMS)**: Data cleaning, querying, and basic EDA (e.g., aggregations for sales/profit by category, shipping efficiency).
- **Power BI**: Interactive dashboards for performance overview, analysis, and reporting.
- **Tools Used**: SSMS for SQL, Power BI for visualization.
- **Data Handling**: Imported and cleaned `superstore.csv` to focus on UK data, adding columns like `Days_To_Ship`, `Month`, and `Avg_Daily_Profit`.

## Repository Structure
- **data/**: 
  - `superstore.csv`: Original dataset.
  - `Superstore_UK.txt`: Cleaned UK-focused dataset (Imported from SSMS).
- **sql/**: 
  - `Superstore_UK Sales Analysis Project.sql`: SQL script for cleaning, queries, and EDA.
- **visualizations/**: 
  - Screenshots of Power BI dashboards (Overview, Analysis, Report pages).
  - `UK Superstore Performance.pbix`: Power BI Dashboard with 3 interactive pages.
- **README.md**: This file.

## Data Source
- Original: `superstore.csv` (global superstore sales data).
- Cleaned: Filtered to UK only, removed irrelevant columns (e.g., Market, Region), handled data types, added derived columns, checked for duplicates/NULLs, and trimmed strings.

## Methodology
1. **Data Cleaning (SQL in SSMS)**:
   - Filtered to UK data.
   - Dropped unnecessary columns.
   - Converted data types (e.g., dates, floats).
   - Added columns: `Days_To_Ship` (using DATEDIFF), `Month` (using DATENAME), `Avg_Daily_Profit` (subquery average).
   - Checked and handled duplicates/NULLs dynamically.
   - Standardized strings with LTRIM/RTRIM.

2. **EDA Queries (SQL)**:
   - Total sales/profit by category.
   - Top 10 customers by profit.
   - Sales trends by year.
   - Shipping efficiency by mode.
   - Profit margin by sub-category.

3. **Visualization (Power BI)**:
   - Connected to cleaned data.
   - Created 3 interactive pages:
     - **Overview**: KPIs (sales, profit, units sold), profit trends, country/map visuals.
     - **Analysis**: Profit breakdowns by city/sub-category, trends, MoM changes.
     - **Report**: Transaction-level table, filters for year/month/country/category.
   - Created Visualy appealing and colour blind accesabled dashboard vs my previous dashboard which was about functionality only as I learnt the basics of dashboarding.

## Results and Insights
- **Profit Trends**: Technology leads with Profit of £49,476.10 and a profit margin of 22.8%.
- **Geographic**: London tops cities with £15.6K profit and a profit margin of 19.3%.
- **Efficiency**: Average shipping days vary by mode; opportunities to optimize for high-profit items.
- Full details in SQL queries and dashboards.

## How to Run
1. Import `Superstore_UK.csv` into SSMS.
2. Run `superstore_uk_analysis.sql` for cleaning and queries.
3. Open Power BI dashboards (screenshots provided; contact for `.pbix`).
4. Optional: Use Python (pandas/seaborn) or R in Jupyter for further analysis—notebook coming soon!

## Future Improvements
- Add Jupyter notebook for Python-based EDA (e.g., correlation analysis, visualizations).
- Predictive modeling (e.g., sales forecasting using R).
- Create field parameters for the KPI Cards to affect the graphics and button field paramters for the drill downs
- Make the dashboard more storage efficient by removing summarizations and creating mesaures with the aggregations where needed
- Clean the dashboard for publishing looks e.g. remove tooltips however due to free Power BI am unable to Publish and can't see what things need to be cleaned up

License: MIT
