param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource vnet 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  location: location
  name: '${prefix}vnet'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${vnet.name}/${prefix}subnet1'
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${vnet.name}/${prefix}subnet2'
  properties: {
    addressPrefix: '10.0.1.0/24'
  }
}

resource nsg1 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  location: location
  name: '${prefix}nsg1'
  properties: {
    securityRules: [
      {
        name: 'Http'
        properties: {
          description: 'Http'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
    ]
  }
}
