metadata name = 'Data Protection Backup Vault Backup Instance'
metadata description = 'This module deploys a Data Protection Backup Vault Backup Instance.'
metadata owner = 'Azure/module-maintainers'

@description('Required. The name of the backup vault.')
param backupVaultName string

@description('Optional. The name of the backup instance.')
param name string = 'DefaultInstance'

@description('Optional. The properties of the backup instance.')
param properties object = {}

@description('Optional. Tags of the Recovery Service Vault resource.')
param tags object?

var roleDefinitionIdForDisk = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  '3e5e47e6-65f7-47ef-90b5-e5dd4d455f24'
)
var roleDefinitionIdForSnapshotRG = subscriptionResourceId(
  'Microsoft.Authorization/roleDefinitions',
  '7efff54f-a5b4-42b5-a1c5-5411624893ce'
)
var roleNameGuidForDisk = guid(resourceGroup().id, roleDefinitionIdForDisk, backupVault.id)
var roleNameGuidForSnapshotRG = guid(resourceGroup().id, roleDefinitionIdForSnapshotRG, backupVault.id)

resource backupVault 'Microsoft.DataProtection/backupVaults@2023-05-01' existing = {
  name: backupVaultName
}

resource backupInstance 'Microsoft.DataProtection/backupVaults/backupInstances@2024-04-01' = {
  name: name
  tags: tags
  parent: backupVault
  properties: properties
}

resource roleAssignmentForDisk 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: roleNameGuidForDisk
  properties: {
    roleDefinitionId: roleDefinitionIdForDisk
    principalId: reference(backupVault.id, '2024-04-01', 'Full').identity.principalId
    principalType: 'ServicePrincipal'
  }
}

resource roleAssignmentForSnapshotRG 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: roleNameGuidForSnapshotRG
  properties: {
    roleDefinitionId: roleDefinitionIdForSnapshotRG
    principalId: reference(backupVault.id, '2024-04-01', 'Full').identity.principalId
    principalType: 'ServicePrincipal'
  }
}

@description('The name of the backup instance.')
output name string = backupInstance.name

@description('The resource ID of the backup instance.')
output resourceId string = backupInstance.id

@description('The name of the resource group the backup instance was created in.')
output resourceGroupName string = resourceGroup().name
