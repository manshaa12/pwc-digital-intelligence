import pandas as pd
import numpy as np

# Load historical data
data = pd.read_csv('Data.csv')

# Compute historical repayment percentages
data_pct = data.copy()
for i in range(1, data.shape[1]):
    data_pct.iloc[:, i] = data.iloc[:, i] / data.iloc[:, 0]

# Compute expected repayment percentages (details should be in assumptions PDF)
expected_repayments = data_pct.mean(axis=0)

# Forecast cash flows
forecasted_cash_flows = data.copy()
for i in range(1, data.shape[1]):
    forecasted_cash_flows.iloc[:, i] = data.iloc[:, 0] * expected_repayments[i]

# Convert annual discount rate to monthly
annual_discount_rate = 0.05
monthly_discount_rate = (1 + annual_discount_rate) ** (1/12) - 1

# Compute present value of forecasted cash flows
present_value = 0
for i in range(1, forecasted_cash_flows.shape[1]):
    present_value += forecasted_cash_flows.iloc[:, i].sum() / ((1 + monthly_discount_rate) ** i)

# Compare with client's estimate
client_estimate = 84993122.67
absolute_difference = abs(present_value - client_estimate)
relative_difference = absolute_difference / client_estimate

# Check if the difference is acceptable
is_acceptable = absolute_difference < 500000

print(f"Present Value of Portfolio: CHF {present_value:.2f}")
print(f"Absolute Difference: CHF {absolute_difference:.2f}")
print(f"Relative Difference: {relative_difference:.2%}")
print(f"Is the difference acceptable? {'Yes' if is_acceptable else 'No'}")
