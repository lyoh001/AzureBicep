param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))
@secure()
param password string

// resource mysql_server 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
//   name: '${prefix}mysqlserver'
//   location: location
//   sku: {
//     name: 'Standard_B1s'
//     tier: 'Burstable'
//   }
//   properties: {
//     administratorLogin: 'operations'
//     administratorLoginPassword: password
//     storage: {
//       storageSizeGB: 20
//       iops: 360
//       autoGrow: 'Enabled'
//     }
//     version: '8.0.21'
//     availabilityZone: '1'
//     maintenanceWindow: {
//       customWindow: 'Disabled'
//       dayOfWeek: 0
//       startHour: 0
//       startMinute: 0
//     }
//     replicationRole: 'None'
//     network: {}
//     backup: {
//       backupRetentionDays: 1
//       geoRedundantBackup: 'Disabled'
//     }
//     highAvailability: {
//       mode: 'Disabled'
//     }
//   }
// }

// resource mysql_information_schema 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
//   parent: mysql_server
//   name: '${prefix}mysqlinformationschema'
//   properties: {
//     charset: 'utf8'
//     collation: 'utf8_general_ci'
//   }
// }

// resource mysql_database 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
//   parent: mysql_server
//   name: '${prefix}mysqldb'
//   properties: {
//     charset: 'utf8mb4'
//     collation: 'utf8mb4_0900_ai_ci'
//   }
// }

// resource mysql_performance_schema 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
//   parent: mysql_server
//   name: '${prefix}mysqlperf'
//   properties: {
//     charset: 'utf8mb4'
//     collation: 'utf8mb4_0900_ai_ci'
//   }
// }

// resource mysql_sys 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
//   parent: mysql_server
//   name: '${prefix}mysqlsys'
//   properties: {
//     charset: 'utf8mb4'
//     collation: 'utf8mb4_0900_ai_ci'
//   }
// }

// resource mysql_firewall_rule 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2021-05-01' = {
//   parent: mysql_server
//   name: '${prefix}mysqlfwrule'
//   properties: {
//     startIpAddress: '120.21.210.94'
//     endIpAddress: '120.21.210.94'
//   }
// }
