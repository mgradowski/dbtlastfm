select
    coalesce(
        mdm_artist_dedup.good_artist_name, scrobbles.raw_artist_name
    ) as artist_name,
    scrobbles.album_title,
    coalesce(
        mdm_track_dedup.good_track_title, scrobbles.raw_track_title
    ) as track_title,
    cast(scrobbles.playback_timestamp as date) as playback_date,
    scrobbles.playback_timestamp,
    row_number() over () as _scrobbleid
from
    {{ source("lastfm", "scrobbles") }} scrobbles
left join
    {{ ref("mdm_artist_dedup") }} mdm_artist_dedup
    on mdm_artist_dedup.bad_artist_name = scrobbles.raw_artist_name
left join
    {{ ref("mdm_track_dedup") }} mdm_track_dedup
    on mdm_track_dedup.artist_name = artist_name
    and mdm_track_dedup.bad_track_title = scrobbles.raw_track_title
where extract(year from "playback_timestamp") between 2020 and 2022
