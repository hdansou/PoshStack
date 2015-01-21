Clear
$Servername = Read-Host 'What is the name of the server you wish to create?'
$Flavor = 'performance1-2'
$Image = Get-CloudServerImages -Account demo | WHERE {$_.Name -contains 'CentOS 6 (PV)'}

$meta = New-Object net.openstack.Core.Domain.Metadata
$meta.Add("first","1")
$meta.Add("second","2")
New-CloudServer -Account demo -ServerName $Servername -ImageId $Image.Id -FlavorId $Flavor -AttachToServiceNetwork $true -AttachToPublicNetwork $true