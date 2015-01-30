#PoshStack

#Description
PoshStack is a Microsoft PowerShell v3 (or higher) client for OpenStack, built on the OpenStack.NET SDK v1.

The goal of this project is to give complete command line access to the OpenStack automation environment from the Windows PowerShell client, allowing Windows system administrators, DevOps engineers and developers to easily and quickly manage and automate their work.

## Installation is so easy...

### Prerequisite
PoshStack requires Windows Management Framework 3.0 (or newer).

### Installation and Configuration
Installation requires two steps: Install and Configure. PoshStack is installed using PsGet

1. Open a PowerShell prompt and run the following two lines:
```bash
(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
install-module PoshStack
```
2. Update the CloudAccounts.csv file with your cloud account credentials:  
  * _CloudName_ - User-defined name for the account. This can be pretty much anything you desire, and it's only used in the context of PoshStack. For example, you may choose to name the accounts based on the default regions you assign to them. This _CloudName_ is **not** the same as your _CloudUsername_.
  * CloudUsername - This is your Openstack user name.
  * CloudAPIKey - This is your API key.
  * CloudDDI - This is your account number.
  * Region - This is your default region. Hint: For DevStack, this is "RegionOne".

#### An example of the contents of CloudAccounts.csv

AccountName,CloudUsername,CloudAPIKey,CloudDDI,Region
dummy1,clouduser,a3s45df6g78h9jk098h7g6f5d4s4d5f5,12345678,IAD
dummy2,dummyuser,a3s45df6g78h9jk098h7g6f5d4s4d5f6,87654321,dfw

## Contributing is a cinch as well...
Make your contribution to the goodness. Fork the code, pick an issue, and get coding. If you're unsure where to start or what it all means, choose an issue and leave a comment, asking for assistance.
