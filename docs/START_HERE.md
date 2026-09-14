# First session

Goal: connect to your existing PostgreSQL installation and create a separate database for this project.

For the prepared-files route, open this project folder in VS Code, choose Terminal > New Terminal, and run `./setup.ps1`. Enter your database password locally. It creates the database, imports both files, and runs the reporting queries and checks. Stop after it reports success and follow POWER_BI_GUIDE.md. The sections below explain the manual equivalent; do not run both routes on the same database.

## Open the project

In VS Code choose File > Open Folder and select the insurance-risk-dashboard folder containing this README. Then choose Terminal > New Terminal. The commands below assume a PowerShell terminal opened in that folder.

## Sign in locally

Run:

```powershell
& 'C:\Program Files\PostgreSQL\18\bin\psql.exe' -h localhost -U postgres -d postgres -W
```

Enter the password chosen during PostgreSQL installation at the password prompt. Characters may not appear while typing. Use your own database username if it is different from postgres. Keep the password in the application, not in project files or chat.

When connected, the prompt should look like postgres=#. Run:

```sql
CREATE DATABASE insurance_dashboard;
```

This creates an empty database; it does not modify other databases. If the name already exists, stop and inspect it before using it.

Then switch to it:

```text
\connect insurance_dashboard
```

## Create and load the tables

These commands run inside psql. Read each file in VS Code before running it:

```text
\i sql/01_create_tables.sql
\i sql/02_import_data.psql
\i sql/03_explore.sql
\i sql/04_reporting_views.sql
\i sql/05_validate.sql
```

Run the creation and import scripts once in the new database. They deliberately do not delete existing data. Expected import messages are COPY 678013 and COPY 26639. The exploration results should match README.md. If any command reports an error, stop and review it before continuing.

Type \q to leave psql.

## What you are learning

CREATE TABLE defines columns and their types. A primary key makes each policy ID unique. COPY loads CSV rows. SELECT asks a question of the data. GROUP BY combines rows into summaries. LEFT JOIN keeps every policy while looking for matching claims. NULLIF prevents dividing by zero.

Your first checkpoint is a successful connection. Next we will interpret the exploration queries before connecting Power BI.
