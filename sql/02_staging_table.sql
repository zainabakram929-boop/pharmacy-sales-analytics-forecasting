USE PharmacyAnalytics;
GO
DROP TABLE IF EXISTS dbo.stg_monthly_sales;
GO
CREATE TABLE dbo.stg_monthly_sales (
    Business_Partner_Branch VARCHAR(100), ChemistCode VARCHAR(50), ChemistName VARCHAR(255),
    Sales_Month DATE, Sale_Units FLOAT, Discount_PC FLOAT, Unique_Invoices FLOAT, Product_Variety FLOAT
);
GO
INSERT INTO dbo.stg_monthly_sales
SELECT r.Business_Partner_Branch, r.ChemistCode, r.ChemistName, v.Sales_Month,
       TRY_CAST(v.Sale_Units AS FLOAT),
       TRY_CAST(REPLACE(v.Discount_PC, '%', '') AS FLOAT),
       TRY_CAST(v.Unique_Invoices AS FLOAT),
       TRY_CAST(v.Product_Variety AS FLOAT)
FROM dbo.raw_pharmacy_sales r
CROSS APPLY (VALUES
 ('2025-07-01', Jul_2025_Sale_Units, Jul_2025_Discount_PC, Jul_2025_Unique_Invoices, Jul_2025_Product_Variety),
 ('2025-08-01', Aug_2025_Sale_Units, Aug_2025_Discount_PC, Aug_2025_Unique_Invoices, Aug_2025_Product_Variety),
 ('2025-09-01', Sep_2025_Sale_Units, Sep_2025_Discount_PC, Sep_2025_Unique_Invoices, Sep_2025_Product_Variety),
 ('2025-10-01', Oct_2025_Sale_Units, Oct_2025_Discount_PC, Oct_2025_Unique_Invoices, Oct_2025_Product_Variety),
 ('2025-11-01', Nov_2025_Sale_Units, Nov_2025_Discount_PC, Nov_2025_Unique_Invoices, Nov_2025_Product_Variety),
 ('2025-12-01', Dec_2025_Sale_Units, Dec_2025_Discount_PC, Dec_2025_Unique_Invoices, Dec_2025_Product_Variety),
 ('2026-01-01', Jan_2026_Sale_Units, Jan_2026_Discount_PC, Jan_2026_Unique_Invoices, Jan_2026_Product_Variety),
 ('2026-02-01', Feb_2026_Sale_Units, Feb_2026_Discount_PC, Feb_2026_Unique_Invoices, Feb_2026_Product_Variety),
 ('2026-03-01', Mar_2026_Sale_Units, Mar_2026_Discount_PC, Mar_2026_Unique_Invoices, Mar_2026_Product_Variety)
) v(Sales_Month, Sale_Units, Discount_PC, Unique_Invoices, Product_Variety);
GO
