Clear
$list = Get-OpenStackObjectStorageContainers -Account rackiad -RegionOverride ORD
$list[1].Name
Get-OpenStackObjectStorageObjects -Account rackiad -Container $list[1].Name -RegionOverride ORD | Format-Table