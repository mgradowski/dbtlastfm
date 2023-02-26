from datetime import date

from pandas import DataFrame, date_range
from workalendar.europe import Poland


DATE_MIN = date(2020, 1, 1)
DATE_MAX = date(2022, 12, 31)
CAL = Poland()


def model(dbt, session) -> DataFrame:
    return DataFrame.from_dict(
        data={"calendar_date": date_range(DATE_MIN, DATE_MAX)}
    ).assign(
        pk_date=lambda df: df.eval(
            "calendar_date.dt.year * 10000 + calendar_date.dt.month * 100 + calendar_date.dt.day"
        ),
        calendar_date=lambda df: df.calendar_date.dt.date,
        is_working_day=lambda df: df.calendar_date.apply(CAL.is_working_day),
    )[["pk_date", "calendar_date", "is_working_day"]] # Reorder columns
