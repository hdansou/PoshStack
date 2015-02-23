# Upload a folder to a container
$filelist = Get-ChildItem -Path "C:\temp"
New-OpenStackObjectStorageContainer -Account rackiad -ContainerName "BigTest"
foreach ($f in $filelist) {
    
    Write-Host $f.FullName

    Add-OpenStackObjectStorageObjectFromFile -Account rackiad -ContainerName "BigTest" -FilePath $f.FullName -ObjectName $f.BaseName
}
Write-Host "***************** FINISHED! ********************"