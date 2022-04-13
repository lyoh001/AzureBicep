param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource vm 'Microsoft.MachineLearningServices/workspaces/computes@2021-07-01' = {
  name: 'vickk73ml/${prefix}mlvm'
  location: location
  properties: {
    computeType: 'ComputeInstance'
    disableLocalAuth: true
    properties: {
      // vmSize: 'Standard_NC6_Promo'
      // vmSize: 'Standard_NV6'
      // vmSize: 'Standard_NV12'
      vmSize: 'Standard_NV24'
      applicationSharingPolicy: 'Personal'
      sshSettings: {
        sshPublicAccess: 'Disabled'
      }
      personalComputeInstanceSettings: {
        assignedUser: {
          objectId: ''
          tenantId: ''
        }
      }
    }
  }
}
