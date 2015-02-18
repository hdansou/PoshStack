Remove-Module PoshStack 
Import-Module PoshStack
#Get-CloudDatabaseFlavors -Account rackiad
New-CloudDatabaseInstance -Account rackiad -InstanceName "FromPS" -FlavorId "1" -SizeInGB 5 