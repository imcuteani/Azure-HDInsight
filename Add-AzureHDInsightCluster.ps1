# To Provision a cluster
$storageAccountName = "max451demo"
$containerName = "max451blob3e"

$clusterName = "max451"
$location = "West US"
$clusterNodes = 2

#Get the storage account key
$storageAccountKey = Get-AzureStorageKey $storageAccountName | %{$_.Primary}

#Create a new HDInsight cluster
New-AzureHDInsightCluster -Name $clusterName -Location $location -DefaultStorageAccountName "$storageAccountName.blob.core.windows.net" -DefaultStorageAccountKey $storageAccountKey -DefaultStorageContainerName $containerName -ClusterSizeInNodes $clusterNodes