select
    "full_code",
    "name",
    "short_code",
from
    read_csv(
        "rawdata/imgw/stations/*.csv",
        columns = {
            'full_code': 'varchar',
            'name': 'varchar',
            'short_code': 'varchar'
        }
    )
