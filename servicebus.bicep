param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource servicebus_namespace 'Microsoft.ServiceBus/namespaces@2018-01-01-preview' = {
  location: location
  name: '${prefix}sbns'
  sku: {
    name: 'Standard'
  }
}

resource servicebus_queue 'Microsoft.ServiceBus/namespaces/queues@2017-04-01' = {
  name: '${servicebus_namespace.name}/${prefix}sbq'
  properties: {
    lockDuration: 'PT5M'
    maxSizeInMegabytes: 1024
    requiresDuplicateDetection: false
    requiresSession: false
    defaultMessageTimeToLive: 'P10675199DT2H48M5.4775807S'
    deadLetteringOnMessageExpiration: false
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    maxDeliveryCount: 10
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    enablePartitioning: false
    enableExpress: false
  }
}
