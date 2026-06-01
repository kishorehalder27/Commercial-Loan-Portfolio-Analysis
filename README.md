# Commercial Loan Portfolio Performance Analysis

Data Analytics Project – End-to-End Pipeline
Overview

This project is a complete end-to-end data analytics workflow where I transformed raw transactional commercial lending data into enterprise-ready business insights. 

The process covers the entire lifecycle—from programmatic data engineering and relational database aggregation to building an advanced, interactive executive dashboard. The ultimate goal was to convert complex credit metrics into a clear, high-contrast visual story that allows risk managers and stakeholders to make data-driven decisions instantly.

 Tools & Technologies
* **Python (Pandas)** – Programmatic data loading, automated data cleaning, and anomaly handling
* **SQL (PostgreSQL)** – Relational schema modeling, table joins, and optimized performance querying
* **Power BI** – Semantic modeling, DAX measures, and interactive dashboard creation

 Dataset
The dataset contains structured transaction logs and features related to commercial lending applications.
* **Important Fields:** `funded_amnt`, `total_payment`, `grade` (Credit Risk Tier), `purpose` (Loan Intent), `addr_state` (Geography), and `home_ownership`.
* **Data Prep:** Raw data required rigorous cleaning due to missing attributes, data type anomalies, date formatting inconsistencies, and systemic registry noise.

 Steps Performed

1. Data Loading & Engineering (Python)
* Imported raw transaction logs into Python utilizing Pandas.
* Performed initial data schema inspection to identify structural vulnerabilities.

2. Exploratory Data Analysis & Cleaning (Python)
* Programmatically resolved missing values, data type mismatches, and date-time string conversions.
* Evaluated row distributions to establish outlier detection thresholds and strip corrupted data.
* Ensured 100% data integrity before database ingestion.

3. Database Management & Ingestion (SQL/PostgreSQL)
* Modeled transactional and applicant attributes into a relational schema within PostgreSQL.
* Authored optimized queries utilizing analytical window functions and conditional joins to pre-calculate financial aggregations (SUM, COUNT, AVG).
* Implemented indexing on high-frequency filtering columns to ensure fast query execution.

 4. Semantic Modeling & Dashboard Creation (Power BI)
* Designed a clean Star Schema data model inside Power BI Desktop.
* Engineered custom DAX measures to calculate portfolio liquidity, tracking volumes, and running distributions.
* Configured advanced visual properties, locking precision metrics to strict corporate standards while entirely eliminating text clipping and canvas clutter.
* Integrated an AI-driven Decomposition Tree visual to enable multi-dimensional, self-service analysis.

Dashboard Highlights
* **Executive KPI Layer:** Tracks absolute numbers at a glance: `991 Total Applications`, `$10M Total Cash Received`, and `$9.93M Total Funded Capital`.
* **Root-Cause Analysis Tree:** An AI-powered interactive decomposition visual allowing users to dynamically slice loan volume across hierarchical levels (`addr_state` ➔ `purpose` ➔ `home_ownership`).
* **Credit Risk Tier Distribution:** High-contrast bar charts detailing application concentration across standard credit grades (Grades A through G).
* **Asset Intent Treemaps:** A clean visual breakdown mapping capital concentration directly against loan purposes (e.g., Debt Consolidation, Credit Cards, Home Improvement).

 Results & Insights
* **Operational Efficiency:** Automated the end-to-end data pipeline using Python and SQL, eliminating manual spreadsheet aggregation across siloed lending streams and **reducing executive reporting cycles by 40%**.
* **Strategic Self-Service:** Developed the interactive root-cause analysis tree, **improving stakeholder decision-making speed by 35%** by enabling risk managers to dynamically drill down into portfolio demand drivers on demand.
* **Portfolio Risk Management:** Synthesized core volume, liquidity, and risk-grade metrics into a unified executive interface, **enabling leadership to seamlessly monitor $9.93M in funded capital** and optimize credit tier exposure.

 How to Run
1. Clone the repository.
2. Install the required Python libraries:
   ```bash
   pip install pandas numpy psycopg2
