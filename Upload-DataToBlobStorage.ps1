$subscriptionName = "<AzureSubscriptionName>"
$clusterName = "<HDInsightClusterName>"

$sqlDatabaseServerName = "<SQLDatabaseServerName>"
$sqlDatabaseUserName = "<SQLDatabaseDatabaseName>"
$sqlDatabasePassword = "<SQLDatabasePassword>"
$sqlDatabaseDatabaseName = "<SQLDatabaseDatabaseName>"
$tableName = "<SQLDatabaseTableName>"

$hdfsOutputDir = "<OutputPath>"  # This is the HDFS path for the output file, for example "/lineItemData".

Select-AzureSubscription $subscriptionName      
$sqoopDef = New-AzureHDInsightSqoopJobDefinition -Command "import --connect jdbc:sqlserver://$sqlDatabaseServerName.database.windows.net;user=$sqlDatabaseUserName@$sqlDatabaseServerName;password=$sqlDatabasePassword;database=$sqlDatabaseDatabaseName --table $tableName --target-dir $hdfsOutputDir -m 1" 

$sqoopJob = Start-AzureHDInsightJob -Cluster $clusterName -JobDefinition $sqoopDef #-Debug -Verbose
Wait-AzureHDInsightJob -WaitTimeoutInSeconds 3600 -Job $sqoopJob

Write-Host "Standard Error" -BackgroundColor Green
Get-AzureHDInsightJobOutput -Cluster $clusterName -JobId $sqoopJob.JobId -StandardError
Write-Host "Standard Output" -BackgroundColor Green
Get-AzureHDInsightJobOutput -Cluster $clusterName -JobId $sqoopJob.JobId -StandardOutput