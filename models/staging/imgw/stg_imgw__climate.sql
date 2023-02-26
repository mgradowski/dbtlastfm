select
    *,
    strptime("year" || "month" || "day" || "hour", '%Y%m%d%H') as measurement_timestamp,
    cast(measurement_timestamp as date) as measurement_date,
from {{ source("imgw", "climate") }} climate
