Add-AzureAccount '<azureaccountname>'

# Provide Azure subscription name, and the Azure Storage account and container that is used for the default HDInsight file system.
$subscriptionName = "<SubscriptionName>"
$storageAccountName = "<AzureStorageAccountName>"
$containerName = "<AzureStorageContainerName>"

# Provide HDInsight cluster name Where you want to run the Hive job
$clusterName = "<HDInsightClusterName>"

# HiveQL queries
# Use the internal table option. 
$queryString = "DROP TABLE AnalyticsLogs;" +
               "CREATE TABLE AnalyticsLogs(t1 string, t2 string, t3 string, t4 string, t5 string, t6 string, t7 string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ';" +
               "LOAD DATA INPATH 'wasb://$containerName@$storageAccountName.blob.core.windows.net/example/data/sample.log' OVERWRITE INTO TABLE AnalyticsLogs;" +
               "SELECT t4 AS sev, COUNT(*) AS cnt FROM log4jLogs WHERE t4 = '[ERROR]' GROUP BY t4;"

# Use the external table option. 
$queryString = "DROP TABLE AnalyticsLogs;" +
                "CREATE EXTERNAL TABLE AnalyticsLogs(t1 string, t2 string, t3 string, t4 string, t5 string, t6 string, t7 string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' STORED AS TEXTFILE LOCATION 'wasb://$containerName@$storageAccountName.blob.core.windows.net/example/data/';" +
                "SELECT t4 AS sev, COUNT(*) AS cnt FROM AnalyticsLogs WHERE t4 = '[ERROR]' GROUP BY t4;"

# Create a Hive job definition 
$hiveJobDefinition = New-AzureHDInsightHiveJobDefinition -Query $queryString 

Use-AzureHDInsightCluster $clusterName
Invoke-Hive -Query $hiveQL
