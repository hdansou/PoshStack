Remove-Module PoshStack
Import-Module PoshStack
Remove-CloudFilesObjects -Account demo -ContainerName "Container1" -RegionOverride "ORD" -ItemsToDelete ("book.docx") -Headers @{"foo"="bar"}