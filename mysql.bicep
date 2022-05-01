param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))
@secure()
param password string

resource mysql_server 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
  name: '${prefix}mysqlserver'
  location: location
  sku: {
    name: 'Standard_B1s'
    tier: 'Burstable'
  }
  properties: {
    administratorLogin: 'operations'
    administratorLoginPassword: password
    backup: {
      backupRetentionDays: 1
      geoRedundantBackup: 'Disabled'
    }
    createMode: 'Default'
    highAvailability: {
      mode: 'Disabled'
    }
    network: {}
    replicationRole: 'None'
    storage: {
      autoGrow: 'Enabled'
      iops: 360
      storageSizeGB: 20
    }
    version: '8.0.21'
  }
}

resource mysql_database 'Microsoft.DBforMySQL/flexibleServers/databases@2021-05-01' = {
  name: '${prefix}mysqldb'
  parent: mysql_server
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}

resource mysql_firewall_rule 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2021-05-01' = {
  name: '${prefix}mysqlfwrule'
  parent: mysql_server
  properties: {
    startIpAddress: '120.21.210.94'
    endIpAddress: '120.21.210.94'
  }
}
