# Sandy Beach Invertebrate & Shorebird Database

## Purpose
This repository constructs a relational DuckDb database from a survey of 24 sandy beach sites in Santa Barbara and Ventura Counties (2017 -2018) to answer the question: 

** Do sites with higher invertebrate biomass support greater shorebird abundance?** 

## Repository Structure
```
.
├── README.md
├── .gitignore                 # excludes raw data and .DS_Store
├── data-expo-clean.R          # data cleaning script (R)
├── SQL-queries.sql            # database verification + analytical query
├── analysis.ipynb             # Python analysis and visualization
├── database/
|    └── beach_ecology.db           # DuckDB database
├── data/
│   └── processed/
│       ├── invertebrates_clean.csv
│       └── shorebirds_clean.csv
├── requirements.txt            # Python dependencies
└── r_requirements.txt          # R dependencies
```
## Data Access

Raw data is not included in this repository. It can be downloaded from the Environmental Data Initiative (EDI):

> Schooler, S., and J. Dugan. 2021. *Invertebrate community structure and ecosystem functions of 24 sandy beach sites.* EDI Data Portal. 

Download the following two CSVs and place them in `data/raw/` before running `data-expo-clean.R`:
- Invertebrate species abundance and biomass by transect
- Shorebird species abundance by survey date

## How to Reproduce

1. Download raw data (see above) and place in `data/raw/`
2. Run `data-expo-clean.R` to clean data and export to `data/processed/`
3. Load the processed CSVs into `beach_ecology.db` using a DuckDB (e.g., via the DuckDB VSCode extension or Python)
4. Run `SQL-queries.sql` to verify the database and execute the analytical query
5. Open `analysis.ipynb` and run all cells to reproduce the visualization

## Dependencies

**R** (see `r_requirements.txt`):
- `tidyverse`
- `here`
- `janitor`

**Python** (see `requirements.txt`):
- `duckdb`
- `pandas`
- `matplotlib`
- `seaborn`

## References & Acknowledgements

- Course: UCSB [EDS 213](https://ucsb-library-research-data-services.github.io/bren-eds213/) — Databases and Data Management
- Dataset: Schooler, S., and J. Dugan. 2021. Invertebrate community structure and ecosystem functions of 24 sandy beach sites, Santa Barbara and Ventura Counties. [Environmental Data Initiative.](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-sbc.163.1)
