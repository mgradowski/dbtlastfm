select
    artist_name,
    album_title,
    track_title,
    cast(playback_timestamp as date) as playback_date,
    playback_timestamp,
    row_number() over () as _scrobbleid
from
    read_csv(
        "rawdata/lastfm/*.csv",
        columns = {
            'artist_name':'varchar',
            'album_title':'varchar',
            'track_title':'varchar',
            'playback_timestamp':'timestamp'
        },
        timestampformat = '%-d %b %Y %H:%M'
    )
where extract(year from "playback_timestamp") between 2020 and 2022
