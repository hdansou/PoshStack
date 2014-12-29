$scriptDir = Split-Path $MyInvocation.MyCommand.Definition -Parent
[Reflection.Assembly]::LoadFile("$scriptDir\Newtonsoft.Json.dll")
[Reflection.Assembly]::LoadFile("$scriptDir\SimpleRESTServices.dll")
[Reflection.Assembly]::LoadFile("$scriptDir\openstacknet.dll")
