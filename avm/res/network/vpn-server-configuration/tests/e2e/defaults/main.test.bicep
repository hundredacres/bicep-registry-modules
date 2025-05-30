targetScope = 'subscription'

metadata name = 'Using only defaults'
metadata description = 'This instance deploys the module with the minimum set of required parameters.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-network.vpnserverconfiguration-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'vscmin'

@description('Optional. A token to inject into the name of each resource. This value can be automatically injected by the CI.')
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

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-nestedDependencies'
  params: {
    virtualWANName: 'dep-${namePrefix}-vw-${serviceShort}'
    location: resourceLocation
  }
}

// ============== //
// Test Execution //
// ============== //

@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}-${iteration}'
    params: {
      name: '${namePrefix}${serviceShort}VPNConfig'
      aadAudience: '11111111-1234-4321-1234-111111111111'
      aadIssuer: 'https://sts.windows.net/11111111-1111-1111-1111-111111111111/'
      aadTenant: '${environment().authentication.loginEndpoint}11111111-1111-1111-1111-111111111111'
      p2sConfigurationPolicyGroups: [
        {
          userVPNPolicyGroupName: 'DefaultGroup'
          policymembers: [
            {
              name: 'UserGroup1'
              attributeType: 'AADGroupId'
              attributeValue: '11111111-1111-2222-3333-111111111111'
            }
          ]
          priority: '0'
          isDefault: 'true'
        }
      ]
      vpnAuthenticationTypes: [
        'AAD'
      ]
      vpnProtocols: [
        'OpenVPN'
      ]
    }
  }
]
