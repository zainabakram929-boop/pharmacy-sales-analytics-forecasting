# Pharmacy Sales Analytics & Forecasting

An end-to-end internship project using **SQL, Python, machine learning, and Power BI** to transform pharmacy sales data, identify customer churn risk, recommend follow-up actions, and forecast future sales.

## Workflow

`Raw monthly sales → SQL staging → risk segmentation → Python forecasting → Power BI dashboards`

## What the project does

### SQL analytics
The SQL pipeline:
- converts wide monthly sales columns into a monthly staging table
- segments customers by product variety
- labels customers as `Active`, `At Risk`, or `Churned`
- assigns `Low`, `Medium`, or `High Risk`
- produces a recommended business action for each customer

### Sales forecasting
The Python model:
- trains a separate **Linear Regression** for each customer
- forecasts the next three months automatically from the latest historical month
- clips negative predictions to zero
- calculates a target as **110% of the latest 3-month average**
- classifies each forecast as `Overperforming`, `Underperforming`, or `No Activity`

### Power BI
The internship deliverables also included:
- Customer Churn / Risk Dashboard
- Pharmacy Sales Forecast Dashboard

The original `.pbix` files are **not included in this public portfolio repository** because they may embed proprietary source data. Sanitized dashboard screenshots can be added under `assets/`.

## Repository structure

```text
pharmacy-sales-analytics-forecasting/
├── data/
│   ├── sample/customer_risk_anonymized.csv
│   └── output/forecast_sales_output.csv
├── sql/
│   ├── 01_raw_table.sql
│   ├── 02_staging_table.sql
│   └── 03_customer_risk.sql
├── src/
│   └── sales_forecasting.py
├── assets/
├── requirements.txt
├── .gitignore
└── README.md
```

## Run locally

```bash
python -m venv venv
venv\Scripts\activate.bat
pip install -r requirements.txt
python src/sales_forecasting.py
```

The generated output is saved to:

```text
data/output/forecast_sales_output.csv
```

## Data privacy

The original internship files contain identifiable pharmacy/customer information. This public version replaces customer codes and names with synthetic identifiers while retaining the numerical features and analytical structure needed to demonstrate the workflow.

## Tech stack

**SQL Server / T-SQL · Python · Pandas · NumPy · scikit-learn · Linear Regression · Power BI**

## Skills demonstrated

Data cleaning · SQL transformation · feature engineering · customer segmentation · churn-risk analysis · forecasting · Power BI · end-to-end analytics

## Limitations

The forecasting model captures a simple linear trend and does not model seasonality or external business factors. It is an interpretable internship prototype rather than a production forecasting system. A future version could compare ARIMA, Prophet, gradient boosting, or other time-series/regression approaches using longer history and additional features.

## Portfolio note

This is a sanitized portfolio version of an internship project. Proprietary source files and identifiable customer data are intentionally excluded.
