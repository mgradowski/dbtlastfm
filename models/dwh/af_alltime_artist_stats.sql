{{ config(materialized="table") }}

select *
from
    {{
        metrics.calculate(
            [metric("playback_count"), metric("discovery_date")],
            dimensions=["fk_artist"],
        )
    }}
