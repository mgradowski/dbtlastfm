{{ config(materialized="table") }}

with
    distinct_tracks as (
        select distinct artist_name, track_title from {{ ref("stg_lastfm__scrobbles") }}
    )
select
    {{ dbt_utils.generate_surrogate_key(["artist_name", "track_title"]) }} as pk_track,
    {{ dbt_utils.generate_surrogate_key(["artist_name"]) }} as fk_artist,
    track_title
from distinct_tracks
