# Validation and reconciliation

The supplied files were imported and the reporting queries executed in a temporary PostgreSQL 18 database on September 11, 2026. This test database is separate from the user's existing PostgreSQL databases. It is stopped after testing.

The validation SQL checks policy and claim row counts, preserved policy grain, preserved exposure, preserved claim amounts, unmatched records, and policy count mismatches. The user subsequently loaded the regular database and shared matching SQL results. Power BI screenshots show matching unfiltered totals. On September 14, 2026, the Unmatched policy slicer produced 195 records, 788,714.18 recorded amount, and 4,044.69 average recorded claim. The policy-page region slicer was also tested interactively by the user. These are targeted visual and reconciliation checks, not exhaustive testing of every filter combination.

## Unfiltered report values

| Metric | Expected value |
| --- | ---: |
| Policy Count | 678,013 |
| Exposure Years | 358,499.445462177 |
| Reported Claims | 36,102 |
| Claims per 100 Exposure Years | 10.0703084641 |
| Recorded Claim Count | 26,639 |
| Recorded Claim Amount | 60,697,930.68 |
| Matched amount records | 26,444 |
| Matched recorded amount | 59,909,216.50 |
| Unmatched amount records | 195 |
| Unmatched recorded amount | 788,714.18 |
| Policies with Count Mismatch | 9,117 |

Counts should agree exactly. Currency totals should agree to 0.01 and displayed exposure or rates to their configured rounding precision. Average Recorded Claim should equal 60,697,930.68 / 26,639.

## Age segment check

| Driver age | Policies | Reported claims | Claims per 100 exposure years |
| --- | ---: | ---: | ---: |
| Under 25 | 30,198 | 2,364 | 18.9284 |
| 25–34 | 140,947 | 6,396 | 9.9011 |
| 35–44 | 170,578 | 8,145 | 9.3201 |
| 45–54 | 164,034 | 9,513 | 10.5873 |
| 55–64 | 99,094 | 5,124 | 9.1212 |
| 65+ | 73,162 | 4,560 | 9.5019 |

Retained all source exposure values, including 1,224 above one year. Did not cap ages, costs, or exposure, and did not delete mismatched policies. This is a transparent raw-data baseline, not an actuarial pricing model. Currency labeling and redistribution terms still require source verification.
