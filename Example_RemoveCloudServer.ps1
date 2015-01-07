Clear
$servername = Read-Host 'What is the name of the server you wish to delete?'
$server = Get-CloudServers -Account demo | WHERE {$_.name -eq $servername}
Remove-CloudServer -Account demo -ServerId $server.id