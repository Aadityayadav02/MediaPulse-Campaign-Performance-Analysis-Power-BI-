# Power BI dashboard build specification

## Page 1 — Executive Overview
**Slicers:** Date, Channel, Region, Device  
**KPI cards:** Impressions, Clicks, Conversions, Spend, Revenue, CTR, CVR, CPA, ROAS  
**Visuals:**
- Line chart: monthly spend and revenue
- Clustered bar: ROAS by channel
- Bar chart: conversions by channel
- Table: campaign, spend, conversions, CPA, ROAS

## Page 2 — Campaign Deep Dive
- Scatter chart: spend (X) vs conversions (Y), bubble size = revenue, legend = channel
- Matrix: channel > campaign with spend, clicks, conversions, CTR, CVR, CPA, ROAS
- Bar chart: CPA by campaign
- Slicers: date, channel, region, device

## Page 3 — Audience / Placement Slice
- Bar chart: conversions by device
- Bar chart: ROAS by region
- Trend line: CTR and CVR by month
- A note that the dataset is simulated and not customer-level data

## Suggested DAX measures
Assume the table is named `campaign_performance`.

```DAX
Total Impressions = SUM(campaign_performance[impressions])
Total Clicks = SUM(campaign_performance[clicks])
Total Conversions = SUM(campaign_performance[conversions])
Total Spend = SUM(campaign_performance[spend])
Total Revenue = SUM(campaign_performance[revenue])

CTR = DIVIDE([Total Clicks], [Total Impressions])
Conversion Rate = DIVIDE([Total Conversions], [Total Clicks])
CPC = DIVIDE([Total Spend], [Total Clicks])
CPA = DIVIDE([Total Spend], [Total Conversions])
ROAS = DIVIDE([Total Revenue], [Total Spend])
Revenue - Spend = [Total Revenue] - [Total Spend]
```

Format CTR and Conversion Rate as percentages; CPC and CPA as currency; ROAS as decimal or `x`.

## Dashboard interpretation checklist
- Do not call revenue-minus-spend “profit”; it excludes other costs.
- Do not average row-level CTR/CVR/ROAS. Use ratio of totals.
- A high ROAS is descriptive, not proof of causation.
- Treat high-spend/low-conversion campaigns as review candidates, not proven waste.
- Add a visible “Synthetic portfolio dataset” note.
