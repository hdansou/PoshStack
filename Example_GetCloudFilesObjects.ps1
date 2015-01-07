Clear
$list = Get-CloudFilesContainers -Account demo -RegionOverride ORD
$list[1].Name
Get-CloudFilesObjects -Account demo -Container $list[1].Name -RegionOverride ORD | Format-Table