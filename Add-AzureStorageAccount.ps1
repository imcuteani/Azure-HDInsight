# Create an Azure storage account

$storageAccountName = "max451demo"
$location = "West US"

New-AzureStorageAccount -StorageAccountName $storageAccountName -Location $location 

