Clear

$myList = Get-CloudServers -Account demo -Verbose -RegionOverride DFW 
Write-Host $myList.Count "servers found:"
Foreach ($server in $myList)
{
    Write-Host $server.id in $server.Region
}


$images = Get-CloudServerImages -Account demo -Verbose
Foreach ($image in $images)
{
    Write-Host $image.Id
}

$flavors = Get-CloudServerFlavors -Account demo -Verbose
Foreach ($flavor in $flavors)
{
    Write-Host $flavor.Id
}

Get-CloudServerDetails -ServerID "be1e9849-681c-435b-beb9-4f62026779f3" -Account demo -RegionOverride DFW