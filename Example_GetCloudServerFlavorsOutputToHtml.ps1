Clear 
Get-CloudServerFlavors -Account demo | ConvertTo-Html | Out-File C:\Temp\get_cloudserverflavors.html
Invoke-Expression C:\Temp\get_cloudserverflavors.html