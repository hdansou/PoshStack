Remove-Module PoshStack
Import-Module PoshStack
Get-ComputeProvider -Account devstack
Get-ComputeServerImages -Account devstack -details
Get-ComputeServers -Account devstack
Get-CloudBlockStorageVolumeTypes -Account rackord | format-wide
Get-CloudBlockStorageVolumes -Account rackdfw | format-list
#New-CloudBlockStorageVolume -Account rackdfw -size 100 -VolumeType SSD