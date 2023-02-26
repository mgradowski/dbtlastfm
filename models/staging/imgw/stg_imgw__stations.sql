select "full_code", "name", "short_code",
from
    {{ source("imgw", "stations") }} climate
