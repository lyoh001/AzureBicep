param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource cosmos 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  location: location
  name: '${prefix}cdba'
  kind: 'GlobalDocumentDB'
  properties: {
    enableFreeTier: true
    capabilities: [
      {
        name: 'EnableTable'
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
  }
}

resource cosmosdb 'Microsoft.DocumentDB/databaseAccounts/tables@2020-04-01' = {
  name: '${cosmos.name}/${prefix}db'
  properties: {
    resource: {
      id: '${prefix}db'
    }
    options: {
      throughput: 400
    }
  }
}
