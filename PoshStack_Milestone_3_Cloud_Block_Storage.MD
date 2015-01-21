#PoshStack Milestone 3: Cloud Block Storage

## Initial coverage of Cloud Block Storage, to include the following OpenStack.NET SDK functions:

| SDK Method                  | PoshStack cmdlet                         |
|-----------------------------|------------------------------------------|
| CreateSnapshot              | New-CloudBlockStorageSnapshot            |
| CreateVolume                | New-CloudBlockStorageVolume              |
| DeleteSnapshot              | Remove-CloudBlockStorageSnapshot         |
| DeleteVolume                | Remove-CloudBlockStorageVolume           |
| DescribeVolumeType          | Get-CloudBlockStorageVolumeTypeInfo      |
| ListSnapshots               | Get-CloudBlockStorageSnapshots           |
| ListVolumes                 | Get-CloudBlockStorageVolumes             |
| ListVolumeTypes             | Get-CloudBlockStorageVolumeTypes         |
| ShowSnapshot                | Get-CloudBlockStorageSnapshot            |
| ShowVolume                  | Get-CloudBlockStorageVolume              |
| WaitForSnapshotAvailable    | Watch-CloudBlockStorageSnapshotAvailable |
| WaitForVolumeAvailable      | Watch-CloudBlockStorageVolumeAvailable   |
| WaitForVolumeDeleted        | Watch-CloudBlockStorageVolumeDeleted     |
| WaitForVolumeState          | Watch-CloudBlockStorageVolumeState       |
