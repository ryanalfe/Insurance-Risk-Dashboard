-- Run inside a new database named insurance_dashboard.
-- A schema groups related tables. Each policy has a unique ID.
-- Claims can have repeated policy IDs because a policy can have several claims.
BEGIN;
CREATE SCHEMA insurance;

CREATE TABLE insurance.policies (
    -- One source ID is written as 1.00E+05. Numeric accepts that exactly.
    policy_id numeric PRIMARY KEY CHECK (policy_id = trunc(policy_id)),
    claim_count integer NOT NULL,
    exposure numeric NOT NULL,
    vehicle_power integer,
    vehicle_age integer,
    driver_age integer,
    bonus_malus integer,
    vehicle_brand text,
    fuel_type text,
    area text,
    density integer,
    region text
);

CREATE TABLE insurance.claims (
    policy_id numeric NOT NULL CHECK (policy_id = trunc(policy_id)),
    claim_amount numeric NOT NULL
);
-- No foreign key yet: some claim IDs are absent from the policy file.
CREATE INDEX claims_policy_id_idx ON insurance.claims(policy_id);
COMMIT;
