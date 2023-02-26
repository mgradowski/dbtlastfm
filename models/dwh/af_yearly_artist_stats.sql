{{ config(materialized="table") }}

select *
from
    {{
        metrics.calculate(
            [metric("playback_count")],
            grain="year",
            dimensions=["fk_artist"],
        )
    }}
