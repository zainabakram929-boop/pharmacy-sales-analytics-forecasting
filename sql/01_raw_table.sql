-- SQL Server raw-table setup
IF DB_ID('PharmacyAnalytics') IS NULL CREATE DATABASE PharmacyAnalytics;
GO
USE PharmacyAnalytics;
GO
DROP TABLE IF EXISTS dbo.raw_pharmacy_sales;
GO
CREATE TABLE dbo.raw_pharmacy_sales (
    Business_Partner_Branch VARCHAR(100),
    ChemistCode VARCHAR(50),
    ChemistName VARCHAR(255),
    Jul_2025_Sale_Units VARCHAR(50), Jul_2025_Discount_PC VARCHAR(50), Jul_2025_Unique_Invoices VARCHAR(50), Jul_2025_Product_Variety VARCHAR(50),
    Aug_2025_Sale_Units VARCHAR(50), Aug_2025_Discount_PC VARCHAR(50), Aug_2025_Unique_Invoices VARCHAR(50), Aug_2025_Product_Variety VARCHAR(50),
    Sep_2025_Sale_Units VARCHAR(50), Sep_2025_Discount_PC VARCHAR(50), Sep_2025_Unique_Invoices VARCHAR(50), Sep_2025_Product_Variety VARCHAR(50),
    Oct_2025_Sale_Units VARCHAR(50), Oct_2025_Discount_PC VARCHAR(50), Oct_2025_Unique_Invoices VARCHAR(50), Oct_2025_Product_Variety VARCHAR(50),
    Nov_2025_Sale_Units VARCHAR(50), Nov_2025_Discount_PC VARCHAR(50), Nov_2025_Unique_Invoices VARCHAR(50), Nov_2025_Product_Variety VARCHAR(50),
    Dec_2025_Sale_Units VARCHAR(50), Dec_2025_Discount_PC VARCHAR(50), Dec_2025_Unique_Invoices VARCHAR(50), Dec_2025_Product_Variety VARCHAR(50),
    Jan_2026_Sale_Units VARCHAR(50), Jan_2026_Discount_PC VARCHAR(50), Jan_2026_Unique_Invoices VARCHAR(50), Jan_2026_Product_Variety VARCHAR(50),
    Feb_2026_Sale_Units VARCHAR(50), Feb_2026_Discount_PC VARCHAR(50), Feb_2026_Unique_Invoices VARCHAR(50), Feb_2026_Product_Variety VARCHAR(50),
    Mar_2026_Sale_Units VARCHAR(50), Mar_2026_Discount_PC VARCHAR(50), Mar_2026_Unique_Invoices VARCHAR(50), Mar_2026_Product_Variety VARCHAR(50)
);
GO
-- For local reproduction, import your own authorized CSV into dbo.raw_pharmacy_sales.
