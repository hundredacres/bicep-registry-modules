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

resource backupVault 'Microsoft.DataProtection/backupVaults@2023-05-01' existing = {
  name: backupVaultName
}

resource backupInstance 'Microsoft.DataProtection/backupVaults/backupInstances@2024-04-01' = {
  name: name
  tags: tags
  parent: backupVault
  properties: properties
}

@description('The name of the backup instance.')
output name string = backupInstance.name

@description('The resource ID of the backup instance.')
output resourceId string = backupInstance.id

@description('The name of the resource group the backup instance was created in.')
output resourceGroupName string = resourceGroup().name
