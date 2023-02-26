{{ config(materialized="table") }}

with distinct_albums as (
    select distinct
        artist
        ,album
    from
        {{ ref("stg_lastfm__scrobbles") }}
)
select
    {{ dbt_utils.generate_surrogate_key(["artist", "album"]) }} as pk_album
    ,{{ dbt_utils.generate_surrogate_key(["artist"]) }} as fk_artist
    ,"album" as album_title
from
    distinct_albums
