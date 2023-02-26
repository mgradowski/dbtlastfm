select
    artist,
    album,
    track,
    "time"
from
    read_csv(
        "rawdata/lastfm/*.csv",
        columns = {
            'artist': 'varchar',
            'album': 'varchar',
            'track': 'varchar',
            'time': 'timestamp'
        },
        timestampformat='%-d %b %Y %H:%M'
    )
where
    extract(year from "time") between 2020 and 2022
