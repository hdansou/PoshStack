<############################################################################################

PoshStack
                                                    NextGen Servers

    
Description
-----------
**TODO**

############################################################################################>

#CloudServersProvider.AttachServerVolume
function Add-CloudServerVolume{
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $ServerId = $(throw "Server Id is required"),
        [Parameter (Mandatory=$True)] [string] $VolumeId = $(throw "Volume Id is required"),
        [Parameter (Mandatory=$False)][string] $StorageDevice,
        [Parameter (Mandatory=$False)][string] $RegionOverride
        )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Servers Provider
        $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "Add-CloudServerVolume"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "ServerId......: $ServerId" 
        Write-Debug -Message "VolumeId......: $VolumeId" 
        Write-Debug -Message "StorageDevice.: $StorageDevice" 


        $cloudServersProvider.AttachServerVolume($ServerId, $VolumeId, $StorageDevice, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Attach a storage volume to a virtual machine.

 .DESCRIPTION
 The Add-CloudServerVolume cmdlet will allow you to connect an existing storage volume to a virtual machine. You can optionally name the volume.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 The id of the server to which you wish to attach the volume. 

 .PARAMETER VolumeId
 The id of the volume to be attached. 

 .PARAMETER StorageDevice
 The name to be assigned to the device, e.g. "/dev/xvdb". If none is specified, the name will be generated. 

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Add-CloudServerVolume -Account demo -ServerId "3131589f-429f-40dc-87ee-492275990909" -VolumeId "bar"
 This example will attach the volume "bar" to the server "3131589f-429f-40dc-87ee-492275990909".

 .EXAMPLE
 PS C:\Users\Administrator> Add-CloudServerVolume -Account demo -ServerId "3131589f-429f-40dc-87ee-492275990909" -VolumeId "bar" -StorageDevice "DDrive"
 This example will attach the volume "bar" to the server "3131589f-429f-40dc-87ee-492275990909" and give it the name "DDrive" (as, say, in a Windows environment)

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Volume_Attachment_Actions.html
#>
}

#ChangeAdministratorPassword
function Set-CloudServerAdministratorPassword{
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $ServerId = $(throw "Server Id is required"),
        [Parameter (Mandatory=$True)] [string] $Password = $(throw "Password is required"),
        [Parameter (Mandatory=$False)][string] $RegionOverride
        )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Servers Provider
        $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "Set-CloudServerAdministratorPassword"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "ServerId......: $ServerId" 
        Write-Debug -Message "Password......: $Password" 


        $cloudServersProvider.ChangeAdministratorPassword($ServerId, $Password, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Changes the administrator password for a specified server.

 .DESCRIPTION
 The Set-CloudServerAdministratorPassword cmdlet changes the administrator password for a specified server. The administrator password is the root password for the server.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 The id of the server to which you wish to attach the volume. 

 .PARAMETER Password
 The new administrator password. 

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Set-CloudServerAdministratorPassword -Account demo -ServerId "3131589f-429f-40dc-87ee-492275990909" -Password "P4$$w0rd_is_weak"
 This example will set the password for server "3131589f-429f-40dc-87ee-492275990909" to "P4$$w0rd_is_weak".

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Change_Password-d1e3234.html
#>
}

#ConfirmServerResize
#CreateImage
function New-CloudServerImage{
    Param(
        [Parameter (Mandatory=$True)] [string]    $Account    = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]    $ServerId   = $(throw "Server Id is required"),
        [Parameter (Mandatory=$True)] [string]    $ImageName  = $(throw "Image Name is required"),
        [Parameter (Mandatory=$False)][net.openstack.Core.Domain.Metadata] $Metadata,
        [Parameter (Mandatory=$False)][string]    $RegionOverride
        )

            
    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING
    Write-Debug -Message "New-CloudServerImage"        
    Write-Debug -Message "Account...: $Account"     
    Write-Debug -Message "ServerId..: $ServerId"
    Write-Debug -Message "ImageName.: $ImageName"
    Write-Debug -Message "Metadata..: $Metadata"
    Write-Debug -Message "Region....: $Region"


            
    # Create a Server Image
    $cloudServersProvider.CreateImage($ServerId, $ImageName, $Metadata, $Region, $cloudId)

<#
 .SYNOPSIS
 The New-CloudServerImage creates a new image for a specified server..

 .DESCRIPTION
 This cmdlet creates a new image for a specified server. Once complete, a new image is available that you can use to rebuild or create servers. 

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 The ID of the server to be used for the Image.

 .PARAMETER ImageName
 The name for the new Image.

 .PARAMETER Metadata
 You can supply custom server metadata. The maximum size of the metadata key and value is 255 bytes each.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> New-CloudServerImage -Account Dev -ServerId "foo" -ImageName "MyNewImage"
 This example will create the Image "MyNewImage" based on the server "foo".
 
 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Create_Image-d1e4655.html

#>

}

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
function Get-CloudServerVolumeDetails{
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $ServerId = $(throw "Please specify required Server Id with -ServerId parameter"),
        [Parameter (Mandatory=$True)] [string] $VolumeId = $(throw "Please specify required Volume Id with -VolumeId parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride
        )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING   
    Write-Debug -Message "Get-CloudServerVolumeDetails"
    Write-Debug -Message "ServerId.....: $ServerId"
    Write-Debug -Message "VolumeId.....: $VolumeId"
    Write-Debug -Message "Region.......: $Region"

            
    # Get the addresses
    $cloudServersProvider.GetServerVolumeDetails($ServerId, $VolumeId, $Region, $cloudId)


<#
 .SYNOPSIS
 The Get-CloudServerVolumeDetails cmdlet gets detailed information about the specified server-attached volume.

 .DESCRIPTION
 This cmdlet returns the volume details of a specified volume attachment ID for a specified server.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 The ID of the server.

 .PARAMETER VolumeId
 The ID of the Volume.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerVolumeDetails -Account demo -ServerId "foo" -VolumeId "foo-volume-id"
 This example will get detail information about Volume "foo-volume-id" that is attached to server "foo".
 
 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Get_Volume_Attachment_Details.html

#>

}

#ListAddresses
function Get-CloudServerAddresses{
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride,
        [Parameter (Mandatory=$False)][string] $ServerId
    )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING   
    Write-Debug -Message "Get-CloudServerAddresses"          
    Write-Debug -Message "ServerId.....: $ServerId"
    Write-Debug -Message "Region.......: $Region"

            
    # Get the addresses
    $cloudServersProvider.ListAddresses($ServerId, $Region, $cloudId)


<#
 .SYNOPSIS
 The Get-CloudServerAddresses cmdlet gets addresses and networks for server.

 .DESCRIPTION
 This cmdlet gets all the addresses and networks associated with the server.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 The ID of the server..

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerAddresses -Account demo -ServerId "foo" 
 This example will get all of the addresses associated with the server "foo".
 
 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Get_Server_Details-d1e2623.html

#>

}

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
function Update-CloudServer{
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride,
        [Parameter (Mandatory=$False)][string] $ServerId,
        [Parameter (Mandatory=$False)][string] $ServerName,
        [Parameter (Mandatory=$False)][string] $AccessIPv4,
        [Parameter (Mandatory=$False)][string] $AccessIPv6
    )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING   
    Write-Debug -Message "Update-CloudServer"          
    Write-Debug -Message "ServerId.....: $ServerId"
    Write-Debug -Message "ServerName...: $ServerName"
    Write-Debug -Message "AccessIPv4...: $AccessIPv4"
    Write-Debug -Message "AccessIPv6...: $AccessIPv6"
    Write-Debug -Message "Region.......: $Region"

            
    # Update the Server
    $cloudServersProvider.UpdateServer($ServerId, $ServerName, $AccessIPv4, $AccessIPv6, $Region, $cloudId)


<#
 .SYNOPSIS
 The Update-CloudServer cmdlet updates one or more editable attributes for a specified server.

 .DESCRIPTION
 This cmdlet updates one or more editable attributes for a specified server. 

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 The ID of the server to be updated.

 .PARAMETER ServerName
 The new name of the server.

 .PARAMETER AccessIPv4
 The IP version 4 address.

 .PARAMETER AccessIPv6
 The IP version 6 address.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Update-CloudServer -Account demo -ServerId "foo" -ServerName "TheNewName"
 This example will rename server "foo" to "TheNewName".
 
 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/ServerUpdate.html

#>

}

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
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride,
        [Parameter (Mandatory=$False)][int]    $MinDiskInGB,
        [Parameter (Mandatory=$False)][int]    $MinRamInMB,
        [Parameter (Mandatory=$False)][string] $MarkerId,
        [Parameter (Mandatory=$False)][int]    $Limit = 10000,
        [Parameter (Mandatory=$False)][switch] $Details
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

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
        Write-Debug -Message "Details.......: $Details"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "MinDiskInGB...: $MinDiskInGB" 
        Write-Debug -Message "MinRamInMB....: $MinRamInMB" 
        Write-Debug -Message "MarkerId......: $MarkerId" 
        Write-Debug -Message "Limit.........: $Limit"  




        # Get the list of Flavors
        if ($Details) {
            $FlavorList = $cloudServersProvider.ListFlavorsWithDetails($MinDiskInGB, $MinRamInMB, $MarkerId, $Limit, $Region, $cloudId)
        } else {
            $FlavorList = $cloudServersProvider.ListFlavors($MinDiskInGB, $MinRamInMB, $MarkerId, $Limit, $Region, $cloudId)
        }


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

 .PARAMETER Details
 This switch allows you to include detailed information about each Flavor in your list.

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
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Flavors-d1e4180.html
#>
}

#ListImages
#ListImagesWithDetails
function Get-CloudServerImages {
    
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -account parameter"),
        [Parameter (Mandatory=$False)][string]$RegionOverride,
        [Parameter (Mandatory=$False)][string]$Server,
        [Parameter (Mandatory=$False)][string]$ImageName,
        [Parameter (Mandatory=$False)][net.openstack.Core.Domain.ImageState] $ImageStatus,
        [Parameter (Mandatory=$False)][datetime] $ChangesSince,
        [Parameter (Mandatory=$False)][string] $MarkerId,
        [Parameter (Mandatory=$False)][int] $Limit = 10000,
        [Parameter (Mandatory=$False)][net.openstack.Core.Domain.ImageType]$ImageType,
        [Parameter (Mandatory=$False)][switch] $Details
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {
            # Get Identity Provider
            $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

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
            Write-Debug -Message "Details..........: $Details"
            Write-Debug -Message "Server...........: $Server"
            Write-Debug -Message "ImageName........: $ImageName"
            Write-Debug -Message "ImageStatus......: $ImageStatus"
            Write-Debug -Message "ChangesSince.....: $ChangesSince"
            Write-Debug -Message "MarkerId.........: $MarkerId"
            Write-Debug -Message "Limit............: $Limit"
            Write-Debug -Message "ImageType........: $ImageType"
            Write-Debug -Message "Region...........: $Region"

           
            $Region = $Region
            

            if ($Details) {
                $ImageList = $cloudServersProvider.ListImagesWithDetails($Server, $ImageName, $ImageStatus, $ChangesSince, $MarkerId, $Limit, $ImageType, $Region, $cloudId)
            } else {
                $ImageList = $cloudServersProvider.ListImages($Server, $ImageName, $ImageStatus, $ChangesSince, $MarkerId, $Limit, $ImageType, $Region, $cloudId)
            }


            # Handling empty response indicating that no servers exist in the queried data center
            if ($ImageList.Count -eq 0) {
                Write-Verbose "No Images found in region '$Region'."
            }
        elseif($ImageList.Count -ne 0){
    		$ImageList;
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
 This parameter limits the Image list by the server name. 

 .PARAMETER ImageName
 This parameter limits the Image list by the Image name. 

 .PARAMETER ImageStatus
 This parameter limits the Image list by the Image status. 

 .PARAMETER ChangesSince
 This parameter limits the Image list to only those created or modified since this date. 

 .PARAMETER MarkerId
 This parameter allows paging. 

 .PARAMETER Limit
 This parameter limits the number of Images listed. 

 .PARAMETER ImageType
 This parameter limits the Image list by the Image Type (Base or Snapshot). 

  .PARAMETER Details
 This switch allows you to include detailed information about each Image in your list.

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages -Account prod
 This example shows how to get a list of all available Images in the account prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages cloudus -RegionOverride DFW
 This example shows how to get a list of all available Images for cloudus account in DFW region

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerImages cloudus -ImageType ([net.openstack.Core.Domain.ImageType]::Base) 
 This example shows how to get a list of the base Images

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Images-d1e4427.html
#>
}

#ListServers
#ListServersWithDetails
function Get-CloudServers{

    [CmdletBinding()]

    Param(
        [Parameter (Mandatory=$True)] [string]$Account,
        [Parameter (Mandatory=$False)][string]$RegionOverride,
        [Parameter (Mandatory=$False)][string]$ImageId,
        [Parameter (Mandatory=$False)][string]$FlavorId,
        [Parameter (Mandatory=$False)][string]$ServerName,
        [Parameter (Mandatory=$False)][object]$ServerState,
        [Parameter (Mandatory=$False)][string]$MarkerId,
        [Parameter (Mandatory=$False)][int]   $Limit = 10000,
        [Parameter (Mandatory=$False)][object]$ChangesSince,
        [Parameter (Mandatory=$False)][switch]$Details
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {
            # Get Identity Provider
            $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

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
            Write-Debug -Message "Get-CloudServers"  
            Write-Debug -Message "Details.....: $Details"   
            Write-Debug -Message "ImageId.....: $ImageId"
            Write-Debug -Message "FlavorId....: $FlavorId"
            Write-Debug -Message "ServerName..: $ServerName"
            Write-Debug -Message "ServerState.: $ServerState"
            Write-Debug -Message "MarkerId....: $MarkerId"
            Write-Debug -Message "Limit.......: $Limit"
            Write-Debug -Message "ChangesSince: $ChangesSince"
            Write-Debug -Message "Region......: $Region"


            # Get the list of servers
            if ($Details) {
                $ServerList = $cloudServersProvider.ListServersWithDetails($ImageId, $FlavorId, $ServerName, $ServerState, $MarkerId, $Limit, $ChangesSince, $Region, $cloudId)
            } else {
                $ServerList = $cloudServersProvider.ListServers($ImageId, $FlavorId, $ServerName, $ServerState, $MarkerId, $Limit, $ChangesSince, $Region, $cloudId)
            }


            # Handling empty response indicating that no servers exist in the queried data center
            if ($ServerList.Count -eq 0) {
                Write-Verbose "You do not currently have any Cloud Servers provisioned in region '$Region'."
            }
        elseif($ServerList.Count -ne 0){
            foreach ($server in $ServerList)
            {
                Add-Member -InputObject $server -MemberType NoteProperty -Name Region -Value $Region
            }
    		$ServerList;
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

 .PARAMETER Details
 This switch allows you to include detailed information about each Server in your list.

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
        [Parameter(Mandatory=$true)] [string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Mandatory=$true)] [string]$ServerId = $(throw "Please specify required server Id with -ServerId parameter"),
        [Parameter(Mandatory=$False)][string]$RegionOverride
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING        
    Write-Debug -Message "Get-CloudServerDetails"     
    Write-Debug -Message "Account.: $Account"
    Write-Debug -Message "ServerId: $ServerId"
    Write-Debug -Message "Region..: $Region"


    # Get the Server details
    $cloudServersProvider.GetDetails($ServerId, $Region, $cloudId)

<#
 .SYNOPSIS
 The Get-CloudServerDetails cmdlet will pull down a list of detailed information for a specific Rackspace Cloud Server.

 .DESCRIPTION
 This command is executed against one given cloud server Id, which in turn will return explicit details about that server without any other server data.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 Use this parameter to specify Cloud Server UUID, details of which you want query. Run the "Get-CloudServers" cmdlet for a complete listing of servers.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to get explicit data about one cloud server from the account Prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account Dev 
 
 PS C:\Users\mitch.robins> Get-CloudServerDetails -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account Prod

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
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $ServerId = $(throw "Please specify required server Id with -ServerId parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING             
    Write-Debug -Message "Account.: $Account"
    Write-Debug -Message "ServerId: $ServerId"
    Write-Debug -Message "Region..: $Region"


    # Get the list of servers
    $cloudServersProvider.ListServerVolumes($ServerId, $Region, $cloudId)

<#
 .SYNOPSIS
 The Get-CloudServerVolumes cmdlet will pull down a list of detailed information for a specific Cloud Server.

 .DESCRIPTION
 This command is executed against one given cloud server Id, which in turn will return explicit details about that server without any other server data.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 Use this parameter to specify Cloud Server UUID, details of which you want query. Run the "Get-CloudServers" cmdlet for a complete listing of servers.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to get explicit data about one cloud server from the account Prod

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudServerDetails -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account Dev 
 
 PS C:\Users\mitch.robins> Get-CloudServerDetails -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account Prod

    Server Status:  ACTIVE 
    Server Name:  AA-Mongo 
    Server Id:  abc123ef-9876-abcd-1234-123456abcdef
    Server Created:  2013-03-11T16:09:15Z 
    Server Last Updated:  2013-03-11T16:14:27Z 
    Server Image Id:  8a3a9f96-b997-46fd-b7a8-a9e740796ffd 
    Server Flavor Id:  4 
    Server IPv4:  100.100.100.100
    Server IPv6:  2001:::::::15d0 
    Server Build Progress:  100 

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/List_Volume_Attachments.html

#>

}

#CreateServer
function New-CloudServer {
    Param(
        [Parameter(Mandatory=$true)] [string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Mandatory=$true)] [string]$ServerName = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Mandatory=$true)] [string]$ImageId = $(throw "Please specify the image Id with -ImageId parameter"),
        [Parameter(Mandatory=$true)] [string]$FlavorId = $(throw "Please specify server flavor with -FlavorId parameter"),
        [Parameter(Mandatory=$false)][net.openstack.Core.Domain.DiskConfiguration]$DiskConfig,
        [Parameter(Mandatory=$false)][net.openstack.Core.Domain.Metadata]$Metadata,
        [Parameter(Mandatory=$false)][bool]$AttachToServiceNetwork=$true,
        [Parameter(Mandatory=$false)][bool]$AttachToPublicNetwork=$true,
        [Parameter(Mandatory=$false)][array]$Networks,
        [Parameter(Mandatory=$false)][ValidateCount(0,5)][string[]]$PersonalityFile,
        [Parameter(Mandatory=$false)][string]$RegionOverride
    )
            
    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING
    Write-Debug -Message "New-CloudServer"        
    Write-Debug -Message "Account...............: $Account"     
    Write-Debug -Message "ServerName............: $ServerName"
    Write-Debug -Message "ImageId...............: $ImageId"
    Write-Debug -Message "FlavorId..............: $FlavorId"
    Write-Debug -Message "DiskConfig............: $DiskConfig"
    Write-Debug -Message "Metadata..............: $Metadata"
    Write-Debug -Message "AttachToServiceNetwork: $AttachToServiceNetwork"
    Write-Debug -Message "AttachToPublicNetwork.: $AttachToPublicNetwork"
    Write-Debug -Message "Networks..............: $Networks"
    Write-Debug -Message "PersonalityFile.......: $PersonalityFile"
    Write-Debug -Message "Region................: $Region"

            
    # Create a Server
    $newServer = $cloudServersProvider.CreateServer($ServerName, $ImageId, $FlavorId, $DiskConfig, $Metadata, $null, $AttachToServiceNetwork, $AttachToPublicNetwork, $Networks, $Region, $cloudId)
    $newServer | Format-Table Id, AdminPassword

<#
 .SYNOPSIS
 The New-CloudServer cmdlet will create a Virtual Machine.

 .DESCRIPTION
 This command creates a Virtual Machine. The Server Id and Administrator Password (AdminPassword) are returned.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerName
 The name you wish to assign to the server. This name does not need to be unique.

 .PARAMETER ImageId
 The id of the image used to build this server.

 .PARAMETER FlavorId
 The id of the flavor used to build this server.

 .PARAMETER DiskConfig
 Disk configuration setting: Auto, Manual or FromName().

 .PARAMETER Metadata
 You can supply custom server metadata. The maximum size of the metadata key and value is 255 bytes each.

 .PARAMETER AttachToServiceNetwork
 This boolean determines whether or not the server is attached to the service network.

 .PARAMETER AttachToPublicNetwork
 This boolean determines whether or not the server is attached to the public network.

 .PARAMETER Networks
 This list of network ids specifies software-defined networks to which this server will be attached.

 .PARAMETER PersonalityFile
 A list of files to be injected into the file system of the cloud server instance.
 The maximum size of the file path data is 255 bytes.
 Encode the file contents as a Base64 string.
 You can inject text files only. You cannot inject binary or zip file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> New-CloudServer -Account Dev -ServerName "MyNewServer" -ImageId "foo" -FlavorId "bar"
 This example will create the server "MyNewServer" in the default region for the account "Dev" using the image and flavor shown.
 The server id and admin password will be returned:
 Id                                                                                        AdminPassword                                                                           
 --                                                                                        -------------                                                                           
 1c962b8d-93ed-404d-a2ce-e83f6ba2dd3e                                                      qJW2vYu2xXnT                                                                            

 
 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/CreateServers.html

#>

}

#DeleteServer
function Remove-CloudServer{
    Param(
        [Parameter(Mandatory=$true)] [string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Mandatory=$true)] [string]$ServerId = $(throw "Please specify server Id with -ServerId parameter"),
        [Parameter(Mandatory=$false)][string]$RegionOverride
        )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

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
    Write-Debug -Message "ServerId: $ServerId"
    Write-Debug -Message "Region..: $Region"
          
    # Delete the Server
    $cloudServersProvider.DeleteServer($ServerId, $Region, $cloudId)

<#
 .SYNOPSIS
 The Remove-CloudServer cmdlet will delete a Virtual Machine.

 .DESCRIPTION
 This command deletes a Virtual Machine. A boolean is returned to reflect the results.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 This uniquely identifies the server.

 .PARAMETER RegionOverride
 This is required if the server is not in your default region.

 .EXAMPLE
 PS C:\Users\Administrator> Remove-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to delete the server "abc123ef-9876-abcd-1234-123456abcdef" in the default region for the account "prod"

 .EXAMPLE
 PS C:\Users\Administrator> Remove-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account prod -RegionOverride "SYD"
 This example shows how to delete the server "abc123ef-9876-abcd-1234-123456abcdef" in the region "SYD" for the account "prod"

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Delete_Server-d1e2883.html

#>

}

#RebootServer
function Restart-CloudServer{
    Param(
        [Parameter(Mandatory=$true)] [string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Mandatory=$true)] [string]$ServerId = $(throw "Please specify server Id with -ServerId parameter"),
        [Parameter(Mandatory=$true)] [net.openstack.Core.Domain.RebootType]$RebootType,
        [Parameter(Mandatory=$False)][string]$RegionOverride
        )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

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
    Write-Debug -Message "ServerId..: $ServerId"
    Write-Debug -Message "RebootType: $RebootType"
    Write-Debug -Message "Region....: $Region"

            
    # Reboot the Server
    $cloudServersProvider.RebootServer($ServerId, $RebootType, $Region, $cloudId)

<#
 .SYNOPSIS
 The Restart-CloudServer cmdlet will reboot a Virtual Machine.

 .DESCRIPTION
 This command reboots a Virtual Machine. A boolean is returned to reflect the results.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 This uniquely identifies the server.

 .PARAMETER RebootType
 Hard or Soft reboot.

 .PARAMETER RegionOverride
 This is required if the server is not in your default region.

 .EXAMPLE
 PS C:\Users\Administrator> Restart-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account prod
 This example shows how to reboot the server "abc123ef-9876-abcd-1234-123456abcdef" in the default region for the account "prod"

 .EXAMPLE
 PS C:\Users\Administrator> Restart-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -Account prod -RegionOverride "SYD"
 This example shows how to reboot the server "abc123ef-9876-abcd-1234-123456abcdef" in the region "SYD" for the account "prod"

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Reboot_Server-d1e3371.html

#>

}

#RebuildServer
function Initialize-CloudServer{
    Param(
        [Parameter(Mandatory=$true)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Mandatory=$true)] [string] $ServerId = $(throw "Please specify server Id with -ServerId parameter"),
        [Parameter(Mandatory=$true)] [string] $ServerName = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Mandatory=$true)] [string] $ImageId = $(throw "Please specify image id with -ImageId parameter"),
        [Parameter(Mandatory=$true)] [string] $FlavorId = $(throw "Please specify flavor id with -FlavorId parameter"),
        [Parameter(Mandatory=$true)] [string] $AdminPassword = $(throw "Please specify administrator password with -AdminPassword parameter"),
        [Parameter(Mandatory=$False)][string] $AccessIPv4,
        [Parameter(Mandatory=$False)][string] $AccessIPv6,
        [Parameter(Mandatory=$False)][string] $Metadata,
        [Parameter(Mandatory=$False)][string] $DiskConfig,
        [Parameter(Mandatory=$False)][string] $Personality,
        [Parameter(Mandatory=$False)][string] $RegionOverride
        )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING   
    Write-Debug -Message "Initialize-CloudServer"          
    Write-Debug -Message "ServerId.....: $ServerId"
    Write-Debug -Message "ServerName...: $ServerName"
    Write-Debug -Message "ImageId......: $ImageId"
    Write-Debug -Message "FlavorId.....: $FlavorId"
    Write-Debug -Message "AdminPassword: $AdminPassword"
    Write-Debug -Message "AccessIPv4...: $AccessIPv4"
    Write-Debug -Message "AccessIPv6...: $AccessIPv6"
    Write-Debug -Message "Metadata.....: $Metadata"
    Write-Debug -Message "DiskConfig...: $DiskConfig"
    Write-Debug -Message "Personality..: $Personality"
    Write-Debug -Message "Region.......: $Region"

            
    # Delete the Server
    $cloudServersProvider.RebuildServer($ServerId, $ServerName, $ImageId, $FlavorId, $AdminPassword, $AccessIPv4, $AccessIPv6, $Metadata, $DiskConfig, $Personality, $Region, $cloudId)

<#
 .SYNOPSIS
 The Initialize-CloudServer cmdlet will rebuild a Virtual Machine.

 .DESCRIPTION
 The Initialize-CloudServer cmdlet removes all data on the server and replaces it with the specified image. The serverRef and all IP addresses remain the same.
 If you specify name, metadata, accessIPv4, or accessIPv6 in the rebuild request, new values replace existing values. Otherwise, these values do not change.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 This uniquely identifies the server.

 .PARAMETER ServerName
 The new name for the server.

 .PARAMETER ImageId
 The id of the image used to rebuild the server.

 .PARAMETER FlavorId
 The id of the flavor used to rebuild the server.

 .PARAMETER AdminPassword
 The administrator password for the new server being created.

 .PARAMETER AccessIPv4
 The IP version 4 address.

 .PARAMETER AccessIPv6
 The IP version 6 address.

 .PARAMETER Metadata
 A metadata key and value pairl

 .PARAMETER DiskConfig
 AUTO or MANUAL.

 .PARAMETER Personality
 The file path and file contents.

 .PARAMETER RegionOverride
 This is required if the server is not in your default region.

 .EXAMPLE
 PS C:\Users\Administrator> Initialize-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -ImageId "foo" -FlavorId "bar" -Account prod
 This example shows how to rebuild the server "abc123ef-9876-abcd-1234-123456abcdef" in the default region for the account "prod"

 .EXAMPLE
 PS C:\Users\Administrator> Initialize-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -ImageId "foo" -FlavorId "bar" -Account prod -AdminPassword "ju289732$$_X#"
 This example shows how to rebuild the server "abc123ef-9876-abcd-1234-123456abcdef" in the default region for the account "prod" and assigns a new administrator password.

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Rebuild_Server-d1e3538.html

#>

}

#ResizeServer
function Resize-CloudServer{
    Param(
        [Parameter(Mandatory=$true)] [string]$Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter(Mandatory=$true)] [string]$ServerId = $(throw "Please specify server Id with -ServerId parameter"),
        [Parameter(Mandatory=$true)] [string]$ServerName = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Mandatory=$true)] [string]$FlavorId = $(throw "Please specify server name with -ServerName parameter"),
        [Parameter(Mandatory=$False)][string]$DiskConfig,
        [Parameter(Mandatory=$False)][string]$RegionOverride
        )

    Get-CloudAccount($Account)

    # Get Identity Provider
    $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

    # Get Cloud Servers Provider
    $cloudServersProvider = New-Object net.openstack.Providers.Rackspace.CloudServersProvider


    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # DEBUGGING   
    Write-Debug -Message "Resize-CloudServer"          
    Write-Debug -Message "ServerId.....: $ServerId"
    Write-Debug -Message "ServerName...: $ServerName"
    Write-Debug -Message "FlavorId.....: $FlavorId"
    Write-Debug -Message "DiskConfig...: $DiskConfig"
    Write-Debug -Message "Region.......: $Region"

            
    # Delete the Server
    $cloudServersProvider.ResizeServer($ServerId, $ServerName, $FlavorId, $DiskConfig, $Region, $cloudId)

<#
 .SYNOPSIS
 The Resize-CloudServer cmdlet will resize a Virtual Machine.

 .DESCRIPTION
 The Resize-CloudServer cmdlet converts an existing Standard server to a different flavor, which scales the server up or down.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ServerId
 This uniquely identifies the server.

 .PARAMETER ServerName
 The new name for the server.

 .PARAMETER FlavorId
 The id of the flavor used to resize the server.

 .PARAMETER DiskConfig
 AUTO or MANUAL.

 .PARAMETER RegionOverride
 This is required if the server is not in your default region.

 .EXAMPLE
 PS C:\Users\Administrator> Resize-CloudServer -ServerId abc123ef-9876-abcd-1234-123456abcdef -FlavorId "performance1-2" -Account prod
 This example shows how to resize the server "abc123ef-9876-abcd-1234-123456abcdef" in the default region for the account "prod"

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Resize_Server-d1e3707.html

#>

}