# Create the encrypted key file
$KeyFile = Read-Host -Prompt "Enter secure key file Ex. serviceAPI.key"
$EncryptedStorageKey = Read-Host -Prompt "Enter Storage Key" -AsSecureString
ConvertFrom-SecureString $EncryptedStorageKey | Set-Content $KeyFile

# Example: Use the encrypted key file to authenticate to an Azure Storage Account
# $KeyFile = 'Path\to\secured.key'
# $StorageAccountName = 'MyStorageAccount1'
# $StorageContainerName = "MyContainer1"
# $EncryptedStorageKey = Get-Content $KeyFile | ConvertTo-SecureString
# $DecryptedKey = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($EncryptedStorageKey))
# $StorageContext = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $DecryptedKey
# Copy everything under $SourcePath to $StorageContext $StorageContainer
# $SourcePath = "Path\to\data\to\copy\to\blob"
# Get-ChildItem -File -Recurse $SourcePath | Set-AzStorageBlobContent -Context $StorageContext -Container $StorageContainerName
