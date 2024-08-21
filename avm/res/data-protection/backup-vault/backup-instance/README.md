# Data Protection Backup Vault Backup Instance `[Microsoft.DataProtection/backupVaults/backupInstances]`

This module deploys a Data Protection Backup Vault Backup Instance.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Data Collection](#Data-Collection)

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

## Cross-referenced modules

_None_

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
