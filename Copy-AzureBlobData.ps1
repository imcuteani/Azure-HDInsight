Use-AzureHDInsightCluster max451

$subscriptionName = "Pay-As-You-Go" 
$storageAccountName = "max451demo"
$containerName = "max451blob3e"

$fileName ="E:\HDInsight\thirdeye\demo\max451_details_feb2014week4.txt"
$blobName = "demo\max451_details_feb2014week4.txt"

# Get the storage account key
Select-AzureSubscription $subscriptionName
$storageaccountkey = get-azurestoragekey $storageAccountName | %{$_.Primary}

# Create the storage context object
$destContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageaccountkey

# Copy the file from local workstation to the Blob container        
Set-AzureStorageBlobContent -File $fileName -Container $containerName -Blob $blobName -context $destContext