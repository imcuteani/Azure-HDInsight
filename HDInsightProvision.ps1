#
# HDInsightProvisionScript.ps1
#
# Create an Azure storage account
$storageAccountName = "<StorageAcccountName>"
$location = "<Microsoft data center>"           # For example, "West US"

New-AzureStorageAccount -StorageAccountName $storageAccountName -Location $location

# List storage accounts for the current subscription
Get-AzureStorageAccount
# List the keys for a storage account
Get-AzureStorageKey <StorageAccountName>

$storageAccountName = "<StorageAccountName>"
$storageAccountKey = Get-AzureStorageKey $storageAccountName | %{ $_.Primary }
$containerName="<ContainerName>"

# Create a storage context object
$destContext = New-AzureStorageContext -StorageAccountName $storageAccountName 
                                       -StorageAccountKey $storageAccountKey  

# Create a Blob storage container
New-AzureStorageContainer -Name $containerName -Context $destContext

#To provision a cluster

$storageAccountName = "<StorageAccountName>"
$containerName = "<ContainerName>"

$clusterName = "<HDInsightClusterName>"
$location = "<MicrosoftDataCenter>"
$clusterNodes = <ClusterSizeInNodes>

# Get the storage account key
$storageAccountKey = Get-AzureStorageKey $storageAccountName | %{ $_.Primary }

# Create a new HDInsight cluster
New-AzureHDInsightCluster -Name $clusterName -Location $location -DefaultStorageAccountName "$storageAccountName.blob.core.windows.net" -DefaultStorageAccountKey $storageAccountKey -DefaultStorageContainerName $containerName  -ClusterSizeInNodes $clusterNodes

To list all clusters in the current subscription

Get-AzureHDInsightCluster 

To show details of the specific cluster in the current subscription

Get-AzureHDInsightCluster -Name <ClusterName> 

Delete a cluster

Use the following command to delete a cluster:

Remove-AzureHDInsightCluster -Name <ClusterName> 

# To submit a MapReduce job

$clusterName = "<HDInsightClusterName>"            

# Define the MapReduce job
$wordCountJobDefinition = New-AzureHDInsightMapReduceJobDefinition -JarFile "wasb:///example/jars/hadoop-examples.jar" -ClassName "wordcount" -Arguments "wasb:///example/data/gutenberg/davinci.txt", "wasb:///example/data/WordCountOutput"

# Run the job and show the standard error 
$wordCountJobDefinition | Start-AzureHDInsightJob -Cluster $clusterName | Wait-AzureHDInsightJob -WaitTimeoutInSeconds 3600 | %{ Get-AzureHDInsightJobOutput -Cluster $clusterName -JobId $_.JobId -StandardError}

# Download MapReduce job output

$storageAccountName = "<StorageAccountName>"   
$containerName = "<ContainerName>"             

# Create the storage account context object
$storageAccountKey = Get-AzureStorageKey $storageAccountName | %{ $_.Primary }
$storageContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey  

# Download the output to local computer
Get-AzureStorageBlobContent -Container $ContainerName -Blob example/data/WordCountOutput/part-r-00000 -Context $storageContext -Force

# Display the output
cat ./example/data/WordCountOutput/part-r-00000 | findstr "there"

# To submit a Hive job

$storageAccountName = "<StorageAccountName>"   
$containerName = "<ContainerName>"             

# Create the storage account context object
$storageAccountKey = Get-AzureStorageKey $storageAccountName | %{ $_.Primary }
$storageContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey  

# Download the output to local computer
Get-AzureStorageBlobContent -Container $ContainerName -Blob example/data/WordCountOutput/part-r-00000 -Context $storageContext -Force

# Display the output
cat ./example/data/WordCountOutput/part-r-00000 | findstr "there"