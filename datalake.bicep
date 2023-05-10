param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource datalake 'Microsoft.DataLakeStore/accounts@2016-11-01' = {
  location: location
  name: '${prefix}strg'
  identity: {
    type: 'SystemAssigned'
  }
}
