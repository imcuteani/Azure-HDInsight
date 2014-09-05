# Provide Azure subscription name, and the Azure Storage account and container that is used for the default HDInsight file system.
$subscriptionName = "Pay-As-You-Go"
$storageAccountName = "max451demo"
$containerName = "max451blob3e"

# Provide HDInsight cluster name Where you want to run the Hive job
$clusterName = "max451"

# HiveQL queries
# Use the internal table option. 
$queryString = "LOAD DATA INPATH 'wasb://$containerName@$storageAccountName.blob.core.windows.net/demo/max451_details_feb2014week4.txt' INTO TABLE max451_data;" 

# Use the external table option. 
#$queryString = "DROP TABLE log4jLogs;" +
              #  "CREATE EXTERNAL TABLE log4jLogs(t1 string, t2 string, t3 string, t4 string, t5 string, t6 string, t7 string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' STORED AS TEXTFILE LOCATION 'wasb://$containerName@$storageAccountName.blob.core.windows.net/example/data/';" +
              #  "SELECT t4 AS sev, COUNT(*) AS cnt FROM log4jLogs WHERE t4 = '[ERROR]' GROUP BY t4;"