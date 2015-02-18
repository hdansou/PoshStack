Remove-Module PoshStack
Import-Module PoshStack
#Get-OpenStackComputeProvider -Account devstack
#Get-OpenStackComputeServerImages -Account devstack -details
#Get-OpenStackComputeServers -Account devstack
Get-OpenStackBlockStorageVolumeTypes -Account rackord | format-wide
Get-OpenStackBlockStorageVolumes -Account rackdfw | format-list
#New-CloudBlockStorageVolume -Account rackdfw -size 100 -VolumeType SSD