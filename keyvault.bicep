param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource key_vault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  location: location
  name: '${prefix}kv'
  properties: {
    accessPolicies: []
    enableRbacAuthorization: false
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    networkAcls: {
      ipRules: []
      virtualNetworkRules: []
    }
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: subscription().tenantId
  }
}
