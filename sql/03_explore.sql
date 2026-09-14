-- First verify that the import preserved every source row.
SELECT COUNT(*) AS policy_rows FROM insurance.policies; -- 678013
SELECT COUNT(*) AS claim_rows FROM insurance.claims;    -- 26639

-- Exposure is time insured, measured in years.
-- Divide totals to weight frequency by time insured.
SELECT SUM(claim_count) AS reported_claims,
       SUM(exposure) AS exposure_years,
       100.0 * SUM(claim_count) / NULLIF(SUM(exposure), 0)
           AS reported_claims_per_100_exposure_years
FROM insurance.policies;

-- These 195 rows cannot be assigned policy characteristics.
SELECT COUNT(*) AS unmatched_claim_rows
FROM insurance.claims c
LEFT JOIN insurance.policies p ON p.policy_id = c.policy_id
WHERE p.policy_id IS NULL;

-- Aggregate before joining so policies with several claims are not duplicated.
WITH claims_by_policy AS (
    SELECT policy_id, COUNT(*) AS amount_records
    FROM insurance.claims GROUP BY policy_id
)
SELECT COUNT(*) AS policies_with_count_mismatch
FROM insurance.policies p
LEFT JOIN claims_by_policy c ON c.policy_id = p.policy_id
WHERE p.claim_count <> COALESCE(c.amount_records, 0); -- 9117

SELECT COUNT(*) AS exposure_over_one
FROM insurance.policies WHERE exposure > 1; -- 1224; investigate, do not silently cap
