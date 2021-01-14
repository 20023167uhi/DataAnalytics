-- ## Code for Tutorial 1
-- ## 1.1 Making a query

-- SELECT * FROM `bigquery-public-data.new_york.tlc_yellow_trips_2009` LIMIT 10
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2009`
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2009` WHERE stn='725060' AND wban='14704'

-- ## 1.2 Collating data

-- #standardSql
-- CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count`
-- AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
-- FROM `bigquery-public-data.new_york.tlc_yellow_trips_2009`
-- GROUP BY pickup_date
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2009` WHERE stn='725060' and wban='14704'

-- SELECT * FROM `uhi-project-20023167.tutorial_1.taxi_data_count`;

-- CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final`
-- AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
-- FROM `uhi-project-20023167.tutorial_1.taxi_data_count` 

-- SELECT * FROM `uhi-project-20023167.tutorial_1.taxi_count_final` 

-- CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data`
-- AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
-- FROM `bigquery-public-data.noaa_gsod.gsod2009` WHERE stn='724060' ORDER BY mo, da;

-- SELECT * FROM `uhi-project-20023167.tutorial_1.weather_data` 

-- CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data`
-- as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final`  as complaints where complaints.pickup_date = weather.date

-- SELECT * FROM `uhi-project-20023167.tutorial_1.collated_taxi_data` order by mo, da;

-- ## 1.3 Save Results

-- ## 1.4 Merging multiple time series data

-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2009` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2010` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2010` WHERE stn='725060' AND (wban='14704' OR wban='94728')
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2011` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2012` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2013` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2014` WHERE stn='725060' AND wban='14756'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2015` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2016` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2017` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2018` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2019` WHERE stn='725060'
-- SELECT * FROM `bigquery-public-data.noaa_gsod.gsod2020` WHERE stn='725060'

-- CREATE VIEW `uhi-project-20023167.tutorial_1.weather_2009_to_2011` AS
-- SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
-- FROM `bigquery-public-data.noaa_gsod.gsod2009` WHERE stn='725060'
-- union all
-- SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
-- FROM `bigquery-public-data.noaa_gsod.gsod2010` WHERE stn='725060' AND (wban='14704' OR wban='94728')
-- union all
-- SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
-- FROM `bigquery-public-data.noaa_gsod.gsod2011` WHERE stn='725060'
-- ORDER BY year, mo, da;

-- SELECT * FROM `uhi-project-20023167.tutorial_1.weather_2009_to_2011` 

-- ## Challenge 1

-- Collating 2009 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2009`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2009`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2009`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2009`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2009`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2009` WHERE stn='724060' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2009`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2009` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2009`  as complaints where complaints.pickup_date = weather.date;


-- Collating 2010 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2010`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2010`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2010`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2010`;

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2010`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2010` WHERE stn='724060' AND (wban='14704' OR wban='94728') ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2010`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2010` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2010`  as complaints where complaints.pickup_date = weather.date;


-- Collating 2011 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2011`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2011`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2011`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2011`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2011`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2011` WHERE stn='724060' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2011`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2011` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2011`  as complaints where complaints.pickup_date = weather.date;


-- Collating 2012 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2012`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2012`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2012`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2012`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2012`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2012` WHERE stn='724060' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2012`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2012` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2012`  as complaints where complaints.pickup_date = weather.date;


--  Collating 2013 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2013`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2013`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2013`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2013`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2013`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2013` WHERE stn='724060' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2013`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2013` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2013`  as complaints where complaints.pickup_date = weather.date;


--  Collating 2014 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2014`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2014`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2014`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2014`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2014`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2014` WHERE stn='724060' AND wban='14756' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2014`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2014` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2014`  as complaints where complaints.pickup_date = weather.date;


--  Collating 2015 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2015`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2015`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2015`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2015`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2015`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2015` WHERE stn='724060' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2015`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2015` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2015`  as complaints where complaints.pickup_date = weather.date;


--  Collating 2016 data 
------------------------------------------------------------------------
CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_data_count_2016`
AS SELECT CAST(pickup_datetime as DATE) as pickup_date, COUNT(CAST(pickup_datetime as DATE)) AS NUM_TRIPS
FROM `bigquery-public-data.new_york.tlc_yellow_trips_2016`
GROUP BY pickup_date;

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi_count_final_2016`
AS SELECT FORMAT_DATE("%u", pickup_date) as day, pickup_date, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.taxi_data_count_2016`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.weather_data_2016`
AS SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as date, year, mo, da, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog
FROM `bigquery-public-data.noaa_gsod.gsod2016` WHERE stn='724060' ORDER BY mo, da;

CREATE TABLE `uhi-project-20023167.tutorial_1.collated_taxi_data_2016`
as SELECT day, year, mo, da, pickup_date, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS FROM `uhi-project-20023167.tutorial_1.weather_data_2016` as weather, `uhi-project-20023167.tutorial_1.taxi_count_final_2016`  as complaints where complaints.pickup_date = weather.date;


--  Merging the data by years
------------------------------------------------------------------------
SELECT * FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2009`; 

CREATE VIEW `uhi-project-20023167.tutorial_1.taxi-weather_2009_to_2016` AS
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2009`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2010`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2011`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2012`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2013`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2014`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2015`
union all
SELECT DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) as pickup_date, year, mo, da, day, temp, dewp, slp, visib, wdsp, mxpsd, gust, max, min, prcp, sndp, fog, NUM_TRIPS
FROM `uhi-project-20023167.tutorial_1.collated_taxi_data_2016`
ORDER BY year, mo, da;

SELECT * FROM `uhi-project-20023167.tutorial_1.taxi-weather_2009_to_2016`; 