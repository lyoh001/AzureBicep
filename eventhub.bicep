param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource eventhub_namespace 'Microsoft.EventHub/namespaces@2018-01-01-preview' = {
  location: location
  name: '${prefix}ehns'
  properties: {
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
}
resource eventhub 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: '${eventhub_namespace.name}/${prefix}eh'
  properties: {
    messageRetentionInDays: 7
    partitionCount: 1
  }
}
