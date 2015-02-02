<############################################################################################

PoshStack
                                                    Cloud Files

    
Description
-----------
**TODO**

############################################################################################>

#Issue #7 New-CloudBlockStorageVolume
function New-CloudBlockStorageVolume {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [int]    $Size = $(throw "Pleaes specify the required size (in GB) with the -Size parameter"),
        [Parameter (Mandatory=$False)][string] $DisplayDescription = $Null,
        [Parameter (Mandatory=$False)][string] $DisplayName = $Null,
        [Parameter (Mandatory=$False)][string] $SnapshotId = $Null,
        [Parameter (Mandatory=$False)][string] $VolumeType = $Null,
        [Parameter (Mandatory=$False)][string] $RegionOverride = $Null
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Block Storage Provider
        $CloudBlockStorageProvider = New-Object net.openstack.Providers.Rackspace.CloudBlockStorageProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "New-CloudBlockStorageVolume"
        Write-Debug -Message "Size..............: $Size" 
        Write-Debug -Message "DisplayDescription: $DisplayDescription" 
        Write-Debug -Message "DisplayName.......: $DisplayName" 
        Write-Debug -Message "SnapshotId........: $SnapshotId" 
        Write-Debug -Message "VolumeType........: $VolumeType" 
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.CreateVolume($Size, $DisplayDescription, $DisplayName, $SnapshotId, $VolumeType, $RegionOverride, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Creates a volume.

 .DESCRIPTION
 The New-CloudBlockStorageVolume cmdlet allows you to create a volume.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER Size
 The size (in GB) of the volume. Note: When creating a volume from a snapshot, the volume size must be greater than the snapshot size.

 .PARAMETER DisplayDescription
 A description of the volume.

 .PARAMETER DisplayName
 The name of the volume.

 .PARAMETER SnapshotId
 The snapshot from which to create a volume.

 .PARAMETER VolumeType
 The type of volume to create, either SATA or SSD. The default is SATA.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> New-CloudBlockStorageVolme -Account demo -Size 500
 This example will create a 500GB volume.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/POST_createVolume_v1__tenant_id__volumes_volumes.html
#>
}

#Issue #11 Get-CloudBlockStorageSnapshots
function Get-CloudBlockStorageSnapshots {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride = $Null
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Block Storage Provider
        $CloudBlockStorageProvider = New-Object net.openstack.Providers.Rackspace.CloudBlockStorageProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "Get-CloudBlockStorageSnapshots"
        Write-Debug -Message "Account...........: $Account" 
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.ListSnapshots($RegionOverride, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Get snapshots (detailed).

 .DESCRIPTION
 The New-CloudBlockStorageSnapshot cmdlet allows you to get detailed information for all Block Storage snapshots.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudBlockStorageSnapshots -Account demo
 This example will get all of the snapshots for the default region associated with the account "demo".

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getSnapshotsDetail_v1__tenant_id__snapshots_detail_snapshots.html
#>
}

#Issue #6 New-CloudBlockStorageSnapshot
function New-CloudBlockStorageSnapshot {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $VolumeId = $(throw "Please specify required Volume ID with the -VolumeId paramter"),
        [Parameter (Mandatory=$False)][bool]   $Force = $False,
        [Parameter (Mandatory=$False)][string] $DisplayName = "None",
        [Parameter (Mandatory=$False)][string] $DisplayDescription = "None",
        [Parameter (Mandatory=$False)][string] $RegionOverride = $Null
    )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Block Storage Provider
        $CloudBlockStorageProvider = New-Object net.openstack.Providers.Rackspace.CloudBlockStorageProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "New-CloudBlockStorageSnapshot"
        Write-Debug -Message "Account...........: $Account" 
        Write-Debug -Message "VolumeId..........: $VolumeId"
        Write-Debug -Message "RegionOverride....: $RegionOverride" 
        Write-Debug -Message "Force.............: $Force"
        Write-Debug -Message "DisplayName.......: $DisplayName" 
        Write-Debug -Message "DisplayDescription: $DisplayDescription" 

        $CloudBlockStorageProvider.CreateSnapshot($VolumeId, $Force, $DisplayName, $DisplayDescription, $RegionOverride, $cloudId)


    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Creates a new snapshot.

 .DESCRIPTION
 The New-CloudBlockStorageSnapshot cmdlet allows you to create a snapshot of an existing volume.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeId
 The unique identifier of the volume.

 .PARAMETER Force
 $True/$False, indicates whether to snapshot, even if the volume is attached. The default is $False.

 .PARAMETER DisplayName
 Name of the snapshot. The default is None. 

 .PARAMETER DisplayDescription
 Description of snapshot. The default is None. 

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> New-CloudBlockStorageSnapshot -Account demo -VolumeId 32233adkjaadhwoun23
 This example will create a snapshot of the volume.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/POST_createSnapshot_v1__tenant_id__snapshots_snapshots.html
#>
}
