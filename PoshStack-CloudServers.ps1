<############################################################################################

PoshStack
                                                    NextGen Servers

Authors
-----------
    Don Schenck (don.schenck@rackspace.com)
    
Description
-----------
**TODO**

############################################################################################>


function Get-CloudServers{
    Param(
        [Parameter (Position=0, Mandatory=$True)][string]$Account,
        [Parameter (Position=1, Mandatory=$False)][string]$RegionOverride,
        [Parameter (Position=2, Mandatory=$False)][string]$ImageId,
        [Parameter (Position=3, Mandatory=$False)][string]$FlavorId,
        [Parameter (Position=4, Mandatory=$False)][string]$ServerName
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {
            # Get Identity Provider
            $cloudId    = New-Object net.openstack.Core.Domain.CloudIdentity
            $cloudId.Username = $Credentials.CloudUsername
            $cloudId.APIKey = $Credentials.CloudAPIKey
            $cip        = New-Object net.openstack.Providers.Rackspace.CloudIdentityProvider($cloudId)

            # Get Cloud Servers Provider
            $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider

            if ($RegionOverride)
            {
                $Region = $Global:RegionOverride
            } else {
                $Region = $Credentials.Region
            }

            $ServerList = $cloudServersProvider.ListServersWithDetails($null, $null, $null, $null, $null, $null, $null, $Region, $cloudId)

            # Handling empty response indicating that no servers exist in the queried data center
            if ($ServerList.Count -eq 0) {
                Write-Verbose "You do not currently have any Cloud Servers provisioned in this region."
            }
        elseif($ServerList.Count -ne 0){
            foreach ($server in $ServerList)
            {
                Add-Member -InputObject $server -MemberType NoteProperty -Name Region -Value $Region
            }
    		return $ServerList;
        }
    }
    catch {
        Invoke-Exception($_.Exception)
    }
       
<#
 .SYNOPSIS
 Retrieve all clouod server instances.

 .DESCRIPTION
 The Get-CloudServers cmdlet will display a list of all cloud server instances on a given account in a given cloud region.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshNova configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshNova configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServers -account cloud
 This example shows how to get a list of all servers currently deployed in specified account.

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServers cloudus -RegionOverride ORD
 This example shows how to get a list of all servers currently deployed in specified account in ORD region.

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/List_Servers-d1e2078.html
#>
}
