# Boston Housing Price Prediction Using Multivariate Regression
﻿
This project utilizes a multivariate regression model to predict housing prices in Boston based on the dataset from the 1970s. The analysis involves exploring the relationships between housing prices and various factors such as crime rates, zoning information, and access to facilities like highways and employment centers.
﻿
## Task Overview
The main objective of this code is to build a predictive model that estimates the median value of owner-occupied homes (MEDV) based on 13 different variables. The code performs the following tasks:
- Data loading and preprocessing from a CSV file.
- Exploratory data analysis to understand the distribution and relationships among variables.
- Model establishment using the `lm` function from the `stats` package.
- Diagnostic checks to ensure the assumptions of linear regression are met.
- Identification and removal of influential outliers and high leverage points.
- Model simplification by removing non-significant predictors.
- Comparison of full and simplified models using information criteria (AIC, BIC, SBC).
- F-test to determine the significance of the reduction in the number of predictors.
﻿
## Packages Utilized
- `car`: Provides functions for conducting various types of regression analyses.
- `corrplot`: Visualizes the correlation matrix between variables.
- `MASS`: Offers functions for model fitting, including the `lm` function used for linear regression.
- Base R functions for data manipulation, statistical analysis, and plotting.
﻿
## Data Visualization
The code generates several plots for data exploration and model diagnostics:
- Histogram, dotchart, and boxplot for the target variable (MEDV).
- Scatterplot matrix for the relationship between predictors.
- Correlation plot to assess the strength and direction of linear relationships between variables.
﻿
## Model Diagnostics
The following diagnostic measures are calculated and plotted:
- Standardized residuals and Q-Q plot to check the normality of residuals.
- Fitted values vs. standardized residuals to assess homoscedasticity.
- Leverage values, Cook's distance, DFITS, and Hadis' influence measure to identify influential points.
﻿
## Model Comparison and Validation
The code compares the full model with a simplified version that excludes non-significant predictors. The comparison is based on:
- Information criteria (AIC, BIC, SBC) to select the model with the best trade-off between goodness of fit and model complexity.
- F-test to validate the simplification of the model.
﻿
## Conclusion
The code concludes with the selection of an optimized model that provides a good balance between predictive accuracy and model parsimony. The results can be used to understand the factors that drive housing prices in Boston and to make predictions for other, similar datasets.
﻿
## Usage
To run the analysis, ensure you have R installed on your system, and the necessary packages (`car`, `corrplot`, `MASS`). Load the dataset using the correct path to the CSV file and execute the script. The output will be displayed in the R console and plots will be generated in the R graphics device.
