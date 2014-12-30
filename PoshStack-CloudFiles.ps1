<############################################################################################

PoshStack
                                                    Cloud Files

    
Description
-----------
**TODO**

############################################################################################>

#CopyStream

#BulkDelete **TODO**
function Remove-CloudFilesObjects{
}

#CopyObject **TODO**
function Copy-CloudFilesobject{
}

#CreateContainer
function New-CloudFilesContainer{
    Param(
        [Parameter (Mandatory=$True)] [string]    $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]    $ContainerName = $(throw "Please specify required Container Name with -ContainerName parameter"),
        [Parameter (Mandatory=$False)][hashtable] $Headers,
        [Parameter (Mandatory=$False)][bool]      $UseInternalUrl,
        [Parameter (Mandatory=$False)][string]    $RegionOverride
        )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Servers Provider
        $cloudFilesProvider = New-Object net.openstack.Providers.Rackspace.CloudFilesProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "New-CloudFilesContainer"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "ContainerName.: $ContainerName" 
        Write-Debug -Message "UseInternalUrl: $UseInternalUrl" 


        return $cloudFilesProvider.CreateContainer($ContainerName, $Headers, $Region, $UseInternalUrl, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }
<#
 .SYNOPSIS
 Create a Cloud Files Container.

 .DESCRIPTION
 The New-CloudFilesContainer cmdlet creates a Cloud Files container. Containers are storage compartments for your data. The URL-encoded name must be no more than 256 bytes and cannot contain a forward slash character (/). You can create up to 500,000 containers in your Cloud Files account.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ContainerName
 The unique identifier of the container.

 .PARAMETER Headers
 The metadata for this container:
 X-Container-Meta-name (Optional)
 Custom container metadata. Replace name at the end of the header with the name for your metadata.

 X-Container-Read (Optional)
 Sets an access control list (ACL) that grants read access. This header can contain a comma-delimited list of users that can read the container (allows the GET method for all objects in the container).

 X-Container-Write (Optional)
 Sets an ACL that grants write access. This header can contain a comma-delimited list of users that can write to the container (allows PUT, POST, COPY, and DELETE methods for all objects in the container).

 X-Versions-Location (Optional)
 Enables versioning on this container. The value is the name of another container. You must UTF-8-encode and then URL-encode the name before you include it in the header. To disable versioning, set the header to an empty string.

 .PARAMETER UseInternalUrl
 Use the endpoint internal URL instead of the endpoint Public URL. 

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> New-CloudFileContainer -Account demo -ContainerName "MyTestContainer"
 This example will create the container "MyTestContainer" in the default region for the account "demo".

 .LINK
 http://docs.rackspace.com/files/api/v1/cf-devguide/content/PUT_createcontainer_v1__account___container__containerServicesOperations_d1e000.html
#>
}

#CreateFormPostUri

#CreateObject **TODO**
function Add-CloudFilesObject{
}

#CreateObjectFromFile **TODO**
function Add-CloudFilesObjectFromFile{
    Param(
        [Parameter (Mandatory=$True)] [string]    $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)] [string]    $ContainerName = $(throw "Please specify required Container Name with -ContainerName parameter"),
        [Parameter (Mandatory=$True)] [string]    $FilePath = $("Please specify required File Path with the -FilePath parameter"),
        [Parameter (Mandatory=$False)][string]    $ObjectName,
        [Parameter (Mandatory=$False)][string]    $ContentType,
        [Parameter (Mandatory=$False)][int]       $ChunkSize = 4096,
        [Parameter (Mandatory=$False)][hashtable] $Headers = $Null,
        [Parameter (Mandatory=$False)][bool]      $UseInternalUrl = $False,
        [Parameter (Mandatory=$False)][string]    $RegionOverride
        )

    Get-CloudAccount($Account)

    if ($RegionOverride){
        $Global:RegionOverride = $RegionOverride
    }

    try {

        # Get Identity Provider
        $cloudId = Get-CloudIdentityProvider -Username $Credentials.CloudUsername -APIKey $Credentials.CloudAPIKey

        # Get Cloud Servers Provider
        $cloudFilesProvider = New-Object net.openstack.Providers.Rackspace.CloudFilesProvider

        # Use Region code associated with Account, or was an override provided?
        if ($RegionOverride) {
            $Region = $Global:RegionOverride
        } else {
            $Region = $Credentials.Region
        }

        # DEBUGGING       
        Write-Debug -Message "Add-CloudFilesObjectFromFile"
        Write-Debug -Message "Account.......: $Account" 
        Write-Debug -Message "cloudId.......: $cloudId"
        Write-Debug -Message "RegionOverride: $RegionOverride" 
        Write-Debug -Message "ContainerName.: $ContainerName" 
        Write-Debug -Message "UseInternalUrl: $UseInternalUrl" 
        Write-Debug -Message "FilePath......: $FilePath"
        Write-Debug -Message "ObjectName....: $ObjectName"
        Write-Debug -Message "ContentType...: $ContentType"
        Write-Debug -Message "ChunkSize.....: $ChunkSize"
        Write-Debug -Message "Headers.......: $Headers"

        
        $cloudFilesProvider.CreateObjectFromFile($ContainerName, $FilePath, $ObjectName, $ContentType, $ChunkSize, $Headers, $Region, $null, $UseInternalUrl, $cloudId)
        #return $cloudFilesProvider.CreateObjectFromFile("MyStuff", "C:\temp\w-brand.png", $Null, $Null, 4096, $Null, "ORD", $null, $false, $cloudId)

    }
    catch {
        Invoke-Exception($_.Exception)
    }

<#
 .SYNOPSIS
 Creates or updates the content and metadata for a specified object.

 .DESCRIPTION
 The Add-CloudFilesObjectFromFile cmdlet creates a Cloud Files object by reading and uploading the object from the given file path.

 .PARAMETER Account
 Use this parameter to indicate which account you would like to execute this request against. 
 Valid choices are defined in PoshStack configuration file.

 .PARAMETER ContainerName
 The unique identifier of the container.

 .PARAMETER FilePath
 The source file path, e.g. "C:\temp\foo.jpg".

 .PARAMETER ObjectName
 The name assigned to the object in the container. If omitted, the file name (from -FilePath) will be used.

 .PARAMETER ContentType
 The content type. If omitted, it will be automatically determined by the file name.

 .PARAMETER ChunkSize
 The buffer size to use for copying streaming data.

 .PARAMETER Headers
 The metadata information for the object.

 .PARAMETER UseInternalUrl
 Use the endpoint internal URL instead of the endpoint Public URL. 

 .PARAMETER RegionOverride
 This parameter will temporarily override the default region set in PoshStack configuration file. 

 .EXAMPLE
 PS C:\Users\Administrator> Add-CloudFilesObjectFromFile -Account demo -ContainerName "MyTestContainer" -FilePath "C:\test\helloworld.jpg" -ObjectName "Hello_World.jpg"
 This example will copy the local file "C:\test\helloworld.jpg" to the container "MyTestContainer", in the default region, and rename it to "Hello_World.jpg".

 .LINK
 http://docs.rackspace.com/files/api/v1/cf-devguide/content/PUT_createobject_v1__account___container___object__objectServicesOperations_d1e000.html
#>
}

#CreateTemporaryPublicUri

#DeleteContainer **TODO**
function Remove-CloudFilesContainer{
}

#DeleteContainerMetadata **TODO**
function Remove-CloudFilesContainerMetadata{
}

#DeleteObject **TODO**
function Remove-CloudFilesObject{
}

#DeleteObjectMetadata **TODO**
function Remove-CloudFilesObjectMetadata{
}

#DeleteObjects **TODO**
function Remove-CloudFilesObjects{
}

#DisableCDNOnContainer **TODO**
function Disable-CloudFilesContainerCDN{
}

#DisableStaticWebOnContainer **TODO**
function Disable-CloudFilesStaticWebOnContainer{
}

#EnableCDNOnContainer **TODO**
function Enable-CloudFilesContainerCDN{
}

#EnableStaticWebOnContainer **TODO**
function Enable-CloudFilesStaticWebOnContainer{
}

#ExtractArchive
#ExtractArchiveFromFile
#GetAccountHeaders
#GetAccountMetaData

#GetContainerCDNHeader **TODO*
function Get-CloudFilesContainerCDNHeader{
}

#GetContainerHeader **TODO**
function Get-CloudFilesHeader{
}

#GetContainerMetaData **TODO**
function Get-CloudFilesContainerMetadata{
}

#GetObject **TODO**
function Get-CloudFilesObject{
}

#GetObjectHeaders **TODO**
function Get-CloudFilesObjectHeaders{
}

#GetObjectMetaData **TODO**
function Get-CloudFilesObjectMetadata{
}

#GetObjectSaveToFile **TODO**
function Copy-CloudFilesObjectToFile{
}

#ListCDNContainers **TODO** (use -CDN switch)
#ListContainers **TODO**
function Get-CloudFilesContainers{
}

#ListObjects **TODO**
function Get-CloudFilesObjects{
}

#MoveObject **TODO**
function Move-CloudFilesObject{
}

#PurgeObjectFromCDN **TODO**
function Clear-CloudFilesObjectFromCDN{
}

#UpdateAccountMetadata

#UpdateContainerCdnHeaders **TODO**
function Update-CloudFilesContainerCDNHeaders{
}

#UpdateContainerMetadata **TODO**
function Update-CloudFilesContainerMetadata{
}

#UpdateObjectMetadata **TODO**
function Update-CloudFilesObjectMetadata{
}

#GetServiceEndpointCloudFiles
#GetServiceEndpointCloudFilesCDN

#VerifyContainerIsCDNEnabled **TODO**
function Test-CloudFilesContainerCDNEnabled{
}