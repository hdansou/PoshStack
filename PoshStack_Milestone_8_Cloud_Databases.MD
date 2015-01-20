#PoshStack Milestone 8: Cloud Database

## Initial coverage of Cloud Database, to include the following OpenStack.NET SDK functions:

| SDK Method                               | PoshStack cmdlet                       |
|------------------------------------------|----------------------------------------|
| CheckRootEnabledStatusAsync              | Confirm-CloudDatabaseRootEnabledStatus |
| CreateBackupAsync                        | New-CloudDatabaseBackup                |
| CreateDatabaseAsync                      | New-CloudDatabase                      |
| CreateDatabaseInstanceAsync              | New-CloudDatabaseInstance              |
| CreateUserAsync                          | New-CloudDatabaseUser                  |
| EnableRootUserAsync                      | Enable-CloudDatabaseRootUser           |
| GetBackupAsync                           | Get-CloudDatabaseBackup                |
| GetDatabaseInstanceAsync                 | Get-CloudDatabaseInstance              |
| GetFlavorAsync                           | Get-CloudDatabaseFlavor                |
| GetUserAsync                             | Get-CloudDatabaseUser                  |
| GrantUserAccessAsync                     | Grant-CloudDatabaseUserAccess          |
| ListBackupsAsync                         | Get-CloudDatabaseBackups               |
| ListBackupsForInstanceAsync              | Get-CloudDatabaseBackupsForInstance    |
| ListDatabaseInstancesAsync               | Get-CloudDatabaseInstances             |
| ListDatabasesAsync                       | Get-CloudDatabases                     |
| ListDatabaseUsersAsync                   | Get-CloudDatabaseUsers                 |
| ListFlavorsAsync                         | Get-CloudDatabaseFlavors               |
| ListUserAccessAsync                      | Get-CloudDatabaseUserAccess            |
| RemoveBackupAsync                        | Remove-CloudDatabaseBackup             |
| RemoveDatabaseAsync                      | Remove-CloudDatabase                   |
| RemoveDatabaseInstanceAsync              | Remove-CloudDatabaseInstance           |
| RemoveUserAsync                          | Remove-CloudDatabaseUser               |
| ResizeDatabaseInstanceAsync              | Set-CloudDatabaseInstanceSize          |
| ResizeDatabaseInstanceVolumeAsync        | Set-CloudDatabaseInstanceVolumeSize    |
| RestartDatabaseInstanceAsync             | Restart-CloudDatabaseInstance          |
| RevokeUserAccessAsync                    | Revoke-CloudDatabaseUserAccess         |
| SetUserPasswordAsync                     | Set-CloudDatabaseUserPassword          |
| UpdateUserAsync                          | Update-CloudDatabaseUser               |
| GetBaseUriAsync                          | Get-CloudDatabaseBaseUri               |
| WaitForDatabaseInstanceToLeaveStateAsync | Watch-CloudDatabaseInstanceState       |
