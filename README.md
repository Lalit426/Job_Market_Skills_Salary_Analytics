# Job Market Skills & Salary Analytics

An end-to-end data analytics portfolio project exploring job-posting demand, skills, locations, experience, and disclosed salary ranges in a supplied Indian job-market dataset.

## Project objective

Answer questions such as:
- Which job titles and companies appear most often in this dataset?
- Which skills are mentioned most frequently?
- How do disclosed salary ranges vary by job title and experience band?
- Which location labels have the most postings?
- Which skills are associated with higher median salary among postings with disclosed INR salary?

## Dataset

- File: `data/raw/indian-job-market-dataset-2025.xlsx`
- Rows/columns in the provided source: **97,929 rows × 17 columns**
- Columns include job title, job ID, currency, upload-age text, company, skills, experience, salary text/ranges, location, reviews/ratings, and job description.
- The source file is included in this repository. Please check the dataset provider's license/terms before redistributing it publicly.

## Tools

- Python, Pandas, NumPy
- Matplotlib, Seaborn
- SQL (MySQL 8+ queries in `sql/analysis_queries.sql`)
- Jupyter Notebook / VS Code

## Run locally

1. Install Python 3.10+.
2. In the project root, install requirements:
   ```bash
   pip install -r requirements.txt
   ```
3. Open `notebooks/job_market_analysis.ipynb` in VS Code or Jupyter.
4. Run all cells from top to bottom.
5. Outputs and charts are saved under `outputs/`.

If you open the notebook from the project root, it detects the data path. The notebook also supports being run from inside the `notebooks` directory.

## Data preparation decisions

- Trim whitespace from selected text fields.
- Keep one record per `jobId` (first occurrence) and report how many repeated IDs are removed.
- Replace missing skill tags with `Not Specified` rather than inventing skills.
- Keep original salary bounds, but treat zero/zero salary bounds as undisclosed in derived salary analysis.
- Salary comparisons use only postings with positive numeric salary bounds and `currency == INR`, avoiding mixing currencies.
- Use the salary midpoint as an estimate from the provided minimum and maximum bounds; report median salary because salary distributions can be skewed.
- Do not fill missing company reviews/ratings with zero.

## Key source-data checks

- Duplicate job IDs in raw file: **250**
- Skill tags missing in raw file: **571** (0.58%)
- Experience text missing in raw file: **2,105** (2.15%)
- Reviews and ratings each have about **36%** missing values.
- Raw salary bounds are zero for **64,121** rows; these are excluded from salary statistics.

## Initial analysis snapshot

From the supplied file, the notebook's cleaning rules identify 250 repeated job IDs and retain 97,679 unique job IDs. About 33.9% of retained rows have positive numeric salary bounds in INR, so salary findings describe only the salary-disclosed subset. The median salary midpoint in that subset is approximately ₹4.25 LPA. The most frequent raw job-title label is “Application Developer”; the most frequent raw location label is “Bengaluru”. These are dataset-specific descriptive findings, not market-wide estimates.

## Important limitations

- Listings in this file may not represent the entire Indian job market.
- `jobUploaded` values are relative text such as “6 Days Ago”, not validated calendar dates.
- Location entries can combine cities or include work-mode labels; location counts are raw labels, not normalized city totals.
- Skills are extracted from comma-separated tags. Spelling variants and synonyms may remain separate.
- Salary comparisons are observational. They do not prove that a skill or experience level causes a particular salary.

## Repository structure

```text
Job_Market_Skills_Salary_Analytics/
├── data/raw/                  # source Excel dataset
├── notebooks/                 # end-to-end EDA and analysis notebook
├── sql/                       # MySQL analysis queries
├── outputs/                   # generated CSV summaries and figures
├── requirements.txt
├── .gitignore
└── README.md
```

## Suggested GitHub repository description

`End-to-end job market analytics project using Python, Pandas, SQL and data visualization to explore skill demand, job postings and disclosed salary ranges.`
