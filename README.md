# Nigerian States IGR Analysis 2023

    End-to-end Data Analysis Project- MySQL Data Warehouse + Power BI Dashboard
    Data Source: Jiont Tax Board(JTB) Full Year 2023 Sub-National Internally Generated Revenue

## 📊Project Overview

This project analyzes the Internally Generated Revenue (IGR) of all 36 states including the FCT for the fiscal year 2023. The data was extracted from the official Joint Tax Board (JTB) report and loaded into a MySQL data warehouse, then visualized in Power BI to uncoverfiscal performance, patterns, regional disparities, and revenue diversification insights.

## Tech Stack

| Layer | Tool |
| ------- | ------ |
| | |
| Database | MySQL 8.0 |
| ETL / Data Prep | MySQL + Power BI |
| Visualization | Power BI Desktop |
| Data Model | Star Schema (Wide Fact Table) |
| Analysis | DAX (Data Analysis Expressions) |
| Version Control | Git +GitHub |

---

### Key Metrics Tracked

 • PAYE(Pay As You Earn)

 • Direct Assesments

 • Road Tax

 • Stamp Duties

 • Capital Gains Tax

 • Withholding Tax

 • Other Taxes

 • LGA Revenue

 • MDAs Revenue

• Total Revenue

## 🗄️Data Architecture

Database: [igr_analytics](igr_analysis.sql) (MySQL)

| Table/View | Description | Rows |
| ------------ | ------------- | ------ |
| | | |
| dim_state | State dimension with geo-political zones | 37 |
| dim_date | Date dimension (FY 2023) | 1 |
| fact_igr | Wide fact table- One row per state with all revenue columns | 37 |
| vw_state_revenue_summary | All states ranked by total revenue | 37 |
| vw_regional_summary | Aggregation by 6 seo-political zones | 6 |
| vw_tax_type_national | National totals by revenue type | 6 |
| vw_top_10_states | Top 10 states with %of national total | 10 |
| vw_revenue_composition | Percentage breakdown by tax type per state | 37 |

### Schema: Wide Fact Table (Star Schema)

    dim_state ‾‾‾|
                  → fact_igr ← dim_date
    dim_state ___|

 • No Foreign key constraints- Relationships managed in Power BI Model view

 • One row per state- Simplifies DAX and eliminates join complexity

## Questions Asked

1. Which states are over-reliant on PAYE, and what is their fiscal exposure?

2. Are MDAs revenue masking poor tax collectin performance?

3. Which geo-political zones are punching above or below their weight?

4. What is the gap between a state and its regional peers?

## 📈Key Insights

### 1. **Lagos Dominates National IGR**

  • Lagos generated ₦815.9 billion— 33.6% of the entire national IGR (₦2.43 trillion).
  
  • The gap between #1 (Lagos) and #2 (FCT at ₦211B) exceeds the combined revenue of states ranked #3 through #10.
  
### 2. **The "Top 5" Control 61% of National Revenue**

Lagos. FCT, Rivers, Ogun and Delta collectively account for approximately ₦1.48 trillion, meaning 5 out of 37 entities control the majority of sub-national revenue.

### 3. **Massive Reginal Fiscal Inequality**

 • Suoth-West is dominated by Lagos (₦815.9B); without Lagos, the zone average drops significantly.

 • South-South relies heavily on Rivers(₦195B) and Delta(₦114,1B).

 • North-East is the weakest zone collectively. Borno (₦19.5B) leads but insurgency impact is visible.

 • Taraba at ₦10.9B is 75x smaller than Lagos.

### 4. **MDAs Revenue Masks Weak Tax Collections In Some States**

 •Ogun State: MDAs revenue (₦75.2B) exceeds total taxa revenue (₦71.7B).

 • Delta: MDAs contribute ₦23.2B (20% of total); significant non-tax dependency.

 • FCT: Zero MDAs revenue− completely tax-dependant.

 • Lagos: MDAs contribute ₦111B but tax base remains massive and sustainable.

### 5. **PAYE is the Backbone But Creates Concentration Risk**

 • PAYE alone accounts for ₦1.24 trillion nationally; over 50% of total IGR.

 • Rivers (73.19%), Bayelsa(70.95%) and Gombe(61.94%) are heavily reliant on salary earners.

 • Economic downturns or public sector reforms could devastate these states' budget.

### 6. **Wide Gap Between Regional Peers**

 • North-Central: FCT(₦211B) vs Niger(₦21.7B)–10x gap in the same zone.

 • South-West: Lagos(₦815.9B) vs Ekiti(₦32.1B)–25x gap

 • South-East: Relatively competitve–Anambra(₦33.5B) vs Ebonyi(₦30.8).

### Q1: Which states are over-reliant on PAYE, and what is their fiscal risk exposure?

 Approach: Calculate PAYE as % of total revenue per state.

 Finding: Rivers (73%), FCT (61.6%), Enugu (59.2%), and Lagos (54.5%) are highly exposed to salary-earner volatility.

Recommendation: These states should aggressively expand Direct Assessment and Road Tax collection.

### Q2: Are MDAs revenues masking poor tax collection performance?

 Approach: Compare Total Tax vs MDAs Revenue per state.

Finding: Ogun's MDAs (₦75.2B) exceed its tax revenue (₦71.7B). Delta's MDAs are 20% of total.

 Recommendation: Audit whether MDAs revenue is sustainable (recurring fees) or one-off (asset sales).

### Q3: Which geo-political zones are punching above or below their weight?

 Approach: Aggregate IGR by region and compare average revenue per state.

 Finding: South-West dominates due to Lagos. North-East and parts of North-West underperform relative to population size.

 Recommendation: Targeted tax administration support for underperforming zones, not just infrastructure.

### Q4: What is the revenue gap between a state and its regional peers?

 Approach: Rank states within each geo-political zone.

 Finding: Ekiti, Osun, and Niger should study the tax policies of their regional leaders (Ogun, Kwara, Oyo) rather than comparing themselves to Lagos.

 Recommendation: Peer-to-peer policy learning within zones is more actionable than national benchmarking.

## 🚀 How to Reproduce This Project

### Prerequisites

- MySQL Community Server
- MySQL Workbench
- Power BI Desktop
- MySQL Connector/ODBC 64-bit

### Step 1: Database Setup

    ```bash
    # Run the SQL script in MySQL Workbench
    mysql -u root -p < 05_igr_2023_complete.sql
    ```

### Step 2: Connect Power BI

1. Open Power BI Desktop
2. **Get Data** → **ODBC** → Select your MySQL DSN
3. Import: `dim_state`, `dim_date`, `fact_igr`, and all views
4. Create relationships: `fact_igr[state_id]` → `dim_state[state_id]`

### Step 3: Build Measures

    ```dax
    State Rank = RANKX(vw_state_revenue_summary, [total_revenue], , DESC, DENSE)

    Total Revenue = SUM(fact_igr[total_revenue])

    PAYE % = DIVIDE(SUM(fact_igr[paye]), SUM(fact_igr[total_revenue]), 0)
    ```

### Step 4: Create Visuals

- **Executive Summary:** KPI cards, treemap, donut chart
- **State Deep Dive:** Slicer + card + stacked bar
- **Regional Comparison:** Matrix + bar chart
- **Revenue Diversification:** Ribbon chart + dependency matrix

---

## 📁 Repository Structure

    ```
    nigerian-igr-analytics-2023/
    │
    ├── sql/
    │   └── 05_igr_2023_complete.sql      # Full database setup + data + views
    │
    ├── powerbi/
    │   ├── Nigerian_IGR_Analytics.pbix   # Power BI dashboard file
    │   └── DAX_Measures.txt              # Copy-paste DAX measures
    │
    ├── data/
    │   └── IGR_DATA_2019_2023.xlsx       # Source data from JTB
    │
    ├── docs/
    │   └── README.md                     # This file
    │
    └── .gitignore
    ```

---

## 📜 Data Source & Disclaimer

- **Source:** Joint Tax Board (JTB) Full Year 2023 Sub-National Internally Generated Revenue Report
- **Coverage:** 36 States + Federal Capital Territory (FCT)
- **Note:** Figures are as submitted by the Accountants General of the States from their audited financial statements and reconciled positions with the State Boards of Internal Revenue
- **Disclaimer:** This is an independent analytical project. All insights are derived from publicly available JTB data.

##

*Built with MySQL + Power BI.*

*Dataset: Joint Tax Board FY 2023.*

---

**⭐ If you found this useful, give it a star!**
