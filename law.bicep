param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource log_analytics_workspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: '${prefix}law'
  location: location
  properties: {
    sku: {
      name: 'Free'
    }
  }
}
