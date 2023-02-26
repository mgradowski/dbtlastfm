{{ config(materialized="table") }}

select
    {{ dbt_utils.generate_surrogate_key(["artist"]) }} as fk_artist
    ,{{ dbt_utils.generate_surrogate_key(["artist", "album"]) }} as fk_album
    ,{{ dbt_utils.generate_surrogate_key(["artist", "track"]) }} as fk_track
    ,extract(year from "time")  * 10000
    +extract(month from "time") * 100
    +extract(day from "time") as fk_date
    ,"time" as playback_timestamp
from
    {{ ref("stg_lastfm__scrobbles") }}
