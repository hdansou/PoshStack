#PoshStack Milestone 6: Cloud Load Balancers

## Initial coverage of Cloud Load Balancers, to include the following OpenStack.NET SDK functions:

| SDK Method                            | PoshStack cmdlet                            |
|---------------------------------------|---------------------------------------------|
| AddLoadBalancerMetadataAsync          | Add-CloudLoudBalancerMetadata               |
| AddNodeAsync                          | Add-CloudLoadBalancerNode                   |
| AddNodeMetadataAsync                  | Add-CloudLoadBalancerNodeMetadata           |
| AddNodeRangeAsync                     | Add-CloudLoadBalancerNodeRange              |
| AddVirtualAddressAsync                | Add-CloudLoadBalancerVirtualAddress         |
| ClearAccessListAsync                  | Clear-CloudLoadBalancerAccessList           |
| CreateLoadBalancerAsync               | New-CloudLoadBalancer                       |
| GetConnectionLoggingAsync             | Get-CloudLoadBalancerConnectionLogging      |
| GetContentCachingAsync                | Get-CloudLoadBalancerContentCaching         |
| GetErrorPageAsync                     | Get-CloudLoadBalancerErrorPage              |
| GetHealthMonitorAsync                 | Get-CloudLoadBalancerHealthMonitor          |
| GetLoadBalancerAsync                  | Get-CloudLoadBalancer                       |
| GetLoadBalancerMetadataItemAsync      | Get-CloudLoadBalancerMetadataItem           |
| GetNodeAsync                          | Get-CloudLoadBalancerNode                   |
| GetNodeMetadataItemAsync              | Get-CloudLoadBalancerNodeMetadataItem       |
| GetSessionPersistenceAsync            | Get-CloudLoadBalancerSessionPersistence     |
| GetSslConfigurationAsync              | Get-CloudLoadBalancerSslConfiguration       |
| GetStatisticsAsync                    | Get-CloudLoadBalancerStatistics             |
| ListAccessListAsync                   | Get-CloudLoadBalancerAccessList             |
| ListAccountLevelUsageAsync            | Get-CloudLoadBalancerAccountLevelUsage      |
| ListAlgorithmsAsync                   | Get-CloudLoadBalancerAlgorithms             |
| ListAllowedDomainsAsync               | Get-CloudLoadBalancerAllowedDomains         |
| ListBillableLoadBalancersAsync        | Get-CloudLoadBalancerBillableLBs            |
| ListCurrentUsageAsync                 | Get-CloudLoadBalancerCurrentUsage           |
| ListHistoricalUsageAsync              | Get-CloudLoadBalancerHistoricalUsage        |
| ListLoadBalancerMetadataAsync         | Get-CloudLoadBalancerMetadata               |
| ListLoadBalancersAsync                | Get-CloudLoadBalancers                      |
| ListNodeMetadataAsync                 | Get-CloudLoadBalancerNodeMetadata           |
| ListNodesAsync                        | Get-CloudLoadBalancerNodes                  |
| ListNodeServiceEventsAsync            | Get-CloudLoadBalancerNodeServiceEvents      |
| ListProtocolsAsync                    | Get-CloudLoadBalancerProtocols              |
| ListThrottlesAsync                    | Get-CloudLoadBalancerThrottles              |
| ListVirtualAddressesAsync             | Get-CloudLoadBalancerVirtualAddresses       |
| RemoveAccessListAsync                 | Remove-CloudLoadBalancerAccessList          |
| RemoveAccessListRangeAsync            | Remove-CloudLoadBalancerAccessListRange     |
| RemoveErrorPageAsync                  | Remove-CloudLoadBalancerErrorPage           |
| RemoveHealthMonitorAsync              | Remove-CloudLoadBalancerHealthMonitor       |
| RemoveLoadBalancerAsync               | Remove-CloudLoadBalancer                    |
| RemoveLoadBalancerMetadataItemAsync   | Remove-CloudLoadBalancerMetadataItem        |
| RemoveLoadBalancerRangeAsync          | Remove-CloudLoadBalancerRange               |
| RemoveNodeAsync                       | Remove-CloudLoadBalancerNode                |
| RemoveNodeMetadataItemAsync           | Remove-CloudLoadBalancerNodeMetadataItem    |
| RemoveNodeRangeAsync                  | Remove-CloudLoadBalancerNodeRange           |
| RemoveSessionPersistenceAsync         | Remove-CloudLoadBalancerSessionPersistence  |
| RemoveSslConfigurationAsync           | Remove-CloudLoadBalancerSslConfiguration    |
| RemoveThrottlesAsync                  | Remove-CloudLoadBalancerThrottles           |
| RemoveVirtualAddressAsync             | Remove-CloudLoadBalancerVirtualAddress      |
| RemoveVirtualAddressRangeAsync        | Remove-CloudLoadBalancerVirtualAddressRange |
| SetConnectionLoggingAsync             | Set-CloudLoadBalancerConnectionLogging      |
| SetContentCachingAsync                | Set-CloudLoadBalancerContentCaching         |
| SetErrorPageAsync                     | Set-CloudLoadBalancerErrorPage              |
| SetHealthMonitorAsync                 | Set-CloudLoadBalancerHealthMonitor          |
| SetSessionPersistenceAsync            | Set-CloudLoadBalancerSessionPersistence     |
| UpdateLoadBalancerAsync               | Update-CloudLoadBalancer                    |
| UpdateLoadBalancerMetadataItemAsync   | Update-CloudLoadBalancerMetadataItem        |
| UpdateNodeAsync                       | Update-CloudLoadBalancerNode                |
| UpdateNodeMetadataItemAsync           | Update-CloudLoadBalancerNodeMetadataItem    |
| UpdateSslConfigurationAsync           | Update-CloudLoadBalancerSslConfiguration    |
| UpdateThrottlesAsync                  | Update-CloudLoadBalancerThrottles           |
| GetBaseUriAsync                       | Get-CloudLoadBalancerBaseUri                |
| WaitForLoadBalancersToLeaveStateAsync | Watch-CloudLoadBalancersToLeaveState        |
| WaitForLoadBalancerToLeaveStateAsync  | Watch-CloudLoadBalancerToLeaveState         |
