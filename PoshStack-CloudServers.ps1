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

#CloudServersProvider.AttachServerVolume
function Add-CloudServerVolume{
    Param(
        [Parameter (Position=0, Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Position=1, Mandatory=$True)][string] $ServerId = $(throw "Server ID is required"),
        [Parameter (Position=2, Mandatory=$True)][string] $VolumeId = $(throw "Volume ID is required"),
        [Parameter (Position=3, Mandatory=$False)][string] $StorageDevice,
        [Parameter (Position=4, Mandatory=$False)][string] $RegionOverride
        )
}
#ChangeAdministratorPassword
#ConfirmServerResize
#CreateImage
#CreateServer
#CreateVirtualInterface
#DeleteImage
#DeleteImageMetadataItem
#DeleteServer
#DeleteVirtualInterface
#DetachServerVolume
#GetDetails
#GetFlavor
#GetImage
#GetImageMetadataItem
#GetServerMetadataItem
#GetServerVolumeDetails
#ListAddresses
#ListAddressesByNetwork
#ListFlavors
#ListFlavorsWithDetails
#ListImageMetadata
#ListImages
#ListImagesWithDetails
#ListServerMetadata
#ListServers
#ListServerWithDetails
#ListServerVolumes
#ListVirtualInterfaces
#RebootServer
#RebuildServer
#ResizeServer
#RevertServerResize
#SetImageMetadata
#SetImageMetadataItem
#UnRescueServer
#UpdateImageMetadata
#UpdateServer
#UpdateServerMetadata
#WaitForImageActive
#WaitForImageState
#WaitForServerActive
#WaitForServerDeleted
#WaitForServerState

#ListFlavors
#ListFlavorsWithDetails
function Get-CloudServerFlavors {
    Param(
        [Parameter (Position=0, Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Position=1, Mandatory=$False)][string]$RegionOverride,
        [Parameter (Position=2, Mandatory=$False)][int]   $MinDiskInGB,
        [Parameter (Position=3, Mandatory=$False)][int]   $MinRamInMB,
        [Parameter (Position=4, Mandatory=$False)][string]$MarkerId,
        [Parameter (Position=5, Mandatory=$False)][int]   $Limit,
        [Parameter (Position=6, Mandatory=$False)][switch]$Details
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
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "Get-CloudServerFlavors"     
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "MinDiskInGB...: $MinDiskInGB" 
        Write-Debug -Message "MinRamInMB....: $MinRamInMB" 
        Write-Debug -Message "MarkerId......: $MarkerId" 
        Write-Debug -Message "Limit.........: $Limit"  



        # If limit is not specified, it will be zero, which should be 999
        if ($Limit -le 0) {
            $Limit = 9999
        }


        # Get the list of Flavors
        $FlavorList = $cloudServersProvider.ListFlavorsWithDetails($MinDiskInGB, $MinRamInMB, $MarkerId, $Limit, $Region, $cloudId)


        # Handling empty response indicating that no Flavors exist in the queried data center
        if ($FlavorList.Count -eq 0) {
            Write-Verbose "No Flavors found in region '$Region'."
        }
        elseif($FlavorList.Count -ne 0){
    		return $FlavorList;
        }
    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 List available Cloud Server Flavors.

 .DESCRIPTION
 The Get-CloudServerFlavors cmdlet will retrieve a list of Cloud Server Flavors.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .PARAMETER MinDiskInGB
 This parameter will limit the list to only those Flavors that have this minimal Disk size (in gigabytes).

 .PARAMETER MinRamInMB
 This parameter will limit the list to only those Flavors that have this minimal Ram size (in megabytes).

 .PARAMETER MarkerId
 This parameter allows you to page forward through the list by using a marker.

 .PARAMETER Limit
 This parameter allows you to limit the number of results.

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerFlavors -Account prod
 This example shows how to get a list of all available Flavors in the account prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerFlavors cloudus -RegionOverride DFW
 This example shows how to get a list of all available Flavors for cloudus account in DFW region

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerFlavors cloudus -MinDiskInGB 100
 This example shows how to get a list of all available Flavors in the default region that have a minimum of 100GB disk space

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Images-d1e4427.html
#>
}

#ListImages
#ListImagesWithDetails
function Get-CloudServerImages {
    
    Param(
        [Parameter (Position=0, Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Position=1, Mandatory=$False)][string]$RegionOverride,
        [Parameter (Position=2, Mandatory=$False)][string]$Server,
        [Parameter (Position=3, Mandatory=$False)][string]$ImageName,
        [Parameter (Position=4, Mandatory=$False)][net.openstack.Core.Domain.ImageState] $ImageStatus,
        [Parameter (Position=5, Mandatory=$False)][datetime] $ChangesSince,
        [Parameter (Position=6, Mandatory=$False)][string] $MarkerId,
        [Parameter (Position=7, Mandatory=$False)][int] $Limit,
        [Parameter (Position=8, Mandatory=$False)][net.openstack.Core.Domain.ImageType]$ImageType,
        [Parameter (Position=9, Mandatory=$False)][switch] $Details
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
            Write-Debug -Message "Get-CloudServerImages"
            Write-Debug -Message "Server...........: $Server"
            Write-Debug -Message "ImageName........: $ImageName"
            Write-Debug -Message "ImageStatus......: $ImageStatus"
            Write-Debug -Message "ChangesSince.....: $ChangesSince"
            Write-Debug -Message "MarkerId.........: $MarkerId"
            Write-Debug -Message "Limit............: $Limit"
            Write-Debug -Message "ImageType........: $ImageType"
            Write-Debug -Message "Region...........: $Region"

            if ($Limit -le 0) {
                $Limit = 9999 #int
            }
           
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
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .PARAMETER Server
 This parameter limits the image list by the server name. 

 .PARAMETER ImageName
 This parameter limits the image list by the image name. 

 .PARAMETER ImageStatus
 This parameter limits the image list by the image status. 

 .PARAMETER ChangesSince
 This parameter limits the image list to only those created or modified since this date. 

 .PARAMETER MarkerId
 This parameter allows paging. 

 .PARAMETER Limit
 This parameter limits the number of images listed. 

 .PARAMETER ImageType
 This parameter limits the image list by the image type (Base or Snapshot). 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages -Account prod
 This example shows how to get a list of all available images in the account prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages cloudus -RegionOverride DFW
 This example shows how to get a list of all available images for cloudus account in DFW region

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages cloudus -ImageType ([net.openstack.Core.Domain.ImageType]::Base) 
 This example shows how to get a list of the base images

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Images-d1e4427.html
#>
}

#ListServers
#ListServersWithDetails
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
        [Parameter (Position=8, Mandatory=$False)][object]$ChangesSince,
        [Parameter (Position=9, Mandatory=$False)][switch]$Details
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
            Write-Debug -Message "Get-CloudServers"     
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
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

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

#GetDetails
function Get-CloudServerDetails {

    Param(
        [Parameter(Position=0, Mandatory=$true)] [string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Position=1, Mandatory=$true)] [string]$ServerID = $(throw "Please specify required server ID with -ServerID parameter"),
        [Parameter(Position=2, Mandatory=$False)][string]$RegionOverride
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
            Write-Debug -Message "Get-CloudServerDetails"     
            Write-Debug -Message "Account.: $Account"
            Write-Debug -Message "ServerID: $ServerID"
            Write-Debug -Message "Region..: $Region"


            # Get the Server details
            return $cloudServersProvider.GetDetails($ServerID, $Region, $cloudId)

<#
 .SYNOPSIS
 The Get-CloudServerDetails cmdlet will pull down a list of detailed information for a specific Rackspace Cloud Server.

 .DESCRIPTION
 This command is executed against one given cloud server ID, which in turn will return explicit details about that server without any other server data.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerID
 Use this parameter to specify Cloud Server UUID, details of which you want query. Run the "Get-CloudServers" cmdlet for a complete listing of servers.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerID abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to get explicit data about one cloud server from the account Prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerID abc123ef-9876-abcd-1234-123456abcdef -Account Dev 
 
 PS C:\Users\mitch.robins> Get-CloudServerDetails -ServerID abc123ef-9876-abcd-1234-123456abcdef -Account Prod

 DiskConfig    : MANUAL
 PowerState    : 1
 TaskState     : 
 VMState       : ACTIVE
 AccessIPv4    : 104.130.27.146
 AccessIPv6    : 2001:4802:7803:104:be76:4eff:fe20:228
 UserId        : 10045793
 Image         : net.openstack.Core.Domain.SimpleServerImage
 Status        : ACTIVE
 Flavor        : net.openstack.Core.Domain.Flavor
 Addresses     : {[public, net.openstack.Core.Domain.IPAddressList], [private, net.openstack.Core.Domain.IPAddressList]}
 Created       : 12/1/2014 8:18:12 PM +00:00
 HostId        : a38364d371a1205c6de337f3ed2404d381e6e36f2304b3bdee25fd81
 Progress      : 100
 TenantId      : 844783
 Updated       : 12/1/2014 8:18:43 PM +00:00
 Name          : devstack
 Id            : 3ca36b9b-85dd-4f26-9312-5947966aefbe
 Links         : {net.openstack.Core.Domain.Link, net.openstack.Core.Domain.Link}
 ExtensionData : {[key_name, ], [RAX-PUBLIC-IP-ZONE-ID:publicIPZoneId, c3602b3e3bf67ae9a533f285b5c4657ea68dafcb0f84f7e5e8dbb1f7], [OS-EXT-STS:task_state, ], [config_drive, ]...}
 
 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Get_Server_Details-d1e2623.html
#>
}

#ListServerVolumes
function Get-CloudServerVolumes {
    
        Param(
        [Parameter (Position=0, Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Position=1, Mandatory=$True)][string] $ServerID = $(throw "Please specify required server ID with -ServerID parameter"),
        [Parameter (Position=2, Mandatory=$False)][string]$RegionOverride
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
            Write-Debug -Message "Account.: $Account"
            Write-Debug -Message "ServerID: $ServerID"
            Write-Debug -Message "Region..: $Region"


            # Get the list of servers
            return $cloudServersProvider.ListServerVolumes($ServerID, $Region, $cloudId)

<#
 .SYNOPSIS
 The Get-CloudServerVolumes cmdlet will pull down a list of detailed information for a specific Rackspace Cloud Server.

 .DESCRIPTION
 This command is executed against one given cloud server ID, which in turn will return explicit details about that server without any other server data.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerID
 Use this parameter to specify Cloud Server UUID, details of which you want query. Run the "Get-CloudServers" cmdlet for a complete listing of servers.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerID abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to get explicit data about one cloud server from the account Prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerID abc123ef-9876-abcd-1234-123456abcdef -Account Dev 
 
 PS C:\Users\mitch.robins> Get-CloudServerDetails -ServerID abc123ef-9876-abcd-1234-123456abcdef -Account Prod

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

#CreateServer
function New-CloudServer {
    Param(
        [Parameter(Position=0,Mandatory=$true)][string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Position=1,Mandatory=$true)][string]$ServerName = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Position=2,Mandatory=$true)][string]$ImageID = $(throw "Please specify the image ID with -ImageID parameter"),
        [Parameter(Position=3,Mandatory=$true)][string]$FlavorID = $(throw "Please specify server flavor with -FlavorID parameter"),
        [Parameter(Position=4,Mandatory=$false)][object]$DiskConfig,
        [Parameter(Position=5,Mandatory=$false)][object]$Metadata,
        [Parameter(Position=6,Mandatory=$false)][switch]$AttachToServiceNetwork,
        [Parameter(Position=7,Mandatory=$false)][switch]$AttachToPublicNetwork,
        [Parameter(Position=8,Mandatory=$false)][array]$Networks,
        [Parameter(Position=9,Mandatory=$false)][ValidateCount(0,5)][string[]]$PersonalityFile,
        [Parameter(Position=10,Mandatory=$false)][switch]$Isolated,
        [Parameter(Position=11,Mandatory=$false)][switch]$Deploy,
        [Parameter(Position=12,Mandatory=$false)][string]$RegionOverride
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

            
            # Create a Server
            $newServer = $cloudServersProvider.CreateServer($ServerName, $ImageID, $FlavorID, $null, $null, $null, $true, $true, $null, $Region, $cloudId)
            $newServer | Format-Table Id, AdminPassword


}

#DeleteServer
function Remove-CloudServer{
    Param(
        [Parameter(Position=0,Mandatory=$true)][string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Position=1,Mandatory=$true)][string]$ServerId = $(throw "Please specify server ID with -ServerId parameter"),
        [Parameter(Position=2,Mandatory=$false)][string]$RegionOverride
        )

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

            
        # Delete the Server
        return $cloudServersProvider.DeleteServer($ServerId, $Region, $cloudId)
}

#RebootServer
function Restart-CloudServer{
    Param(
        [Parameter(Position=0,Mandatory=$true)][string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Position=1,Mandatory=$true)][string]$ServerId = $(throw "Please specify server ID with -ServerId parameter"),
        [Parameter(Position=2,Mandatory=$true)][net.openstack.Core.Domain.RebootType]$RebootType,
        [Parameter(Position=3,Mandatory=$False)][string]$RegionOverride
        )

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
            Write-Debug -Message "ServerID..: $ServerID"
            Write-Debug -Message "RebootType: $RebootType"
            Write-Debug -Message "Region....: $Region"

            
            # Reboot the Server
            return $cloudServersProvider.RebootServer($ServerId, $RebootType, $Region, $cloudId)
}

#RebuildServer
function Initialize-CloudServer{
    Param(
        [Parameter(Position=0,Mandatory=$true)][string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Position=1,Mandatory=$true)][string]$ServerId = $(throw "Please specify server ID with -ServerId parameter"),
        [Parameter(Position=2,Mandatory=$true)][string]$ServerName = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Position=3,Mandatory=$true)][string]$ImageId = $(throw "Please specify image id with -ImageId parameter"),
        [Parameter(Position=4,Mandatory=$true)][string]$FlavorId = $(throw "Please specify flavor id with -FlavorId parameter"),
        [Parameter(Position=5,Mandatory=$true)][string]$AdminPassword = $(throw "Please specify administrator password with -AdminPassword parameter"),
        [Parameter(Position=6,Mandatory=$False)][string]$AccessIPv4,
        [Parameter(Position=7,Mandatory=$False)][string]$AccessIPv6,
        [Parameter(Position=8,Mandatory=$False)][string]$Metadata,
        [Parameter(Position=9,Mandatory=$False)][string]$DiskConfig,
        [Parameter(Position=10,Mandatory=$False)][string]$Personality,
        [Parameter(Position=11,Mandatory=$False)][string]$RegionOverride
        )
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

            
        # Delete the Server
        return $cloudServersProvider.RebuildServer($ServerId, $ServerName, $ImageId, $FlavorId, $AdminPassword, $AccessIPv4, $AccessIPv6, $Metadata, $DiskConfig, $Personality, $Region, $cloudId)
}

#ResizeServer
function Resize-CloudServer{
    Param(
        [Parameter(Position=0,Mandatory=$true)][string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Position=1,Mandatory=$true)][string]$ServerId = $(throw "Please specify server ID with -ServerId parameter"),
        [Parameter(Position=2,Mandatory=$true)][string]$ServerName = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Position=3,Mandatory=$true)][string]$FlavorId = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Position=4,Mandatory=$False)][string]$DiskConfig,
        [Parameter(Position=5,Mandatory=$False)][string]$RegionOverride
        )
}