PoshStack Milestone 2

Initial coverage of Cloud Files, to include the following OpenStack.NET SDK functions:

| SDK Method                  | PoshStack cmdlet                      |
|-----------------------------|---------------------------------------|
| BulkDelete                  | Remove-CloudFilesObjects              |
| CopyObject                  | Copy-CloudFilesObject                 |
| CreateContainer             | New-CloudFilesContainer               |
| CreateObject                | Add-CloudFilesObject                  |
| CreateObjectFromFile        | Add-CloudFilesObject                  |
| DeleteContainer             | Remove-CloudFilesContainer            |
| DeleteContainerMetadata     | Remove-CloudFilesContainerMetadata    |
| DeleteObject                | Remove-CloudFilesObject               |
| DeleteObjectMetadata        | Remove-CloudFilesObjectMetadata       |
| DeleteObjects               | Remove-CloudFilesObjects              |
| DisableCDNOnContainer       | Disable-CloudFilesContainerCDN        |
| DisableStaticWebOnContainer | Disable-CloudFilesStaticWebOnContainer|
| EnableCDNOnContainer        | Enable-CloudFilesContainerCDN         |
| EnableStaticWebOnContainer  | Enable-CloudFilesStaticWebOnContainer |
| GetContainerCDNHeader       | Get-CloudFilesContainerCDNHeader      |
| GetContainerHeader          |	Get-CloudFilesContainerHeader         |
| GetContainerMetaData        |	Get-CloudFilesContainerMetaData       |
| GetObject                   |	Get-CloudFilesObject                  |
| GetObjectHeaders            |	Get-CloudFilesObjectHeaders           |
| GetObjectMetaData           |	Get-CloudFilesObjectMetaData          |
| GetObjectSaveToFile         |	Copy-CloudFileObjectToFile            |
| ListCDNContainers           |	Get-CloudFilesContainers -CDN         |
| ListContainers              |	Get-CloudFilesContainers              |
| ListObjects                 |	Get-CloudFilesObjects                 |
| MoveObject                  |	Move-CloudFilesObject                 |
| PurgeObjectFromCDN          |	Clear-CloudFilesObjectFromCDN         |
| UpdateContainerCdnHeaders   |	Update-CloudFilesContainerCDNHeaders  |
| UpdateContainerMetadata     |	Update-CloudFilesContainerMetaData    |
| UpdateObjectMetadata        |	Update-CloudFilesObjectMetaData       |
| VerifyContainerIsCDNEnabled |	Test-CloudFilesContainerCDNEnabled    |
