Clear

$myList = Get-CloudServers -Account demo -Verbose -Details -RegionOverride DFW
Write-Host $myList.Count "servers found:"
Foreach ($server in $myList)
{
    Write-Host $server.id named $server.Name in $server.Region
}


Get-CloudServerDetails -Account demo -ServerID $myList[0].Id -RegionOverride DFW


Write-Host "Images..."
$images = Get-CloudServerImages -RegionOverride DFW -Details -Account demo -Verbose -ImageType ([net.openstack.Core.Domain.ImageType]::Base) -ImageStatus ([net.openstack.Core.Domain.ImageState]::Active)
Foreach ($image in $images)
{
    Write-Host $image.Id $image.Name
}


#$DebugPreference = "Continue"

Write-Host "Flavors..."
$flavors = Get-CloudServerFlavors -Account demo -Verbose  -Details  -RegionOverride DFW
Foreach ($flavor in $flavors)
{
    Write-Host $flavor.Id
}

Get-CloudServerDetails -ServerID "bb090f6e-31a2-4985-8011-ad1978adf834" -Account demo -RegionOverride DFW
Get-CloudServerVolumes -ServerID "bb090f6e-31a2-4985-8011-ad1978adf834" -Account demo -RegionOverride DFW

#New-CloudServer -Account demo -ServerName "foobardf" -FlavorID $flavors[0].id -ImageID $images[0].id -RegionOverride DFW
Restart-CloudServer -Account demo -ServerId "bb090f6e-31a2-4985-8011-ad1978adf834" -RebootType ([net.openstack.Core.Domain.RebootType]::Hard)   -RegionOverride DFW