#List storage accounts for the current subscription

Get-AzureStorageAccount

#List the keys for a storage account
Get-AzureStorageKey -StorageAccountName  "max451demo"

$storageAccountName = "max451demo"
$storageAccountKey =  Get-AzureStorageKey $storageAccountName | %{$_.Primary}
$containerName = "max451blob3e"

$destContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Create a blob Container

New-AzureStorageContainer -Name $containerName -Context $destContext

#upload data to HDInsight 
# Copy the file from local workstation to the Blob container        
Set-AzureStorageBlobContent -File $fileName -Container $containerName -Blob $blobName -context $destContext