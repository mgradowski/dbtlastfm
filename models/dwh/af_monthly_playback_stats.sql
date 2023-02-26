{{ config(materialized="table") }}

select *
from
    {{
        metrics.calculate(
            [metric("playback_count")],
            grain="month",
            dimensions=["fk_album", "fk_artist", "fk_track"],
        )
    }}
