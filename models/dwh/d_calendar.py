from datetime import date, datetime

from pandas import DataFrame, date_range
from workalendar.europe import Poland

DATE_MIN = date(2020, 1, 1)
DATE_MAX = date(2024, 12, 31)
CAL = Poland()


def _fmt_isoweek(dt: datetime) -> str:
    year, week, _ = dt.isocalendar()
    return f"{year}W{week:02d}"


def model(dbt, session) -> DataFrame:
    return DataFrame.from_dict(  # type: ignore
        data={"date_day": date_range(DATE_MIN, DATE_MAX).to_series()}
    ).assign(
        pk_date=lambda df: df.eval(
            "date_day.dt.year * 10000 + date_day.dt.month * 100 + date_day.dt.day"
        ),
        date_week=lambda df: df.date_day.apply(_fmt_isoweek),
        date_month=lambda df: df.date_day.dt.strftime("%Y-%m"),
        date_quarter=lambda df: df.date_day.apply(
            lambda dt: f"{dt.year}Q{dt.month//4+1}"
        ),
        date_year=lambda df: df.date_day.dt.year.astype("string"),
        date_day=lambda df: df.date_day.dt.date,
        is_working_day=lambda df: df.date_day.apply(CAL.is_working_day),
    )[
        [
            "pk_date",
            "date_day",
            "date_week",
            "date_month",
            "date_quarter",
            "date_year",
            "is_working_day",
        ]
    ]  # Reorder columns
