Clear
$Servername = Read-Host 'What is the name of the server you wish to create?'
$Flavor = 'performance1-2'
$Image = Get-CloudServerImages -Account demo | WHERE {$_.Name -eq 'CentOS 5.11'}
New-CloudServer -Account demo -ServerName $Servername -ImageId $Image.Id -FlavorId $Flavor -AttachToServiceNetwork $true -AttachToPublicNetwork $true | out-file C:\TEMP\$servername.txt