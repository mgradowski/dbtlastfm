{{ config(materialized="table") }}

with
    distinct_albums as (
        select distinct artist_name, album_title from {{ ref("stg_lastfm__scrobbles") }}
    )

select
    {{ dbt_utils.generate_surrogate_key(["artist_name", "album_title"]) }} as pk_album,
    {{ dbt_utils.generate_surrogate_key(["artist_name"]) }} as fk_artist,
    album_title
from distinct_albums
