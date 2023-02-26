{{ config(materialized="table") }}

with distinct_tracks as (
    select distinct
        artist
        ,track
    from
        {{ ref("stg_lastfm__scrobbles") }}
)
select
    {{ dbt_utils.generate_surrogate_key(["artist", "track"]) }} as pk_track
    ,{{ dbt_utils.generate_surrogate_key(["artist"]) }} as fk_artist
    ,track as track_title
from
    distinct_tracks
