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

function Get-CloudServerFlavors {
    Param(
        [Parameter (Position=0, Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Position=1, Mandatory=$False)][string]$RegionOverride,
        [Parameter (Position=2, Mandatory=$False)][int]   $MinDiskInGB,
        [Parameter (Position=3, Mandatory=$False)][int]   $MinRamInMB,
        [Parameter (Position=4, Mandatory=$False)][string]$MarkerId,
        [Parameter (Position=5, Mandatory=$False)][int]   $Limit
    )

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {
        # Get Identity Provider
        $cloudId = New-Object net.openstack.Core.Domain.CloudIdentity
        $cloudId.Username = $Credentials.CloudUsername
        $cloudId.APIKey   = $Credentials.CloudAPIKey
        $cip     = New-Object net.openstack.Providers.Rackspace.CloudIdentityProvider($cloudId)

        # Get Cloud Servers Provider
        $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider

                # Use Region code associated with Account, or was an override provided?
            if ($RegionOverride)
            {
                $Region = $Global:RegionOverride
            } else {
                $Region = $Credentials.Region
            }
            # DEBUGGING             
            Write-Debug -Message "ImageId.....: $ImageId"
            Write-Debug -Message "Region......: $Region"



            # If limit is not specified, it will be zero, which should be 999
            if ($Limit -le 0)
            {
                $Limit = 9999
            }


            # Get the list of Flavors
            $FlavorList = $cloudServersProvider.ListFlavorsWithDetails($MinDiskInGB, $MinRamInMB, $MarkerId, $Limit, $Region, $cloudId)


            # Handling empty response indicating that no servers exist in the queried data center
            if ($FlavorList.Count -eq 0) {
                Write-Verbose "No Images found in region '$Region'."
            }
        elseif($FlavorList.Count -ne 0){
    		return $FlavorList;
        }
    }
    catch {
        Invoke-Exception($_.Exception)
    }
}

function Get-CloudServerImages {
    
    Param(
        [Parameter (Position=0, Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Position=1, Mandatory=$False)][string]$RegionOverride,
        [Parameter (Position=2, Mandatory=$False)][string]$ImageId
    )

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {
            # Get Identity Provider
            $cloudId    = New-Object net.openstack.Core.Domain.CloudIdentity
            $cloudId.Username = $Credentials.CloudUsername
            $cloudId.APIKey   = $Credentials.CloudAPIKey
            $cip        = New-Object net.openstack.Providers.Rackspace.CloudIdentityProvider($cloudId)

            # Get Cloud Servers Provider
            $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


            # Use Region code associated with Account, or was an override provided?
            if ($RegionOverride)
            {
                $Region = $Global:RegionOverride
            } else {
                $Region = $Credentials.Region
            }



            # DEBUGGING             
            Write-Debug -Message "ImageId.....: $ImageId"
            Write-Debug -Message "Region......: $Region"


            # Get the list of Images
            $Server = $null #string
            $ImageName = $null #string
            $ImageStatus = $null #ImageState
            $ChangesSince = $null #DateTimeOffset
            $MarkerId = $null #string
            $Limit = 9999 #int
            $ImageType = $null #ImageType
            $Region = $Region
            

            $ImageList = $cloudServersProvider.ListImagesWithDetails($Server, $ImageName, $ImageStatus, $ChangesSince, $MarkerId, $Limit, $ImageType, $Region, $cloudId)


            # Handling empty response indicating that no servers exist in the queried data center
            if ($ImageList.Count -eq 0) {
                Write-Verbose "No Images found in region '$Region'."
            }
        elseif($ImageList.Count -ne 0){
    		return $ImageList;
        }
    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 List available Cloud Server base OS and user images.

 .DESCRIPTION
 The Get-CloudServerImages cmdlet will retreive a list of all Rackspace Cloud Server image snapshots for a given account, including Rackspace's base OS images.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshNova configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshNova configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages -Account prod
 This example shows how to get a list of all available images in the account prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages cloudus -RegionOverride DFW
 This example shows how to get a list of all available images for cloudus account in DFW region

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Images-d1e4427.html
#>
}

function Get-CloudServers{

    [CmdletBinding()]

    Param(
        [Parameter (Position=0, Mandatory=$True)] [string]$Account,
        [Parameter (Position=1, Mandatory=$False)][string]$RegionOverride,
        [Parameter (Position=2, Mandatory=$False)][string]$ImageId,
        [Parameter (Position=3, Mandatory=$False)][string]$FlavorId,
        [Parameter (Position=4, Mandatory=$False)][string]$ServerName,
        [Parameter (Position=5, Mandatory=$False)][object]$ServerState,
        [Parameter (Position=6, Mandatory=$False)][string]$MarkerId,
        [Parameter (Position=7, Mandatory=$False)][int]   $Limit,
        [Parameter (Position=8, Mandatory=$False)][object]$ChangesSince
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {
            # Get Identity Provider
            $cloudId    = New-Object net.openstack.Core.Domain.CloudIdentity
            $cloudId.Username = $Credentials.CloudUsername
            $cloudId.APIKey   = $Credentials.CloudAPIKey
            $cip        = New-Object net.openstack.Providers.Rackspace.CloudIdentityProvider($cloudId)

            # Get Cloud Servers Provider
            $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


            # Use Region code associated with Account, or was an override provided?
            if ($RegionOverride)
            {
                $Region = $Global:RegionOverride
            } else {
                $Region = $Credentials.Region
            }


            # If limit is not specified, it will be zero, which should be 999
            if ($Limit -le 0)
            {
                $Limit = 9999
            }


            # DEBUGGING             
            Write-Debug -Message "ImageId.....: $ImageId"
            Write-Debug -Message "FlavorId....: $FlavorId"
            Write-Debug -Message "ServerName..: $ServerName"
            Write-Debug -Message "ServerState.: $ServerState"
            Write-Debug -Message "MarkerId....: $MarkerId"
            Write-Debug -Message "Limit.......: $Limit"
            Write-Debug -Message "ChangesSince: $ChangesSince"
            Write-Debug -Message "Region......: $Region"


            # Get the list of servers
            $ServerList = $cloudServersProvider.ListServersWithDetails($ImageId, $FlavorId, $ServerName, $ServerState, $MarkerId, $Limit, $ChangesSince, $Region, $cloudId)


            # Handling empty response indicating that no servers exist in the queried data center
            if ($ServerList.Count -eq 0) {
                Write-Verbose "You do not currently have any Cloud Servers provisioned in region '$Region'."
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
 Retrieve all cloud server instances for a Region.

 .DESCRIPTION
 The Get-CloudServers cmdlet will display a list of all cloud server instances on a given account in a given cloud region.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshNova configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshNova configuration file. 

 .PARAMETER ImageId
 This parameter will limit the results to only those servers with a matching Image Id.

 .PARAMETER FlavorId
 This parameter will limit the results to only those servers with a matching Flavor Id.

 .PARAMETER ServerName
 This parameter will limit the results to only those servers whose name contains this string.

 .PARAMETER ServerState
 This parameter will limit the results to only those servers in this state, e.g. Rebooting.

 .PARAMETER MarkerId
 This parameter allows you to page forward through the list by using a marker.

 .PARAMETER Limit
 This parameter allows you to limit the number of results.

 .PARAMETER ChangesSince
 This parameter will limit the results to only those servers who have been changed since this date and time.


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

function Get-CloudServerDetails {

    Param(
        #[Parameter(Position=0,Mandatory=$false)][switch]$Bandwidth,
        [Parameter(Position=1,Mandatory=$true)][string]$ServerID = $(throw "Please specify required server ID with -ServerID parameter"),
        [Parameter(Position=2,Mandatory=$true)][string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Position=3, Mandatory=$False)][string]$RegionOverride
    )

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

            # Get Identity Provider
            $cloudId    = New-Object net.openstack.Core.Domain.CloudIdentity
            $cloudId.Username = $Credentials.CloudUsername
            $cloudId.APIKey   = $Credentials.CloudAPIKey
            $cip        = New-Object net.openstack.Providers.Rackspace.CloudIdentityProvider($cloudId)

            # Get Cloud Servers Provider
            $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


            # Use Region code associated with Account, or was an override provided?
            if ($RegionOverride)
            {
                $Region = $Global:RegionOverride
            } else {
                $Region = $Credentials.Region
            }


            # DEBUGGING             
            Write-Debug -Message "ServerID: $ServerID"
            Write-Debug -Message "Region..: $Region"


            # Get the list of servers
            return $cloudServersProvider.GetDetails($ServerID, $Region, $cloudId)

<#
 .SYNOPSIS
 The Get-CloudServerDetails cmdlet will pull down a list of detailed information for a specific Rackspace Cloud Server.

 .DESCRIPTION
 This command is executed against one given cloud server ID, which in turn will return explicit details about that server without any other server data.

 .PARAMETER Bandwidth
 NOT IMPLEMENTED YET - Use this parameter to indicate that you'd like to see bandwidth statistics of the server ID passed to powershell.

 .PARAMETER CloudServerID
 Use this parameter to specify Cloud Server UUID, details of which you want query. Run the "Get-CloudServers" cmdlet for a complete listing of servers.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshNova configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshNova configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -CloudServerID abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to get explicit data about one cloud server from the account Prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -CloudServerID abc123ef-9876-abcd-1234-123456abcdef -Account Dev -Bandwidth 
 NOT IMPLEMENTED YET - This example shows how to get explicit data about one cloud server from account Dev, including bandwidth statistics.

 PS C:\Users\mitch.robins> Get-CloudServerDetails -CloudServerID abc123ef-9876-abcd-1234-123456abcdef -Account Prod

    Server Status:  ACTIVE 
    Server Name:  AA-Mongo 
    Server ID:  abc123ef-9876-abcd-1234-123456abcdef
    Server Created:  2013-03-11T16:09:15Z 
    Server Last Updated:  2013-03-11T16:14:27Z 
    Server Image ID:  8a3a9f96-b997-46fd-b7a8-a9e740796ffd 
    Server Flavor ID:  4 
    Server IPv4:  100.100.100.100
    Server IPv6:  2001:::::::15d0 
    Server Build Progress:  100 

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Get_Server_Details-d1e2623.html
#>
}
