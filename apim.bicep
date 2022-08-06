param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource api_management 'Microsoft.ApiManagement/service@2019-12-01' = {
  location: location
  name: '${prefix}apims'
  properties: {
    publisherEmail: 'admin@email.com'
    publisherName: 'admin'
  }
  sku: {
    capacity: 0
    name: 'Consumption'
  }
}
