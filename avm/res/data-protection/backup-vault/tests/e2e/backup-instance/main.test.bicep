targetScope = 'subscription'

metadata name = 'Using large parameter set'
metadata description = 'This instance deploys the module with most of its features enabled.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-dataprotection.backupvaults-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'dpbvbi'

@description('Generated. Used as a basis for unique resource names.')
param baseTime string = utcNow('u')

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '#_namePrefix_#'

var dataSourceType = 'Microsoft.Compute/disks'
var resourceType = 'Microsoft.Compute/disks'

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
    managedIdentityName: 'dep-${namePrefix}-msi-${serviceShort}'
    diskName: 'dep-${namePrefix}-disk-${serviceShort}-${substring(uniqueString(baseTime), 0, 3)}'
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
      name: '${namePrefix}${serviceShort}001'
      location: resourceLocation
      roleAssignments: [
        {
          name: 'cbc3932a-1bee-4318-ae76-d70e1ba399c8'
          roleDefinitionIdOrName: 'Owner'
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
        {
          name: guid('Custom seed ${namePrefix}${serviceShort}')
          roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
        {
          roleDefinitionIdOrName: subscriptionResourceId(
            'Microsoft.Authorization/roleDefinitions',
            'acdd72a7-3385-48ef-bd42-f606fba81ae7'
          )
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
        {
          roleDefinitionIdOrName: subscriptionResourceId(
            'Microsoft.Authorization/roleDefinitions',
            '3e5e47e6-65f7-47ef-90b5-e5dd4d455f24'
          )
          principalId: reference(
            resourceId('Microsoft.DataProtection/backupVaults', '${namePrefix}${serviceShort}001'),
            '2023-05-01',
            'Full'
          ).identity.principalId
        }
        {
          roleDefinitionIdOrName: subscriptionResourceId(
            'Microsoft.Authorization/roleDefinitions',
            '7efff54f-a5b4-42b5-a1c5-5411624893ce'
          )
          principalId: reference(
            resourceId('Microsoft.DataProtection/backupVaults', '${namePrefix}${serviceShort}001'),
            '2023-05-01',
            'Full'
          ).identity.principalId
        }
      ]
      azureMonitorAlertSettingsAlertsForAllJobFailures: 'Disabled'
      managedIdentities: {
        systemAssigned: true
      }
      backupPolicies: [
        {
          name: 'DefaultPolicy'
          properties: {
            datasourceTypes: [
              'Microsoft.Compute/disks'
            ]
            objectType: 'BackupPolicy'
            policyRules: [
              {
                backupParameters: {
                  backupType: 'Incremental'
                  objectType: 'AzureBackupParams'
                }
                dataStore: {
                  dataStoreType: 'OperationalStore'
                  objectType: 'DataStoreInfoBase'
                }
                name: 'BackupDaily'
                objectType: 'AzureBackupRule'
                trigger: {
                  objectType: 'ScheduleBasedTriggerContext'
                  schedule: {
                    repeatingTimeIntervals: [
                      'R/2022-05-31T23:30:00+01:00/P1D'
                    ]
                    timeZone: 'W. Europe Standard Time'
                  }
                  taggingCriteria: [
                    {
                      isDefault: true
                      taggingPriority: 99
                      tagInfo: {
                        id: 'Default_'
                        tagName: 'Default'
                      }
                    }
                  ]
                }
              }
              {
                isDefault: true
                lifecycles: [
                  {
                    deleteAfter: {
                      duration: 'P7D'
                      objectType: 'AbsoluteDeleteOption'
                    }
                    sourceDataStore: {
                      dataStoreType: 'OperationalStore'
                      objectType: 'DataStoreInfoBase'
                    }
                    targetDataStoreCopySettings: []
                  }
                ]
                name: 'Default'
                objectType: 'AzureRetentionRule'
              }
            ]
          }
        }
      ]
      backupInstances: [
        {
          name: nestedDependencies.outputs.computeDiskName
          properties: {
            objectType: 'BackupInstance'
            dataSourceInfo: {
              objectType: 'DataSource'
              resourceId: nestedDependencies.outputs.computeDiskId
              resourceName: nestedDependencies.outputs.computeDiskName
              resourceType: resourceType
              resourceUri: nestedDependencies.outputs.computeDiskId
              resourceLocation: resourceLocation
              daraSourceType: dataSourceType
            }
            policyInfo: {
              name: 'DefaultPolicy'
              policyId: resourceId(
                'Microsoft.DataProtection/backupVaults/backupPolicies',
                '${namePrefix}${serviceShort}001',
                'DefaultPolicy'
              )
              policyParameters: {
                dataStoreParametersList: [
                  {
                    objectType: 'AzureOperationalStoreParameters'
                    dataStoreType: 'OperationalStore'
                    resourceGroupId: resourceGroup.id
                  }
                ]
              }
            }
          }
        }
      ]
      lock: {
        kind: 'CanNotDelete'
        name: 'myCustomLockName'
      }
      tags: {
        'hidden-title': 'This is visible in the resource name'
        Environment: 'Non-Prod'
        Role: 'DeploymentValidation'
      }
    }
    dependsOn: [
      nestedDependencies
    ]
  }
]
