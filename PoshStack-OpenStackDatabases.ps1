﻿<############################################################################################

PoshStack
Databases

    
Description
-----------
**TODO**

############################################################################################>

function Get-OpenStackDatabasesProvider {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account by using the -Account parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride = $(throw "Please specify required Region by using the -RegionOverride parameter")
    )

    # The Account comes from the file CloudAccounts.csv
    # It has information regarding credentials and the type of provider (Generic or Rackspace)

    Get-OpenStackAccount -Account $Account
    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    # Is this Rackspace or Generic OpenStack?
    switch ($Credentials.Type)
    {
        "Rackspace" {
            # Get Identity Provider
            $cloudId    = New-Object net.openstack.Core.Domain.CloudIdentity
            $cloudId.Username = $Credentials.CloudUsername
            $cloudId.APIKey   = $Credentials.CloudAPIKey
            $Global:CloudId = New-Object net.openstack.Providers.Rackspace.CloudIdentityProvider($cloudId)
            Return New-Object net.openstack.Providers.Rackspace.CloudDatabasesProvider($cloudId, $Region, $Null)

        }
        "OpenStack" {
            $CloudIdentityWithProject = New-Object net.openstack.Core.Domain.CloudIdentityWithProject
            $CloudIdentityWithProject.Password = $Credentials.CloudPassword
            $CloudIdentityWithProject.Username = $Credentials.CloudUsername
            $CloudIdentityWithProject.ProjectId = New-Object net.openstack.Core.Domain.ProjectId($Credentials.TenantId)
            $CloudIdentityWithProject.ProjectName = $Credentials.TenantId
            $Uri = New-Object System.Uri($Credentials.IdentityEndpointUri)
            $OpenStackIdentityProvider = New-Object net.openstack.Core.Providers.OpenStackIdentityProvider($Uri, $CloudIdentityWithProject)
            Return New-Object net.openstack.Providers.Rackspace.CloudDatabasesProvider($Null, $Region, $OpenStackIdentityProvider)
        }
    }
}

function New-OpenStackDatabaseInstance {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account by using the -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $InstanceName = $(throw "Please specify required Database Instance Name by using the -InstanceName parameter"),
        [Parameter (Mandatory=$True)] [string] $FlavorId = $(throw "Please specify required Database Flavor Id by using the -FlavorId parameter"),
        [Parameter (Mandatory=$False)][int]    $SizeInGB = 5,
        [Parameter (Mandatory=$False)][string] $RegionOverride
    )


    Get-OpenStackAccount -Account $Account
    
    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    $ComputeDatabasesProvider = Get-OpenStackDatabasesProvider -Account $Account -RegionOverride $Region

    try {

        # DEBUGGING       
        Write-Debug -Message "Get-OpenStackDatabases"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CancellationToken = New-Object ([System.Threading.CancellationToken]::None)
        $a = New-Object([net.openstack.Core.AsyncCompletionOption])
      #  $AsyncCompletionOption = New-Object ([net.openstack.Core.AsyncCompletionOption]::RequestCompleted)
        $AsyncCompletionOption = $a::RequestCompleted
        $flavorref = New-Object ([net.openstack.Providers.Rackspace.Objects.Databases.FlavorRef]) $FlavorId
        $dbVolumeConfig = New-Object ([net.openstack.Providers.Rackspace.Objects.Databases.DatabaseVolumeConfiguration]) $SizeInGB
        $dbInstanceConfig = New-Object -Type ([net.openstack.Providers.Rackspace.Objects.Databases.DatabaseInstanceConfiguration]) -ArgumentList @($flavorref, $dbVolumeConfig, $InstanceName)
        $dbInstanceConfig.GetType()
        $ComputeDatabasesProvider.CreateDatabaseInstanceAsync($dbInstanceConfig, [net.openstack.Core.AsyncCompletionOption]::RequestCompleted, $CancellationToken, $null).Result

    }
    catch {
        Invoke-Exception($_.Exception)
    }
}

function Get-OpenStackDatabase {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account by using the -Account parameter"),
        [Parameter (Mandatory=$True)] [string] $InstanceId = $(throw "Please specify required Database Instance Id by using the -InstanceId parameter"),
        [Parameter (Mandatory=$False)][string] $Marker = " ",
        [Parameter (Mandatory=$False)][int]    $Limit = 10000,
        [Parameter (Mandatory=$False)][string] $RegionOverride
    )


    Get-OpenStackAccount -Account $Account
    
    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    $ComputeDatabasesProvider = Get-OpenStackDatabasesProvider -Account $Account -RegionOverride $Region

    try {

        # DEBUGGING       
        Write-Debug -Message "Get-OpenStackDatabases"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "Marker........: $Marker"

        $CancellationToken = New-Object ([System.Threading.CancellationToken]::None)
        $iid = New-Object ([net.openstack.Providers.Rackspace.Objects.Databases.DatabaseInstanceId]) $InstanceId
        $mkr = New-Object ([net.openstack.Providers.Rackspace.Objects.Databases.DatabaseName]) $Marker

        $ComputeDatabasesProvider.ListDatabasesAsync($iid, $mkr, $Limit, $CancellationToken).Result

    }
    catch {
        Invoke-Exception($_.Exception)
    }
}

function New-OpenStackDatabase {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [net.openstack.Providers.Rackspace.Objects.Databases.DatabaseInstanceId] $DBInstanceId = $(throw "-DBInstanceId parameter"),
        [Parameter (Mandatory=$True)] [net.openstack.Providers.Rackspace.Objects.Databases.DatabaseConfiguration]    $DBConfiguration = $(throw "-DBConfiguration parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride
        )

    Get-OpenStackAccount -Account $Account
    
    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    $ComputeDatabasesProvider = Get-OpenStackDatabasesProvider -Account $Account -RegionOverride $Region

    try {

        # DEBUGGING       
        Write-Debug -Message "New-OpenStackDatabase"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CancellationToken = New-Object ([System.Threading.CancellationToken]::None)
        $ComputeDatabasesProvider.CreateDatabaseAsync($DBInstanceId, $DBConfiguration, $CancellationToken).Result

    }
    catch {
        Invoke-Exception($_.Exception)
    }
}

function Get-OpenStackDatabaseInstance {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$False)][string] $Marker = " ",
        [Parameter (Mandatory=$False)][int]    $Limit = 10000,
        [Parameter (Mandatory=$False)][string] $RegionOverride
        )

    Get-OpenStackAccount -Account $Account
    
    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    $ComputeDatabasesProvider = Get-OpenStackDatabasesProvider -Account $Account -RegionOverride $Region

    try {

        # DEBUGGING       
        Write-Debug -Message "Get-OpenStackDatabases"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CancellationToken = New-Object ([System.Threading.CancellationToken]::None)
        $mkr = New-Object ([net.openstack.Providers.Rackspace.Objects.Databases.DatabaseInstanceId]) $Marker
        $ComputeDatabasesProvider.ListDatabaseInstancesAsync($mkr, $Limit, $CancellationToken).Result
    }
    catch {
        Invoke-Exception($_.Exception)
    }
}

function Get-OpenStackDatabaseFlavor {
    Param(
        [Parameter (Mandatory=$True)] [string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$False)][string] $RegionOverride
        )

    Get-OpenStackAccount -Account $Account
    
    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    # Use Region code associated with Account, or was an override provided?
    if ($RegionOverride) {
        $Region = $Global:RegionOverride
    } else {
        $Region = $Credentials.Region
    }


    $ComputeDatabasesProvider = Get-OpenStackDatabasesProvider -Account $Account -RegionOverride $Region

    try {

        # DEBUGGING       
        Write-Debug -Message "Get-OpenStackDatabases"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 

        $CancellationToken = New-Object ([System.Threading.CancellationToken]::None)
        $ListOfFlavors = $ComputeDatabasesProvider.ListFlavorsAsync($CancellationToken).Result
        foreach ($dbflavor in $ListOfFlavors) {
            Add-Member -InputObject $dbflavor -MemberType NoteProperty -Name Region -Value $Region
        }
        return $ListOfFlavors

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Get the cloud database flavors in a region.

 .DESCRIPTION
 The Get-OpenStackDatabaseFlavors cmdlet retrieves a list of database flavors.
 
 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Get-OpenStackDatabaseFlavors -Account demo
 This example will get the flavors in the default region for the account "demo".

 .LINK
 http://docs.rackspace.com/cdb/api/v1.0/cdb-devguide/content/GET_getFlavors__version___accountId__flavors_flavors.html
#>
}