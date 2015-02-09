Clear
Remove-Module PoshStack
Import-Module PoshStack

$testDevStackCompute = Get-ComputeProvider -Account devstack
#Get-ComputeServerImages -Account devstack -Details
Get-ComputeServerFlavors -Account devstack -Details

$testRackspaceCompute = Get-ComputeProvider -Account rackIad
#Get-ComputeServerImages -Account rackIad -Details
Get-ComputeServerFlavors -Account rackIad -Details 
#Get-ComputeServers -Account rackiad