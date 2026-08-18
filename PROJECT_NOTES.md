# GitHub preparation changes

- Removed the hard-coded Google Colab / Google Drive input path.
- Added command-line input/output arguments.
- Forecast months are now generated from the latest month in the dataset.
- Missing sales observations are removed before model fitting.
- Renamed `Actual_Sales` to `Latest_Observed_Sales` because future actuals were not available.
- Anonymized customer identifiers.
- Excluded original PBIX files from the public repo because they may embed source data.
- Reorganized SQL into reproducible ordered scripts.
