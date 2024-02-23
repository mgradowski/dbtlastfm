#!/bin/sh

set -e

mkdir -p target
duckdb -echo target/dbtlastfm.duckdb <<-EOSQL
    create schema if not exists rawdata_lastfm;

    create or replace table rawdata_lastfm.scrobbles as
        select
            *
        from
            read_csv(
                "rawdata/lastfm/*.csv",
                columns = {
                    'raw_artist_name':'varchar',
                    'album_title':'varchar',
                    'raw_track_title':'varchar',
                    'playback_timestamp':'timestamp'
                },
                timestampformat = '%-d %b %Y %H:%M'
            );

    create schema if not exists rawdata_imgw;

    create or replace table rawdata_imgw.climate as
        select
            *
        from
            read_csv(
                "rawdata/imgw/climate/*.csv",
                columns = {
                    'station_full_code':'varchar',
                    'station_name':'varchar',
                    'year':'varchar',
                    'month':'varchar',
                    'day':'varchar',
                    'hour':'varchar',
                    'air_temperature':'decimal(6, 1)',
                    'air_temperature_status_indicator':'varchar',
                    'wet_bulb_temperature':'varchar',
                    'wet_bulb_temperature_status_indicator':'varchar',
                    'ice_indicator':'varchar',
                    'ventilation_indicator':'varchar',
                    'relative_humidity':'decimal(6, 1)',
                    'relative_humidity_status_indicator':'varchar',
                    'wind_direction_code':'varchar',
                    'wind_direction_status_indicator':'varchar',
                    'wind_speed':'decimal(6, 1)',
                    'wind_speed_indicator':'varchar',
                    'cloudiness':'decimal(6, 1)',
                    'cloudiness_status_indicator':'varchar',
                    'visibility_code':'varchar',
                    'visibility_status_indicator':'varchar',
                }
            );

    create or replace table rawdata_imgw.stations as
        select
            *
        from
            read_csv(
                "rawdata/imgw/stations/*.csv",
                columns = {'full_code':'varchar', 'name':'varchar', 'short_code':'varchar'}
            );
    
EOSQL
