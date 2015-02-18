Remove-Module PoshStack
Import-Module PoshStack
$dbiid = new-object -TypeName net.openstack.Providers.Rackspace.Objects.Databases.DatabaseInstanceId "f20e701d-93e9-4a06-bab1-65368552ae15"
$dbconfig = new-object -TypeName net.openstack.Providers.Rackspace.Objects.Databases.DatabaseConfiguration "database_name"
New-CloudDatabase -Account rackiad -DBInstanceId $dbiid -DBConfiguration $dbconfig -RegionOverride IAD 
