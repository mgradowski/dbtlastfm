{{ config(materialized="table") }}

with
    climate_scrobbles as (
        select
            {{ dbt_utils.generate_surrogate_key(["scrobbles.artist_name"]) }}
            as fk_artist,
            {{
                dbt_utils.generate_surrogate_key(
                    ["scrobbles.artist_name", "scrobbles.album_title"]
                )
            }} as fk_album,
            {{
                dbt_utils.generate_surrogate_key(
                    ["scrobbles.artist_name", "scrobbles.track_title"]
                )
            }} as fk_track,
            extract(year from scrobbles.playback_timestamp) * 10000
            + extract(month from scrobbles.playback_timestamp) * 100
            + extract(day from scrobbles.playback_timestamp) as fk_date,
            scrobbles.playback_timestamp,
            climate.air_temperature,
            row_number() over (
                partition by _scrobbleid order by climate.measurement_timestamp desc
            ) as _rn,
            measurement_timestamp
        from {{ ref("stg_lastfm__scrobbles") }} scrobbles
        left join
            {{ ref("stg_imgw__climate") }} climate
            on climate.measurement_timestamp <= scrobbles.playback_timestamp
            and climate.measurement_timestamp
            > {{
                dateadd(
                    "hour",
                    -12,
                    "scrobbles.playback_timestamp",
                )
            }}
            and climate.station_name = '{{ var("weather_station_name") }}'
    )
select
    fk_artist,
    fk_album,
    fk_track,
    fk_date,
    playback_timestamp,
    air_temperature,
    _rn,
    measurement_timestamp
from climate_scrobbles
where _rn = 1
