from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "campaign_performance.csv"

df = pd.read_csv(DATA, parse_dates=["date"])

print("=== Dataset shape ===")
print(f"Rows: {len(df):,} | Columns: {len(df.columns)}")
print("\n=== Missing values ===")
print(df.isna().sum())

print("\n=== Duplicate rows ===")
print(df.duplicated().sum())

print("\n=== Logical checks ===")
checks = {
    "negative metrics": ((df[["impressions", "clicks", "conversions", "spend", "revenue"]] < 0).any(axis=1)).sum(),
    "clicks > impressions": (df["clicks"] > df["impressions"]).sum(),
    "conversions > clicks": (df["conversions"] > df["clicks"]).sum(),
}
for name, count in checks.items():
    print(f"{name}: {count}")

summary = (
    df.groupby("channel", as_index=False)
      .agg(impressions=("impressions", "sum"),
           clicks=("clicks", "sum"),
           conversions=("conversions", "sum"),
           spend=("spend", "sum"),
           revenue=("revenue", "sum"))
)
summary["CTR"] = summary["clicks"] / summary["impressions"].replace(0, pd.NA)
summary["CVR"] = summary["conversions"] / summary["clicks"].replace(0, pd.NA)
summary["CPC"] = summary["spend"] / summary["clicks"].replace(0, pd.NA)
summary["CPA"] = summary["spend"] / summary["conversions"].replace(0, pd.NA)
summary["ROAS"] = summary["revenue"] / summary["spend"].replace(0, pd.NA)
summary["revenue_minus_spend"] = summary["revenue"] - summary["spend"]

print("\n=== Channel KPI summary ===")
print(summary.round(3).to_string(index=False))

out = ROOT / "reports" / "channel_kpi_summary.csv"
summary.to_csv(out, index=False)
print(f"\nSaved summary: {out}")
