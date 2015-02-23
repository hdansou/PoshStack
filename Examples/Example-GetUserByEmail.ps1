Remove-module PoshStack
Import-Module PoshStack
$userList = Get-OpenStackIdentityUser -Account rackiad -UserEmail "don.schenck@rackspace.com"
foreach ($u in $userList) {
    Write-Host $u.UserName
}
$user = Get-OpenStackIdentityUser -Account rackiad -UserName "raxschenck"
$user.Email