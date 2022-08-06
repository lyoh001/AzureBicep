param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

param dnsLabelPrefix string = toLower('${prefix}-${uniqueString(resourceGroup().id, prefix)}')
param ubuntuOSVersion string = '20_04-lts-gen2'
param vmSize string = 'Standard_B2s'
param authenticationType string = 'sshPublicKey'
param adminPasswordOrKey string = 'ssh-rsa ssh-rsa-keys-here admin@host'
var myIpAddress = '120.21.184.145'
var osDiskType = 'Standard_LRS'
var subnetAddressPrefix = '10.1.0.0/24'
var addressPrefix = '10.1.0.0/16'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${prefix}admin/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: '${prefix}vmnic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: '${prefix}ip'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: '${prefix}vmnsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '${myIpAddress}/32'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: '${prefix}vmvnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' = {
  parent: vnet
  name: '${prefix}vmsubnet'
  properties: {
    addressPrefix: subnetAddressPrefix
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: '${prefix}vmpip'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
    idleTimeoutInMinutes: 4
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: '${prefix}vm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: ubuntuOSVersion
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    osProfile: {
      computerName: '${prefix}vm'
      adminUsername: '${prefix}admin'
      adminPassword: adminPasswordOrKey
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
  }
}

output sshCommand string = 'ssh ${prefix}admin@${publicIP.properties.dnsSettings.fqdn}'
