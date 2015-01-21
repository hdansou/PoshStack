# Getting Started with PoshStack
## About this document
This document will describe the steps required to install and get started with the PoshStack Powershell client.

### This document has the following sections:
1. About PoshStack
2. Installing PoshStack
3. PoshStack Configuration
4. How to create a Virtual Machine using PoshStack
5. How to use Containers using PoshStack

## 1. About PoshStack
PoshStack is built on the OpenStack .NET SDK, a collection of assemblies that encapsulate OpenStack API calls. Because it is built on the SDK -- as opposed to direct RESTful API calls -- PoshStack is updated whenever the SDK assemblies are updated.

PoshStack requires Windows Management Framework 5.0 or higher.


## 2. Installing PoshStack
PoshStack, like any Powershell module, should be installed in a path that is listed in the PSModulePath environment variable.
The preferred method of installation is a two step process:
 1. Use Nuget to download the bits;
 2. Rename the resulting folder

### Using the Nuget command line option from within the PowerShell modules folder to download the bits:

**Don't have Nuget?**
Download it here: http://docs.nuget.org/docs/start-here/installing-nuget

To see the valid paths, run the following Powershell command:

```PowerShell
$env:PSModulePath
```

which will produce a result somewhat like the following:

```dos
C:\Users\Administrator\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\Windows\system32\WindowsPowerShell\v1.0\Modules\
```


The first part of the path, C:\Users\Administrator\Documents\WindowsPowerShell\Modules, is typically the location for the new PoshStack folder. That is to say, place the PoshStack modules into the following folder:

```dos
C:\Users\Administrator\Documents\WindowsPowerShell\Modules\PoshStack
```

For more details, see the following:

http://msdn.microsoft.com/en-us/library/dd878350(v=vs.85).aspx

Move to that directory...
```dos
CD C:\Users\Administrator\Documents\WindowsPowerShell\Modules
```

and install PoshStack:

```dos
Nuget install PoshStack -ExcludeVersion
```



## 3. PoshStack Configuration

PoshStack allows you to configure several accounts from which you can choose during runtime. For example, you may have
an account that has "IAD" as it's default region, whereas a different account may have "DFW" as it's default region.

To configure the accounts, you must edit the file "CloudAccounts.csv" in the PoshStack folder. It's a comma-separated
values file that contains your user name, API key and tenant id, as well as other information.

You will give the accounts a name, and use that name in your PoshStack cmdlets. For example, if
you have an account named "demo", you would use the -Account parameter as follows:

```PowerShell
-Account demo
```



## 4. How to create a Virtual Machine using PoshStack

Once you've installed PoshStack on your system, you need to reference it using the following Powershell command:

```PowerShell
Import-Module PoshStack
```

Once you've done that, you're ready to use PoshStack. Creating a virtual machine, also
know has "spinning up a server", is as simple as using the New-CloudServer cmdlet:

```PowerShell
New-CloudServer -Account demo -ServerName MyNewServer -ImageId d69d55ef-cb4c-4787-9f1b-2de41ecac9a1 -FlavorId Performance1-2 -AttachToServiceNetwork $true -AttachToPublicNetwork $true
```

Rather than explain this command here, use the following cmdlet in Powershell to get more information about New-CloudServer:

```PowerShell
Get-Help New-CloudServer -Full
```


## 5. How to use Containers using PoshStack
Cloud Files Containers allow you to store and retrieve objects in the cloud.

### Creating a Cloud Files Container
You can create a Cloud Files Container using the New-CloudFilesConatiner cmdlet. The only required information is the PoshStack account name and the name of the container:
```PowerShell
New-CloudFilesContainer -Account demo -ContainerName MyNewContainer
```

### Uploading an Object to a Container
Objects are uploaded to a container using the Add-CloudFilesObjectFromFile cmdlet:
```PowerShell
Add-CloudFilesObjectFromFile -Account demo -FilePath C:\temp\kittens.jpg -ContainerName MyNewContainer
```

### Downloading an Object from a Container
Objects are downloaded from a container using the Copy-CloudFilesObject cmdlet:
```Powershell
Copy-CloudFilesObject -Account demo -ContainerName MyNewContainer -Object kittens.jpg
```
