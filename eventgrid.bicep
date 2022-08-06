param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource eventgrid_system_topic 'Microsoft.EventGrid/systemTopics@2020-04-01-preview' = {
  name: '${prefix}egst'
  location: 'global'
  properties: {
    source: '/subscriptions/${subscription().subscriptionId}'
    topicType: 'Microsoft.Resources.Subscriptions'
  }
}

resource eventgrid_system_topic_locks 'Microsoft.Authorization/locks@2016-09-01' = {
  name: 'Delete'
  scope: eventgrid_system_topic
  properties: {
    level: 'CanNotDelete'
  }
}

resource event_subscription 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2020-04-01-preview' = {
  name: '${eventgrid_system_topic.name}/${prefix}es'
  properties: {
    destination: {
      properties: {
        resourceId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/azuremonitoreventrg/providers/Microsoft.Storage/storageAccounts/azuremonitoreventstrge'
        queueName: 'azuremonitoreventqueue'
      }
      endpointType: 'StorageQueue'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Resources.ResourceWriteSuccess'
        'Microsoft.Resources.ResourceWriteFailure'
        'Microsoft.Resources.ResourceWriteCancel'
        'Microsoft.Resources.ResourceDeleteSuccess'
        'Microsoft.Resources.ResourceDeleteFailure'
        'Microsoft.Resources.ResourceDeleteCancel'
        'Microsoft.Resources.ResourceActionSuccess'
        'Microsoft.Resources.ResourceActionFailure'
        'Microsoft.Resources.ResourceActionCancel'
      ]
    }
    labels: []
    eventDeliverySchema: 'EventGridSchema'
    retryPolicy: {
      maxDeliveryAttempts: 30
      eventTimeToLiveInMinutes: 1440
    }
  }
}

resource event_subscription_locks 'Microsoft.Authorization/locks@2016-09-01' = {
  name: 'Delete'
  scope: event_subscription
  properties: {
    level: 'CanNotDelete'
  }
}
