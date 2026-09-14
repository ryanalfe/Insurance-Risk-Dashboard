-- Fail loudly if the reporting join duplicates policies or loses source claims.
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM insurance.policies) <> 678013 THEN
        RAISE EXCEPTION 'Policy count differs from the supplied source';
    END IF;
    IF (SELECT COUNT(*) FROM insurance.claims) <> 26639 THEN
        RAISE EXCEPTION 'Claim count differs from the supplied source';
    END IF;
    IF (SELECT COUNT(*) FROM insurance.policy_dashboard) <> 678013 THEN
        RAISE EXCEPTION 'Reporting join changed the policy grain';
    END IF;
    IF (SELECT SUM(exposure) FROM insurance.policy_dashboard)
       <> (SELECT SUM(exposure) FROM insurance.policies) THEN
        RAISE EXCEPTION 'Reporting join changed total exposure';
    END IF;
    IF (SELECT SUM(claim_amount) FROM insurance.claim_dashboard)
       <> (SELECT SUM(claim_amount) FROM insurance.claims) THEN
        RAISE EXCEPTION 'Claim reporting view changed total recorded amounts';
    END IF;
    IF (SELECT COUNT(*) FROM insurance.claim_dashboard WHERE match_status = 'Unmatched') <> 195 THEN
        RAISE EXCEPTION 'Unexpected number of unmatched claim records';
    END IF;
    IF (SELECT SUM(count_mismatch_flag) FROM insurance.policy_dashboard) <> 9117 THEN
        RAISE EXCEPTION 'Unexpected policy count mismatches';
    END IF;
END $$;

SELECT COUNT(*) AS policies, SUM(exposure) AS exposure_years,
       SUM(claim_count) AS reported_claims,
       ROUND(100.0 * SUM(claim_count) / SUM(exposure), 4) AS claims_per_100_years
FROM insurance.policy_dashboard;
SELECT match_status, COUNT(*) AS amount_records, SUM(claim_amount) AS recorded_amount
FROM insurance.claim_dashboard GROUP BY match_status ORDER BY match_status;
SELECT * FROM insurance.age_summary ORDER BY driver_age_sort;
