targetScope = 'subscription'

metadata name = 'WAF-aligned'
metadata description = 'This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-cache.redis-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'nhnwaf'

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceLocation
}

// Diagnostics
// ===========
module diagnosticDependencies '../../../../../../utilities/e2e-template-assets/templates/diagnostic.dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-diagnosticDependencies'
  params: {
    storageAccountName: 'dep${namePrefix}diasa${serviceShort}01'
    logAnalyticsWorkspaceName: 'dep-${namePrefix}-law-${serviceShort}'
    eventHubNamespaceEventHubName: 'dep-${namePrefix}-evh-${serviceShort}'
    eventHubNamespaceName: 'dep-${namePrefix}-evhns-${serviceShort}'
    location: resourceLocation
  }
}

// ============== //
// Test Execution //
// ============== //

var addressPrefix = '10.0.0.0/16'

@batchSize(1)
module testDeployment '../../../main.bicep' = [for iteration in [ 'init', 'idem' ]: {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}-${iteration}'
  params: {
    // You parameters go here
    name: '${namePrefix}${serviceShort}001'
    location: resourceLocation
    hubVirtualNetworks: {
      hub1: {
        name: 'hub1'
        addressPrefixes: addressPrefix
        diagnosticSettings: [
          {
            name: 'customSetting'
            metricCategories: [
              {
                category: 'AllMetrics'
              }
            ]
            eventHubName: diagnosticDependencies.outputs.eventHubNamespaceEventHubName
            eventHubAuthorizationRuleResourceId: diagnosticDependencies.outputs.eventHubAuthorizationRuleId
            storageAccountResourceId: diagnosticDependencies.outputs.storageAccountResourceId
            workspaceResourceId: diagnosticDependencies.outputs.logAnalyticsWorkspaceResourceId
          }
        ]
        dnsServers: [ '10.0.1.4', '10.0.1.5' ]
        lock: {
          kind: 'CanNotDelete'
          name: 'hub1CustomLockName'
        }
        enableTelemetry: true
        flowTimeoutInMinutes: 20
        location: 'westeurope'
        subnets: {
          GatewaySubnet: {
            name: 'GatewaySubnet'
            addressPrefix: cidrSubnet(addressPrefix, 26, 0)
          }
          AzureFirewallSubnet: {
            name: 'AzureFirewallSubnet'
            addressPrefix: cidrSubnet(addressPrefix, 26, 0)
          }
          AzureBastionSubnet: {
            name: 'AzureBastionSubnet'
            addressPrefix: cidrSubnet(addressPrefix, 26, 0)
          }
        }
      }
    }
  }
}]