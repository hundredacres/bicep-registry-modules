# Data Protection Backup Vault Backup Instance `[Microsoft.DataProtection/backupVaults/backupInstances]`

This module deploys a Data Protection Backup Vault Backup Instance.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.DataProtection/backupVaults/backupInstances` | [2024-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.DataProtection/backupVaults/backupInstances) |

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`backupVaultName`](#parameter-backupvaultname) | string | The name of the backup vault. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | The name of the backup instance. |
| [`properties`](#parameter-properties) | object | The properties of the backup instance. |
| [`tags`](#parameter-tags) | object | Tags of the Recovery Service Vault resource. |

### Parameter: `backupVaultName`

The name of the backup vault.

- Required: Yes
- Type: string

### Parameter: `name`

The name of the backup instance.

- Required: No
- Type: string
- Default: `'DefaultInstance'`

### Parameter: `properties`

The properties of the backup instance.

- Required: No
- Type: object
- Default: `{}`

### Parameter: `tags`

Tags of the Recovery Service Vault resource.

- Required: No
- Type: object

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `name` | string | The name of the backup instance. |
| `resourceGroupName` | string | The name of the resource group the backup instance was created in. |
| `resourceId` | string | The resource ID of the backup instance. |
