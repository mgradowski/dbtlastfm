# dbtlastfm
Basic dbt project, based on my last.fm statistics, and IMGW weather data.

## Prerequisites
* Python 3.11.x
* Poetry
* DuckDB 0.9.x

## Usage
```
poetry install
poetry shell

./load-data.sh
dbt build

dbt docs generate
dbt docs serve
```
