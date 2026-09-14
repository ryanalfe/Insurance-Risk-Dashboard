# Build the Power BI report

Prerequisite: database setup and sql/05_validate.sql must succeed. The SQL views and measures are prepared. The Power BI report itself still needs to be assembled and verified in Desktop.

## Connect

1. In Power BI Desktop select Home > Get data > More > Database > PostgreSQL database.
2. Enter server localhost:5432 and database insurance_dashboard. Choose Import.
3. Choose Database authentication and enter your PostgreSQL username and password locally.
4. If your local server reports that it does not support encryption, Power BI may offer an unencrypted connection. Only use that option for this local localhost connection.
5. Select insurance.policy_dashboard and insurance.claim_dashboard, then Transform Data.
6. Rename the queries Policies and Claims. Set policy_id to Whole Number in both. Set claim counts, ages, sort order, and flags to Whole Number, exposure to Decimal Number, and monetary amounts to Fixed Decimal Number. Keep labels as Text. Close & Apply.
7. In Model view remove any automatically detected relationship between these tables. They intentionally power separate report pages, so each page uses its own table and slicers. This keeps unmatched claims visible and avoids unintended filtering across populations.

Connector documentation: https://learn.microsoft.com/en-us/power-query/connectors/postgresql

## Add measures and theme

Open powerbi/measures.dax in VS Code. In Power BI use Modeling > New measure, then paste ONE definition at a time. A measure calculates a result again when a slicer changes. The file is a reference, not a script to paste all at once.

Format counts as whole numbers, exposure and claim frequency to two decimals, Count Mismatch Share as a percentage, and claim amounts to two decimals. Use neutral amount labels until currency is confirmed from the source documentation.

Use View > Themes > Browse for themes to import powerbi/theme.json. Set each page to 16:9. Select Policies[driver_age_band] and choose Column tools > Sort by column > driver_age_sort.

## Page 1: Policy risk overview

Question: Which policy groups have higher reported claim frequency after accounting for time insured?

Place a title across the top and four cards beneath it: Policy Count, Exposure Years, Reported Claims, and Claims per 100 Exposure Years.

Below the cards:

- Clustered column chart: driver_age_band on X, Claims per 100 Exposure Years on Y. Add Exposure Years and Reported Claims to tooltips. Sort by age band ascending.
- Horizontal bar chart: region on Y, Claims per 100 Exposure Years on X. Sort descending and include Exposure Years in tooltips.
- Compact table: driver_age_band, Policy Count, Exposure Years, Reported Claims, Claims per 100 Exposure Years.
- Slicers at the left or top: Policies[region] and Policies[fuel_type].

Add a short footnote: "Frequency = reported claims / exposure years × 100. Group comparisons are descriptive and are not adjusted for other risk characteristics."

Do not format frequency as a percentage: it is a count per 100 exposure years, not the share of policies with a claim.

## Page 2: Recorded claims and coverage

Question: What do the available claim amount records show, and how complete is their match to policies?

Cards: Recorded Claim Count, Recorded Claim Amount, Average Recorded Claim, and Unmatched Claim Records.

- Horizontal bar chart: Claims[region] and Recorded Claim Amount, with Recorded Claim Count in tooltips.
- Table: Claims[match_status], Recorded Claim Count, Recorded Claim Amount, Average Recorded Claim.
- Slicer: Claims[region]. Do not synchronize the page 1 slicers with this page.

Add this note: "Available amount records do not reconcile to policy-reported claim counts. Unmatched records remain included. Recorded amounts do not establish complete portfolio losses."

## Verify and save

Clear all filters. Compare page 1 cards and page 2 match-status table with the output of sql/05_validate.sql. Select one age band and compare with insurance.age_summary. Change a region slicer and verify that all intended visuals on its page respond. Confirm page 2 includes an Unmatched policy region and 195 unmatched records when unfiltered.

Use File > Save As to save powerbi/insurance-risk-dashboard.pbix. Capture both report pages into docs/screenshots after checking labels for clipping. GitHub stores a PBIX file but does not provide its interactive Power BI experience in the repository page; screenshots let visitors inspect the work immediately.
