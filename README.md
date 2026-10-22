# MediaPulse — Campaign Performance Analysis (Power BI)

MediaPulse is a portfolio project focused on analyzing digital advertising campaign performance with Power BI. It is designed to demonstrate how campaign data can be transformed into readable KPIs, trend charts, channel comparisons, and campaign-level analysis.

> **Data note:** The dataset used in this project is synthetic/sample data created for portfolio and learning purposes. It is not data from a real client or employer, and the numbers should not be interpreted as real-world campaign results.

## Project goals

- Track delivery and engagement using impressions, clicks, and click-through rate (CTR).
- Review conversions and conversion rate to understand post-click performance.
- Compare advertising spend and revenue efficiency using ROAS, CPC, and cost per conversion.
- Explore differences by date, advertising channel, campaign, region, and device.
- Build an interactive report that supports filtering and comparison rather than presenting isolated totals.

## Dataset

The sample dataset is named `campaign_performance.csv` and contains campaign-level records for January–June 2025. The dataset includes 905 synthetic rows and the following fields:

| Field | Description |
|---|---|
| `date` | Date associated with the record |
| `channel` | Advertising channel, such as Search or Social |
| `campaign` | Campaign name/category |
| `region` | Geographic region label |
| `device` | Device category |
| `impressions` | Number of ad impressions |
| `clicks` | Number of ad clicks |
| `conversions` | Number of recorded conversions |
| `spend` | Advertising spend in the sample dataset's units |
| `revenue` | Revenue attributed in the sample dataset's units |

The data is synthetic, so the results are useful for demonstrating analysis methods—not for making real business claims.

## KPIs and calculations

The report uses the following measures. Ratios are calculated from totals so that aggregated views are not simply averages of row-level percentages.

| KPI | Definition |
|---|---|
| Total Impressions | Sum of `impressions` |
| Total Clicks | Sum of `clicks` |
| CTR | Total Clicks ÷ Total Impressions |
| Total Spend | Sum of `spend` |
| Total Conversions | Sum of `conversions` |
| Conversion Rate | Total Conversions ÷ Total Clicks |
| ROAS | Total Revenue ÷ Total Spend |
| CPC | Total Spend ÷ Total Clicks |
| Cost per Conversion | Total Spend ÷ Total Conversions |

ROAS measures revenue generated per unit of advertising spend; it is **not the same as profit or ROI**. Spend and revenue are shown in the synthetic dataset's units, so a currency symbol should only be added if the dataset's currency is explicitly defined.

## Dashboard scope

The current Power BI build includes KPI cards, a date-based impressions trend, channel and campaign comparison charts, and slicers for interactive filtering. The report is being refined to keep metric scales comparable, avoid crowded visuals, and verify that the unfiltered overview is shown by default.

Planned final deliverables for this repository:

- Power BI report (`.pbix`)
- Source CSV (`campaign_performance.csv`)
- Supporting SQL queries and/or Python data-validation script
- Final dashboard screenshot(s)

Only files actually committed to the repository should be presented as available deliverables. The project is still in progress until these assets and the final QA checks are added.

## Tools and skills demonstrated

- **Power BI Desktop:** report building, KPI cards, charts, slicers, visual formatting
- **DAX:** aggregation measures and ratio calculations using `DIVIDE()` to handle zero denominators
- **Data analysis:** trend analysis, channel/campaign comparison, conversion efficiency, return on ad spend
- **Data quality:** checks for missing values, duplicates, negative metrics, and basic logical consistency

## Validation and interpretation notes

Before treating a chart as an insight, check the active date/region/channel filters and confirm whether the value shown is filtered or overall. Metrics with different units (for example, conversions and ROAS) should not be plotted on a single shared axis without a suitable secondary-axis design; separate visuals are usually easier to interpret. No channel or campaign should be called a “winner” without reviewing the actual filtered results and relevant context.

## How to review the project

1. Open the `.pbix` file in Power BI Desktop once it has been added to the repository.
2. Review the Executive Overview page and test the slicers.
3. Clear all slicer selections to inspect the overall totals, then filter by date, region, or channel.
4. Compare CTR, conversion rate, CPC, cost per conversion, and ROAS together rather than relying on one KPI alone.
5. Review the source CSV and supporting analysis assets to understand the data and calculations.

## Author

Aditya Kumar — portfolio project for demonstrating data analytics and Power BI skills.# MediaPulse-Campaign-Performance-Analysis-Power-BI-
