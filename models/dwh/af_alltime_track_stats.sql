{{ config(materialized="table") }}

select *
from
    {{
        metrics.calculate(
            [
                metric("playback_count"),
                metric("discovery_date"),
                metric("days_known"),
                metric("playback_frequency"),
            ],
            dimensions=["fk_track"],
        )
    }}
