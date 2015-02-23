Clear
Remove-Module PoshStack
Import-Module PoshStack
New-OpenStackDatabaseInstance -Account rackiad -InstanceName "FromPS" -FlavorId "2" -SizeInGB 5