param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource recovery_services_vault 'Microsoft.RecoveryServices/vaults@2021-01-01' = {
  location: location
  name: '${prefix}rsv'
  sku: {
    name: 'Standard'
  }
  properties: {}
}
