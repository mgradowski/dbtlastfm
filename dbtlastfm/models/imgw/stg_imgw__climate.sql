select
    "station_full_code",
    "station_name",
    "year",
    "month",
    "day",
    "air_temperature",
    "air_temperature_status_indicator",
    "wet_bulb_temperature",
    "wet_bulb_temperature_status_indicator",
    "ice_indicator",
    "ventilation_indicator",
    "relative_humidity",
    "relative_humidity_status_indicator",
    "wind_direction_code",
    "wind_direction_status_indicator",
    "wind_speed",
    "wind_speed_indicator",
    "cloudiness",
    "cloudiness_status_indicator",
    "visibility_code",
    "visibility_status_indicator"
from
    read_csv(
        "../rawdata/imgw/climate/*.csv",
        columns = {
            'station_full_code': 'varchar',
            'station_name': 'varchar',
            'year': 'varchar',
            'month': 'varchar',
            'day': 'varchar',
            'hour': 'varchar',
            'air_temperature': 'decimal(6, 1)',
            'air_temperature_status_indicator': 'varchar',
            'wet_bulb_temperature': 'varchar',
            'wet_bulb_temperature_status_indicator': 'varchar',
            'ice_indicator': 'varchar',
            'ventilation_indicator': 'varchar',
            'relative_humidity': 'decimal(6, 1)',
            'relative_humidity_status_indicator': 'varchar',
            'wind_direction_code': 'varchar',
            'wind_direction_status_indicator': 'varchar',
            'wind_speed': 'decimal(6, 1)',
            'wind_speed_indicator': 'varchar',
            'cloudiness': 'decimal(6, 1)',
            'cloudiness_status_indicator': 'varchar',
            'visibility_code': 'varchar',
            'visibility_status_indicator': 'varchar',
        }
    )
