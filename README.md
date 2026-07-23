# ⚡ NRGPoint — Weather-Based Energy Demand Analysis

End-to-end data analytics project using **SQL, Python, and Power BI** to analyze the relationship between weather patterns and energy demand, supporting better power procurement planning for a simulated Indian power distribution company (DISCOM).

---

## 📌 Business Problem
NRGPoint plans power procurement based on flat historical averages, without factoring in real-time weather patterns. This leads to costly overproduction or demand-supply shortfalls (load-shedding) during extreme weather — a common challenge across Indian DISCOMs, especially during summer heatwaves and winter cold snaps.

---

## 🔑 Key Findings
- 🌡️ Energy demand follows a **U-shaped curve** with temperature — both extreme cold and extreme heat drive demand up, not just heat alone
- ❄️ **Winter** shows the highest average demand (843 MWh), followed by **Summer** (758 MWh); Spring/Autumn are lowest (~532 MWh)
- 📉 Linear correlation between temperature and demand is weak (-0.24) — but this is misleading, since the true relationship is non-linear (proven via scatter plot + trend line)
- 🚨 89 days (6% of the dataset) crossed the 900 MWh "high-demand alert" threshold
- 🔍 A data quality artifact was identified and documented rather than silently ignored — a data-integrity practice worth highlighting

---

## 🧰 Tech Stack & What Each Tool Did

### 🗄️ SQL (SQL Server)
- Analyzed demand patterns using CASE-based temperature/humidity bucketing
- Used date functions (`DATEPART`, `FORMAT`) for weekday/weekend and monthly trend analysis
- Answered business questions using aggregations and conditional grouping
- 📂 See: `SQL/`

### 🐍 Python (Pandas, Matplotlib, Seaborn)
- Performed EDA and correlation analysis on weather variables vs. energy demand
- Proved the U-shaped relationship using scatter plots + quadratic trend fitting
- Built seasonal boxplots and a correlation heatmap
- 📂 See: `Python/`

### 📊 Power BI
- Built a **3-page interactive dashboard**: Executive, Operational, and Manager views
- Added high-demand alert cards, season/condition slicers, and a season-wise summary table
- 📂 See: `PowerBI/`

---

## 📁 Repository Structure
```
├── SQL/                  → Energy demand analysis queries
├── Python/                → EDA, correlation, and visualization notebook
├── PowerBI/                → Dashboard screenshots
├── Data/                  → Dataset used in analysis
├── Screenshots/            → Key SQL output evidence
└── Documentation/          → Full project documentation (BRD, FRD, recommendations)
```

---

## 🖥️ Dashboard Preview

**Executive Summary**
![Executive Summary](PowerBi/P1-Executive-Dashboard.png)

See `PowerBI/` folder for Operational Analysis and Manager Insights pages.

---

## ✅ Business Recommendations
1. Build a season-aware forecasting model (account for the U-shape, not linear averages)
2. Increase generation buffer capacity for Winter and Summer
3. Set up early-warning alerts for extreme temperature days
4. Prioritize weekday capacity slightly higher than weekends

---

## 👤 Author
Anmol Bhaskar
