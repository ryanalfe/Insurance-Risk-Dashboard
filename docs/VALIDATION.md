# Validation

SQL checks verified source row counts, unique policy IDs, preserved exposure totals after joins, and recorded claim amounts. Power BI totals were reconciled against the SQL results.

Region slicers were tested on both report pages. Selecting “Unmatched policy” returned 195 claim records, a recorded amount of 788,714.18, and an average recorded claim of 4,044.69.

Validation covered headline totals and selected filter scenarios; it did not exhaustively test every filter combination.

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


## Age segment check

| Driver age | Policies | Reported claims | Claims per 100 exposure years |
| --- | ---: | ---: | ---: |
| Under 25 | 30,198 | 2,364 | 18.9284 |
| 25–34 | 140,947 | 6,396 | 9.9011 |
| 35–44 | 170,578 | 8,145 | 9.3201 |
| 45–54 | 164,034 | 9,513 | 10.5873 |
| 55–64 | 99,094 | 5,124 | 9.1212 |
| 65+ | 73,162 | 4,560 | 9.5019 |

Retained all source exposure values, including 1,224 above one year. Did not cap ages, costs, or exposure, and did not delete mismatched policies. This is a transparent raw-data baseline, not an actuarial pricing model. 
