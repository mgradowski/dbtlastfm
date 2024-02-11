{{ config(materialized="table") }}

select
    f_playback.fk_track,
    count(*) as playback_count,
    min(playback_timestamp) as discovery_date,
    max(playback_timestamp) as last_playback,
from {{ ref("f_playback") }}
group by f_playback.fk_track
