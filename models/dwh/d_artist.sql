{{ config(materialized="table") }}

with
    distinct_artist_names as (
        select distinct artist_name from {{ ref("stg_lastfm__scrobbles") }}
    )

select {{ dbt_utils.generate_surrogate_key(["artist_name"]) }} as pk_artist, artist_name
from distinct_artist_names
