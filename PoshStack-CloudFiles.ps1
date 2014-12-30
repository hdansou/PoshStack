<############################################################################################

PoshStack
                                                    Cloud Files

    
Description
-----------
**TODO**

############################################################################################>

#CopyStream
#BulkDelete
#CopyObject

#CreateContainer
function New-CloudFilesContainer{
    Param(
        [Parameter (Mandatory=$True)][string] $Account = $(throw "Please specify required Cloud Account with -Account parameter"),
        [Parameter (Mandatory=$True)][string] $ContainerName,
        [Parameter (Mandatory=$False)][hashtable] $Headers,
        [Parameter (Mandatory=$False)][bool] $UseInternalUrl,
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
        Write-Debug -Message "ContainerName......: $ContainerName" 
        Write-Debug -Message "UseInternalUrl.....: $UseInternalUrl" 


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
 This example will the container "MyTestContainer" in the default region for the account "demo".

 .LINK
 http://docs.rackspace.com/servers/api/v2/cs-devguide/content/Volume_Attachment_Actions.htmlhttp://docs.rackspace.com/files/api/v1/cf-devguide/content/PUT_createcontainer_v1__account___container__containerServicesOperations_d1e000.html
#>
}

#CreateFormPostUri
#CreateObject
#CreateObjectFromFile
#CreateTemporaryPublicUri
#DeleteContainer
#DeleteContainerMetadata
#DeleteContainerMetadata
#DeleteObject
#DeleteObjectMetadata
#DeleteObjectMetadata
#DeleteObjects
#DisableCDNOnContainer
#DisableStaticWebOnContainer
#EnableCDNOnContainer
#EnableCDNOnContainer
#EnableCDNOnContainer
#EnableStaticWebOnContainer
#EnableStaticWebOnContainer
#EnableStaticWebOnContainer
#EnableStaticWebOnContainer
#ExtractArchive
#ExtractArchiveFromFile
#GetAccountHeaders
#GetAccountMetaData
#GetContainerCDNHeader
#GetContainerHeader
#GetContainerMetaData
#GetObject
#GetObjectHeaders
#GetObjectMetaData
#GetObjectSaveToFile
#ListCDNContainers
#ListContainers
#ListObjects
#MoveObject
#PurgeObjectFromCDN
#UpdateAccountMetadata
#UpdateContainerCdnHeaders
#UpdateContainerMetadata
#UpdateObjectMetadata
#GetServiceEndpointCloudFiles
#GetServiceEndpointCloudFilesCDN
#VerifyContainerIsCDNEnabled