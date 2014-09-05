Use-AzureHDInsightCluster max451

Invoke-Hive "select to_date(date_time), campaign, channel, count(*) from max451_data group by to_date(date_time), campaign, channel;"

Invoke-Hive "select to_date(date_time), geo_city, geo_zip, count(*) from max451_data group by to_date(date_time), geo_city, geo_zip;"

