Remove-Module PoshStack
Import-Module PoshStack
try {
    Get-OpenStackComputeServerImage -Account rackiad -imageid foo
} catch {
    Echo "Not found"
}
