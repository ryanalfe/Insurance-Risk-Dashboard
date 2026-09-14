-- One row per policy, with claim amounts aggregated BEFORE joining.
CREATE OR REPLACE VIEW insurance.policy_dashboard AS
WITH costs AS (
    SELECT policy_id, COUNT(*) AS amount_record_count,
           SUM(claim_amount) AS recorded_claim_amount
    FROM insurance.claims GROUP BY policy_id
)
SELECT p.*,
       CASE WHEN driver_age < 25 THEN 'Under 25'
            WHEN driver_age < 35 THEN '25-34'
            WHEN driver_age < 45 THEN '35-44'
            WHEN driver_age < 55 THEN '45-54'
            WHEN driver_age < 65 THEN '55-64'
            ELSE '65+' END AS driver_age_band,
       CASE WHEN driver_age < 25 THEN 1 WHEN driver_age < 35 THEN 2
            WHEN driver_age < 45 THEN 3 WHEN driver_age < 55 THEN 4
            WHEN driver_age < 65 THEN 5 ELSE 6 END AS driver_age_sort,
       COALESCE(c.amount_record_count, 0) AS amount_record_count,
       c.recorded_claim_amount,
       CASE WHEN p.claim_count = COALESCE(c.amount_record_count, 0)
            THEN 0 ELSE 1 END AS count_mismatch_flag
FROM insurance.policies p LEFT JOIN costs c USING (policy_id);

-- Preserve unmatched claims explicitly in a separate claim-level view.
CREATE OR REPLACE VIEW insurance.claim_dashboard AS
SELECT c.policy_id, c.claim_amount,
       COALESCE(p.region, 'Unmatched policy') AS region,
       CASE WHEN p.policy_id IS NULL THEN 'Unmatched' ELSE 'Matched' END AS match_status
FROM insurance.claims c LEFT JOIN insurance.policies p USING (policy_id);

CREATE OR REPLACE VIEW insurance.age_summary AS
SELECT driver_age_band, driver_age_sort, COUNT(*) AS policies,
       SUM(exposure) AS exposure_years, SUM(claim_count) AS reported_claims,
       100.0 * SUM(claim_count) / NULLIF(SUM(exposure), 0) AS claims_per_100_years
FROM insurance.policy_dashboard
GROUP BY driver_age_band, driver_age_sort;
