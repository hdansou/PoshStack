Clear
$myList = Get-CloudServers -Account demo -Verbose -RegionOverride DFW -ServerName GoDevBox
Write-Host $myList.Count "servers found:"
Foreach ($server in $myList)
{
    Write-Host $server.Name in $server.Region
}