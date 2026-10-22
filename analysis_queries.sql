-- MediaPulse SQL analysis (SQLite-compatible)
-- First load data/campaign_performance.csv into a table named campaign_performance.
-- KPI ratios are calculated from aggregate totals, not by averaging row-level ratios.

-- 1) Channel performance overview
SELECT
    channel,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(spend), 2) AS spend,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(1.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 4) AS ctr,
    ROUND(1.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 4) AS conversion_rate,
    ROUND(SUM(spend) / NULLIF(SUM(clicks), 0), 2) AS cpc,
    ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(SUM(revenue) / NULLIF(SUM(spend), 0), 2) AS roas
FROM campaign_performance
GROUP BY channel
ORDER BY roas DESC;

-- 2) Campaign-level efficiency
SELECT
    channel, campaign,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(spend), 2) AS spend,
    ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(SUM(revenue) / NULLIF(SUM(spend), 0), 2) AS roas
FROM campaign_performance
GROUP BY channel, campaign
ORDER BY cpa DESC;

-- 3) Monthly trend
SELECT
    substr(date, 1, 7) AS month,
    channel,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(spend), 2) AS spend,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(1.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 4) AS ctr,
    ROUND(SUM(revenue) / NULLIF(SUM(spend), 0), 2) AS roas
FROM campaign_performance
GROUP BY substr(date, 1, 7), channel
ORDER BY month, channel;

-- 4) Device comparison
SELECT
    device,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(1.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 4) AS ctr,
    ROUND(1.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 4) AS conversion_rate,
    ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cpa
FROM campaign_performance
GROUP BY device
ORDER BY conversions DESC;

-- 5) Regional performance
SELECT
    region,
    SUM(spend) AS spend,
    SUM(conversions) AS conversions,
    ROUND(SUM(revenue) / NULLIF(SUM(spend), 0), 2) AS roas
FROM campaign_performance
GROUP BY region
ORDER BY roas DESC;

-- 6) Data quality: logical violations (expected result: zero rows)
SELECT *
FROM campaign_performance
WHERE impressions < 0 OR clicks < 0 OR conversions < 0
   OR spend < 0 OR revenue < 0
   OR clicks > impressions
   OR conversions > clicks;

-- 7) Potential review list. These are flags for investigation, not automatic proof of waste.
SELECT
    channel, campaign,
    SUM(spend) AS spend,
    SUM(conversions) AS conversions,
    ROUND(SUM(spend) / NULLIF(SUM(conversions), 0), 2) AS cpa,
    ROUND(SUM(revenue) / NULLIF(SUM(spend), 0), 2) AS roas
FROM campaign_performance
GROUP BY channel, campaign
HAVING SUM(spend) > (SELECT AVG(spend) FROM campaign_performance) * 100
ORDER BY roas ASC;
