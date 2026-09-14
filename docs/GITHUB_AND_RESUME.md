# Publish the finished project

Finish and validate the Power BI report before publishing. The personal resume is not part of this repository.

## Repository contents

Include README.md, sql, docs, setup.ps1, powerbi/measures.dax, powerbi/theme.json, the completed PBIX, and screenshots. Keep original data out of Git until redistribution terms are verified. A PBIX with imported data also embeds data, so confirm permission before publishing that file. If redistribution is not permitted, publish code and permitted screenshots plus download instructions instead.

Dataset page supplied by Ryan: https://www.kaggle.com/datasets/karansarpal/fremtpl2-french-motor-tpl-insurance-claims

Add the source's license and citation to README.md after checking the dataset page. Do not assign a license to third-party data yourself.

## Upload using VS Code

1. Open this project folder in VS Code.
2. Select Source Control, then Initialize Repository if it is offered.
3. Review changed files. Confirm the CSV files and personal resume are absent and no password appears in staged files.
4. Stage the intended project files and commit with the message "Add insurance claims dashboard project".
5. Choose Publish to GitHub, sign into your account, and use the repository name insurance-risk-dashboard. Choose the desired visibility.
6. Open the repository on GitHub and confirm the README and screenshots display correctly.

Before publishing, update the README status and include 2–3 verified findings, each with its measure, denominator, and limitations. Do not claim that descriptive differences establish causation or that the project improved a real insurer's outcomes.

## Resume entry after completion

Auto Insurance Claims and Risk Dashboard | PostgreSQL, SQL, Power BI, Git/GitHub

- Built an interactive Power BI report analyzing 678,013 insurance policy records and 26,639 claim amount records using PostgreSQL reporting views and DAX measures.
- Used SQL aggregations and joins to calculate exposure-weighted claim frequency and audit unmatched records and discrepancies between reported counts and available claim amounts.

Use this entry only after completing and verifying the report. Be prepared to explain why claims are aggregated before joining, why frequency uses exposure, and why missing amounts are not automatically zero.
