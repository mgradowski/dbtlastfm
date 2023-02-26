{{ config(materialized="table") }}

with distinct_artist_names as (
    select distinct
        artist
    from
        {{ ref("stg_lastfm__scrobbles") }}
)
select
    {{ dbt_utils.generate_surrogate_key(["artist"]) }} as pk_artist
    ,artist as artist_name
from
    distinct_artist_names
