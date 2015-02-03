<############################################################################################

PoshStack
                                                    Cloud Files

    
Description
-----------
**TODO**

############################################################################################>

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

#Issue #8 Remove-CloudBlockStorageSnapshot
function Remove-CloudBlockStorageSnapshot {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $SnapshotId = $(throw "Please specify the required snapshot id with the -SnapshotId parameter"),
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
        Write-Debug -Message "Remove-CloudBlockStorageSnapshot"
        Write-Debug -Message "SnapshotId....: $SnapshotId" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CloudBlockStorageProvider.DeleteSnapshot($SnapshotId, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Deletes a snapshot.

 .DESCRIPTION
 The Remove-CloudBlockStorageSnapshot cmdlet allows you to mark a snapshot for deletion.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER SnapshotId
 The unique identifier of an existing snapshot.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Remove-CloudBlockStorageSnapshot -Account demo -SnapshotId ec9038c3-b3ce-4477-a147-55b3a7468997

 This example will remove the snapshot.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/DELETE_deleteSnapshot_v1__tenant_id__snapshots__snapshot_id__snapshots.html
#>
}

#Issue #9 Remove-CloudBlockStorageVolume
function Remove-CloudBlockStorageVolume {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $VolumeId = $(throw "Please specify the required volume id with the -VolumeId parameter"),
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
        Write-Debug -Message "Remove-CloudBlockStorageVolume"
        Write-Debug -Message "VolumeId......: $VolumeId" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CloudBlockStorageProvider.DeleteVolume($VolumeId, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Deletes a volume.

 .DESCRIPTION
 The Remove-CloudBlockStorageVolume cmdlet allows you to mark a volume for deletion.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeId
 The unique identifier of an existing volume.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Remove-CloudBlockStorageVolume -Account demo -VolumeId ec9038c3-b3ce-4477-a147-55b3a7468997

 This example will remove the volume.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/DELETE_deleteVolume_v1__tenant_id__volumes__volume_id__volumes.html
#>
}

#Issue #10 Get-CloudBlockStorageVolumeTypeInfo
function Get-CloudBlockStorageVolumeTypeInfo {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $VolumeTypeId = $(throw "Please specify the required volume type id with the -VolumeTypeId parameter"),
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
        Write-Debug -Message "Get-CloudBlockStorageVolumeTypeInfo"
        Write-Debug -Message "VolumeTypeId..: $VolumeTypeId" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CloudBlockStorageProvider.DescribeVolumeType($VolumeTypeId, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Gets volume type details.

 .DESCRIPTION
 The Get-CloudBlockStorageVolumeTypeInfo cmdlet allows you to get the detail information about a volume type.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeTypeId
 The unique identifier of an existing volume type.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudBlockStorageVolumeTypeInfo -Account demo -VolumeTypeId ec9038c3-b3ce-4477-a147-55b3a7468997

 This example will remove the volume.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolumeType_v1__tenant_id__types__volume_type_id__volume_types.html
#>}

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

#Issue #12 Get-CloudBlockStorageVolumes
function Get-CloudBlockStorageVolumes {
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
        Write-Debug -Message "Get-CloudBlockStorageVolumes"
        Write-Debug -Message "Account...........: $Account" 
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.ListVolumes($RegionOverride, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Get volumes (detailed).

 .DESCRIPTION
 The Get-CloudBlockStorageVolumes cmdlet allows you to get a collection of volumes with detailed information for each.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudBlockStorageVolumes -Account demo
 This example will get all of the volumes for the default region associated with the account "demo".

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolumesDetail_v1__tenant_id__volumes_detail_volumes.html
#>
}

#Issue #13 Get-CloudBlockStorageVolume
function Get-CloudBlockStorageVolume {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $VolumeId = $(throw "Please specify required Volume Id with the -VolumeId parameter"),
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
        Write-Debug -Message "Get-CloudBlockStorageVolume"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "VolumeId..........: $VolumeId" 
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.ShowVolume($VolumeId, $RegionOverride, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Get volume details.

 .DESCRIPTION
 The Get-CloudBlockStorageVolume cmdlet allows you to get the details for one volume.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeId
 The unique identifier of an existing volume.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudBlockStorageVolume -Account demo -VolumeId c569c5eb-1ccc-4702-b64f-e6252a656b66
 This example will get the details for the volume.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolume_v1__tenant_id__volumes__volume_id__volumes.html
#>
}

#Issue #14 Watch-CloudBlockStorageVolumeAvailable
function Watch-CloudBlockStorageVolumeAvailable {
    Param(
        [Parameter (Mandatory=$True)] [string]   $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]   $VolumeId = $(throw "Please specify required Volume Id with the -VolumeId parameter"),
        [Parameter (Mandatory=$False)][int]      $RefreshCount = 10,
        [Parameter (Mandatory=$False)][timespan] $RefreshDelay = 10,
        [Parameter (Mandatory=$False)][string]   $RegionOverride = $Null
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
        Write-Debug -Message "Watch-CloudBlockStorageVolumeAvailable"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "VolumeId..........: $VolumeId" 
        Write-Debug -Message "RefreshCount......: $RefreshCount"
        Write-Debug -Message "RefreshDelay......: $RefreshDelay"
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.WaitForVolumeAvailable($VolumeId, $RefreshCount, $RefreshDelay, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Waits for a volume to be set to VolumeState.Available status.

 .DESCRIPTION
 The Watch-CloudBlockStorageVolumeAvailable cmdlet allows you to wait until a volume becomes available.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeId
 The unique identifier of an existing volume.

 .PARAMETER RefreshCount
 The number of times to check the volume status before giving up. Default value is 60.

 .PARAMETER RefreshDelay
 The number of seconds between checks on the volume status. Default value is 10 seconds.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Watch-CloudBlockStorageVolumeAvailable -Account demo -VolumeId c569c5eb-1ccc-4702-b64f-e6252a656b66 -RefreshCount 10
 This example will watch the volume, checking every 10 seconds until 10 attempts have been completed or the volume becomes available, whichever comes first.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolume_v1__tenant_id__volumes__volume_id__volumes.html
#>
}

#Issue #15 Get-CloudBlockStorageSnapshot
function Get-CloudBlockStorageSnapshot {
    Param(
        [Parameter (Mandatory=$True)] [string]   $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]   $SnapshotId = $(throw "Please specify required Snapshot Id with the -SnapshotId parameter"),
        [Parameter (Mandatory=$False)][string]   $RegionOverride = $Null
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
        Write-Debug -Message "Get-CloudBlockStorageSnapshot"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "SnapshotId........: $SnapshotId" 
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.ShowSnapshot($SnapshotId, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Get all information about a single snapshot.

 .DESCRIPTION
 The Get-CloudBlockStorageSnapshot cmdlet allows you to get all the information for a single snapshot.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER SnapshotId
 The unique identifier of an existing snapshot.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudBlockStorageSnapshot -Account demo -SnapshotId c569c5eb-1ccc-4702-b64f-e6252a656b66
 This example will get the detail information for the snapshot.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getSnapshot_v1__tenant_id__snapshots__snapshot_id__snapshots.html
#>
}

#Issue #16 Get-CloudBlockStorageVolumeTypes
function Get-CloudBlockStorageVolumeTypes {
    Param(
        [Parameter (Mandatory=$True)] [string]   $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$False)][string]   $RegionOverride = $Null
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
        Write-Debug -Message "Get-CloudBlockStorageVolumeTypes"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.ListVolumeTypes($Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Get a list of volume types.

 .DESCRIPTION
 The Get-CloudBlockStorageVolumeTypes cmdlet allows you to get a list of all available volume types.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-CloudBlockStorageVolumeTypes -Account demo
 This example will get the volume types for the default region associated with the account 'demo'.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolumeTypes_v1__tenant_id__types_volume_types.html
#>
}

#Issue #17 Watch-CloudBlockStorageSnapshotAvailable
function Watch-CloudBlockStorageSnapshotAvailable {
    Param(
        [Parameter (Mandatory=$True)] [string]   $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]   $SnapshotId = $(throw "Please specify required Snapshot Id with the -SnapshotId parameter"),
        [Parameter (Mandatory=$False)][int]      $RefreshCount = 600,
        [Parameter (Mandatory=$False)][datetime] $RefreshDelay = $Null,
        [Parameter (Mandatory=$False)][string]   $RegionOverride = $Null
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
        Write-Debug -Message "Watch-CloudBlockStorageSnapshotAvailable"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "SnapshotId........: $SnapshotId" 
        Write-Debug -Message "RefreshCount......: $RefreshCount"
        Write-Debug -Message "RefreshDelay......: $RefreshDelay"
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.WaitForSnapshotAvailable($SnapshotId, $RefreshCount, $RefreshDelay, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Waits for a snapshot to be set to SnapshotState.Available status.

 .DESCRIPTION
 The Watch-CloudBlockStorageSnapshotAvailable cmdlet allows you to wait until a snapshot becomes available.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER SnapshotId
 The unique identifier of an existing snapshot.

 .PARAMETER RefreshCount
 The number of times to check the volume status before giving up. Default value is 60.

 .PARAMETER RefreshDelay
 The number of seconds between checks on the volume status. Default value is 10 seconds.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Watch-CloudBlockStorageSnapshotAvailable -Account demo -SnapshotId c569c5eb-1ccc-4702-b64f-e6252a656b66 -RefreshCount 10
 This example will watch the snapshot, checking every 10 seconds until 10 attempts have been completed or the snapshot becomes available, whichever comes first.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getSnapshot_v1__tenant_id__snapshots__snapshot_id__snapshots.html
#>
}

#Issue #18 Watch-CloudBlockStorageVolumeDeleted
function Watch-CloudBlockStorageVolumeDeleted {
    Param(
        [Parameter (Mandatory=$True)] [string]   $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]   $VolumeId = $(throw "Please specify required Volume Id with the -VolumeId parameter"),
        [Parameter (Mandatory=$False)][int]      $RefreshCount = 10,
        [Parameter (Mandatory=$False)][Timespan] $RefreshDelay = 10,
        [Parameter (Mandatory=$False)][string]   $RegionOverride = $Null
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
        Write-Debug -Message "Watch-CloudBlockStorageVolumeDeleted"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "VolumeId..........: $VolumeId" 
        Write-Debug -Message "RefreshCount......: $RefreshCount"
        Write-Debug -Message "RefreshDelay......: $RefreshDelay"
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.WaitForVolumeDeleted($VolumeId, $RefreshCount, $RefreshDelay, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Waits for a volume to be deleted.

 .DESCRIPTION
 The Watch-CloudBlockStorageVolumeDeleted cmdlet allows you to wait until a volume is deleted.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeId
 The unique identifier of an existing volume.

 .PARAMETER RefreshCount
 The number of times to check the volume status before giving up. Default value is 60.

 .PARAMETER RefreshDelay
 The number of seconds between checks on the volume status. Default value is 10 seconds.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Watch-CloudBlockStorageVolumeDeleted -Account demo -VolumeId c569c5eb-1ccc-4702-b64f-e6252a656b66 -RefreshCount 10
 This example will watch the volume, checking every 10 seconds until 10 attempts have been completed or the volume is deleted, whichever comes first.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolume_v1__tenant_id__volumes__volume_id__volumes.html
#>
}

#Issue #19 Watch-CloudBlockStorageVolumeState
function Watch-CloudBlockStorageVolumeState {
    Param(
        [Parameter (Mandatory=$True)] [string]   $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]   $VolumeId = $(throw "Please specify required Volume Id with the -VolumeId parameter"),
        [Parameter (Mandatory=$True)] [net.openstack.Core.Domain.VolumeState]   $ExpectedState = $(throw "Please specify required Expected State with the -ExpectedState parameter"),
        [Parameter (Mandatory=$True)] [net.openstack.Core.Domain.VolumeState[]] $ErrorStates = $(throw "Please specify required Error States with the -ErrorStates parameter"),
        [Parameter (Mandatory=$False)][int]      $RefreshCount = 10,
        [Parameter (Mandatory=$False)][timespan] $RefreshDelay = 10,
        [Parameter (Mandatory=$False)][string]   $RegionOverride = $Null
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
        Write-Debug -Message "Watch-CloudBlockStorageVolumeState"
        Write-Debug -Message "Account...........: $Account"
        Write-Debug -Message "VolumeId..........: $VolumeId" 
        Write-Debug -Message "ExpectedState.....: $ExpectedState"
        Write-Debug -Message "ErrorStates.......: $ErrorStates"
        Write-Debug -Message "RefreshCount......: $RefreshCount"
        Write-Debug -Message "RefreshDelay......: $RefreshDelay"
        Write-Debug -Message "RegionOverride....: $RegionOverride" 

        $CloudBlockStorageProvider.WaitForVolumeState($VolumeId, $ExpectedState, $ErrorStates, $RefreshCount, $RefreshDelay, $Region, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Waits for a volume to be set to a particular VolumeState.

 .DESCRIPTION
 The Watch-CloudBlockStorageVolumeState cmdlet allows you to wait until a volume reaches a particular state.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file. You can also view them by executing the Show-CloudAccounts cmdlet.

 .PARAMETER VolumeId
 The unique identifier of an existing volume.

 .PARAMETER ExpectedState
 The expected state for the volume.
 
 .PARAMETER ErrorStates
 The error state(s) in which to stop polling once reached.

 .PARAMETER RefreshCount
 The number of times to poll the volume. Default value is 10.

 .PARAMETER RefreshDelay
 The refresh delay. The default value is 10 seconds.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Watch-CloudBlockStorageVolumeState -Account demo  -RegionOverride DFW -RefreshCount 2 -RefreshDelay (New-TimeSpan -seconds 3) -VolumeId 5267a607-f51f-4340-a870-529147cd9f1a -ExpectedState ([net.openstack.Core.Domain.VolumeState]::Available) -ErrorStates ([net.openstack.Core.Domain.VolumeState]::Creating)
 This example will watch the volume, checking every 3 seconds until 2 attempts have been completed or the volume is available, whichever comes first.

 .LINK
 http://docs.rackspace.com/cbs/api/v1.0/cbs-devguide/content/GET_getVolume_v1__tenant_id__volumes__volume_id__volumes.html
#>
}