from pathlib import Path
import argparse
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression

REQUIRED_COLUMNS = [
    "Business_Partner_Branch","ChemistCode","ChemistName","Sales_Month",
    "Sale_Units","Discount_PC","Unique_Invoices","Product_Variety",
    "Product_Variety_Segment","Churn_Label","Risk_Level",
    "Recommended_Action","ID"
]

def load_data(path):
    df = pd.read_csv(path)
    missing = [c for c in REQUIRED_COLUMNS if c not in df.columns]
    if missing:
        raise ValueError(f"Missing required columns: {missing}")
    df["Sales_Month"] = pd.to_datetime(df["Sales_Month"], errors="coerce")
    df["Sale_Units"] = pd.to_numeric(df["Sale_Units"], errors="coerce")
    return df.dropna(subset=["Sales_Month", "ChemistCode", "Sale_Units"])

def forecast_sales(df, months_ahead=3):
    df = df.copy().sort_values(["ChemistCode", "Sales_Month"])
    periods = sorted(df["Sales_Month"].dt.to_period("M").unique())
    month_index = {period: i + 1 for i, period in enumerate(periods)}
    df["Month_Number"] = df["Sales_Month"].dt.to_period("M").map(month_index).astype(int)

    last_period = max(periods)
    future_periods = [last_period + i for i in range(1, months_ahead + 1)]
    future_numbers = [len(periods) + i for i in range(1, months_ahead + 1)]
    future_X = pd.DataFrame({"Month_Number": future_numbers})

    rows = []
    for chemist_code, group in df.groupby("ChemistCode"):
        group = group.dropna(subset=["Sale_Units"]).sort_values("Sales_Month")
        if len(group) < 2:
            continue

        model = LinearRegression()
        model.fit(group[["Month_Number"]], group["Sale_Units"])
        predictions = np.maximum(model.predict(future_X), 0)

        last_3_month_avg = float(group.tail(3)["Sale_Units"].mean())
        target_sales = round(last_3_month_avg * 1.10, 2)
        latest_observed_sales = round(float(group.iloc[-1]["Sale_Units"]), 2)

        for period, pred in zip(future_periods, predictions):
            pred = round(float(pred), 2)
            if pred == 0 and target_sales == 0:
                status = "No Activity"
            elif pred >= target_sales:
                status = "Overperforming"
            else:
                status = "Underperforming"

            rows.append({
                "Business_Partner_Branch": group.iloc[0]["Business_Partner_Branch"],
                "ChemistCode": chemist_code,
                "ChemistName": group.iloc[0]["ChemistName"],
                "Forecast_Month": period.to_timestamp(),
                "Predicted_Sale_Units": pred,
                "Target_Sales": target_sales,
                "Performance_Status": status,
                "Latest_Observed_Sales": latest_observed_sales
            })

    return pd.DataFrame(rows)

def main():
    parser = argparse.ArgumentParser(description="Forecast pharmacy sales by customer.")
    parser.add_argument("--input", default="data/sample/customer_risk_anonymized.csv")
    parser.add_argument("--output", default="data/output/forecast_sales_output.csv")
    parser.add_argument("--months", type=int, default=3)
    args = parser.parse_args()

    df = load_data(args.input)
    forecasts = forecast_sales(df, args.months)

    output = Path(args.output)
    output.parent.mkdir(parents=True, exist_ok=True)
    forecasts.to_csv(output, index=False)
    print(f"Saved {len(forecasts):,} forecast rows to {output}")

if __name__ == "__main__":
    main()
