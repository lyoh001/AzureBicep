targetScope = 'subscription'
@secure()
param token string
@secure()
param password string

// resource azuremonitoreventrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
//   name: 'azuremonitoreventrg'
//   location: deployment().location
// }

// module eventgrid 'eventgrid.bicep' = {
//   name: 'eventgrid'
//   scope: azuremonitoreventrg
// }

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${deployment().name}rg'
  location: deployment().location
}

// module apim 'apim.bicep' = {
//   name: 'apim'
//   scope: rg
// }

// module automationaccount 'automationaccount.bicep' = {
//   name: 'automationaccount'
//   scope: rg
// }

// module cosmosdb 'cosmosdb.bicep' = {
//   name: 'cosmosdb'
//   scope: rg
// }

// module databricks 'databricks.bicep' = {
//   name: 'databricks'
//   scope: rg
// }

// module datafactory 'datafactory.bicep' = {
//   name: 'datafactory'
//   scope: rg
// }

// module datalake 'datalake.bicep' = {
//   name: 'datalake'
//   scope: rg
// }

// module eventhub 'eventhub.bicep' = {
//   name: 'eventhub'
//   scope: rg
// }

// module funcapp 'funcapp.bicep' = {
//   name: 'funcapp'
//   scope: rg
// }

// module keyvault 'keyvault.bicep' = {
//   name: 'keyvault'
//   scope: rg
// }

// module law 'law.bicep' = {
//   name: 'law'
//   scope: rg
// }

// module logicapps 'logicapps.bicep' = {
//   name: 'logicapps'
//   scope: rg
// }

// module rsv 'rsv.bicep' = {
//   name: 'rsv'
//   scope: rg
// }

// module servicebus 'servicebus.bicep' = {
//   name: 'servicebus'
//   scope: rg
// }

module mysql 'mysql.bicep' = {
  name: 'mysql'
  scope: rg
  params: {
    password: password
  }
}

// module storage 'storage.bicep' = {
//   name: 'storage'
//   scope: rg
// }

// module streamanalytics 'streamanalytics.bicep' = {
//   name: 'streamanalytics'
//   scope: rg
// }

// module swa 'swa.bicep' = {
//   name: 'swa'
//   scope: rg
//   params: {
//     token: token
//   }
// }

// module vmlinux 'vmlinux.bicep' = {
//   name: 'vmlinux'
//   scope: rg
// }

// module vmwindows 'vmwindows.bicep' = {
//   name: 'vmwindows'
//   scope: rg
//   params: {
//     password: password
//   }
// }

// module vmml 'vmml.bicep' = {
//   name: 'vmml'
//   scope: rg
// }

// module vnet 'vnet.bicep' = {
//   name: 'vnet'
//   scope: rg
// }

// module webapp 'webapp.bicep' = {
//   name: 'webapp'
//   scope: rg
// }
