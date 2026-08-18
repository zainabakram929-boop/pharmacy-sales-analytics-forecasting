USE PharmacyAnalytics;
GO

DROP TABLE IF EXISTS dbo.final_customer_risk;
GO

SELECT
    Business_Partner_Branch,
    ChemistCode,
    ChemistName,
    Sales_Month,
    Sale_Units,
    Discount_PC,
    Unique_Invoices,
    Product_Variety,

    CASE
        WHEN Product_Variety >= 30 THEN 'High Variety'
        WHEN Product_Variety >= 10 THEN 'Medium Variety'
        ELSE 'Low Variety'
    END AS Product_Variety_Segment,

    CASE
        WHEN Sale_Units = 0 OR Unique_Invoices = 0 THEN 'Churned'
        WHEN Sale_Units < 50 OR Unique_Invoices < 5 THEN 'At Risk'
        ELSE 'Active'
    END AS Churn_Label,

    CASE
        WHEN Sale_Units = 0 OR Unique_Invoices = 0 THEN 'High Risk'
        WHEN Sale_Units < 50 OR Unique_Invoices < 5 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Level,

    CASE
        WHEN Sale_Units = 0 OR Unique_Invoices = 0
            THEN 'Immediate visit and retention offer needed'
        WHEN Sale_Units < 50 OR Unique_Invoices < 5
            THEN 'Monitor customer and improve product variety'
        ELSE 'Maintain regular follow-up'
    END AS Recommended_Action

INTO dbo.final_customer_risk
FROM dbo.stg_monthly_sales;
GO

SELECT TOP 20 * FROM dbo.final_customer_risk;
