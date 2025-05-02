# Security Insights (Microsoft Sentinel) `[Microsoft.SecurityInsights/onboardingStates]`

This module deploys Security Insights (Microsoft Sentinel) instance and its resources.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.SecurityInsights/onboardingStates` | [2025-01-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.SecurityInsights/2025-01-01-preview/onboardingStates) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/security-insights/onboarding-states:<version>`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [Waf-Aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module onboardingStates 'br/public:avm/res/security-insights/onboarding-states:<version>' = {
  name: 'onboardingStatesDeployment'
  params: {
    // Required parameters
    name: 'siomin001'
    workspaceResourceId: '<workspaceResourceId>'
    // Non-required parameters
    location: '<location>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "siomin001"
    },
    "workspaceResourceId": {
      "value": "<workspaceResourceId>"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/security-insights/onboarding-states:<version>'

// Required parameters
param name = 'siomin001'
param workspaceResourceId = '<workspaceResourceId>'
// Non-required parameters
param location = '<location>'
```

</details>
<p>

### Example 2: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module onboardingStates 'br/public:avm/res/security-insights/onboarding-states:<version>' = {
  name: 'onboardingStatesDeployment'
  params: {
    // Required parameters
    name: 'siomax001'
    workspaceResourceId: '<workspaceResourceId>'
    // Non-required parameters
    enableDefaultTelemetry: true
    location: '<location>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "siomax001"
    },
    "workspaceResourceId": {
      "value": "<workspaceResourceId>"
    },
    // Non-required parameters
    "enableDefaultTelemetry": {
      "value": true
    },
    "location": {
      "value": "<location>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/security-insights/onboarding-states:<version>'

// Required parameters
param name = 'siomax001'
param workspaceResourceId = '<workspaceResourceId>'
// Non-required parameters
param enableDefaultTelemetry = true
param location = '<location>'
```

</details>
<p>

### Example 3: _Waf-Aligned_

<details>

<summary>via Bicep module</summary>

```bicep
module onboardingStates 'br/public:avm/res/security-insights/onboarding-states:<version>' = {
  name: 'onboardingStatesDeployment'
  params: {
    // Required parameters
    name: 'sioswaf001'
    workspaceResourceId: '<workspaceResourceId>'
    // Non-required parameters
    location: '<location>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "sioswaf001"
    },
    "workspaceResourceId": {
      "value": "<workspaceResourceId>"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/security-insights/onboarding-states:<version>'

// Required parameters
param name = 'sioswaf001'
param workspaceResourceId = '<workspaceResourceId>'
// Non-required parameters
param location = '<location>'
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | Name of the Security Insights (Microsoft Sentinel) instance. |
| [`workspaceResourceId`](#parameter-workspaceresourceid) | string | The resource ID of the Log Analytics workspace where Security Insights (Microsoft Sentinel) will be deployed. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`location`](#parameter-location) | string | Location for all resources. |

### Parameter: `name`

Name of the Security Insights (Microsoft Sentinel) instance.

- Required: Yes
- Type: string

### Parameter: `workspaceResourceId`

The resource ID of the Log Analytics workspace where Security Insights (Microsoft Sentinel) will be deployed.

- Required: Yes
- Type: string

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).

- Required: No
- Type: bool
- Default: `True`

### Parameter: `location`

Location for all resources.

- Required: No
- Type: string
- Default: `[resourceGroup().location]`

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the deployed Security Insights (Microsoft Sentinel) instance. |
| `resourceGroupName` | string | The resource group where the Security Insights (Microsoft Sentinel) instance is deployed. |
| `resourceId` | string | The resource ID of the deployed Security Insights (Microsoft Sentinel) instance. |
