Remove-Module PoshStack
Import-Module PoshStack
$ListOfInstances = Get-CloudDatabaseInstances -Account rackiad
foreach ($Instance in $ListOfInstances) {
    $Instance.Id
}