param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))

resource web_app_service 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: '${prefix}webasp'
  location: location
  kind: 'linux'
  sku: {
    name: 'B2'
    tier: 'Basic'
    size: 'B2'
    family: 'B'
    capacity: 1
  }
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

resource web_app_be 'Microsoft.Web/sites@2020-06-01' = {
  location: location
  name: '${prefix}bewebapp'
  kind: 'app,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${prefix}bewebapp.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${prefix}bewebapp.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: web_app_service.id
    reserved: true
    isXenon: false
    hyperV: false
    siteConfig: {}
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    hostNamesDisabled: false
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
  }
}

resource web_app_be_config 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${web_app_be.name}/web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'Python|3.10'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$${web_app_be.name}'
    azureStorageAccounts: {}
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    ftpsState: 'AllAllowed'
    PreWarmedInstanceCount: 0
  }
}

resource web_app_be_binding 'Microsoft.Web/sites/hostNameBindings@2020-06-01' = {
  name: '${web_app_be.name}/${web_app_be.name}.azurewebsites.net'
  properties: {
    siteName: web_app_be.name
    hostNameType: 'Verified'
  }
}

resource web_app_fe 'Microsoft.Web/sites@2020-06-01' = {
  location: location
  name: '${prefix}fewebapp'
  kind: 'app,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${prefix}fewebapp.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${prefix}fewebapp.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: web_app_service.id
    reserved: true
    isXenon: false
    hyperV: false
    siteConfig: {}
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    hostNamesDisabled: false
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
  }
}

resource web_app_fe_config 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${web_app_fe.name}/web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'NODE|20-lts'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$${web_app_fe.name}'
    azureStorageAccounts: {}
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    ftpsState: 'AllAllowed'
    PreWarmedInstanceCount: 0
  }
}

resource web_app_fe_binding 'Microsoft.Web/sites/hostNameBindings@2020-06-01' = {
  name: '${web_app_fe.name}/${web_app_fe.name}.azurewebsites.net'
  properties: {
    siteName: web_app_fe.name
    hostNameType: 'Verified'
  }
}

// resource web_app_insights 'Microsoft.Insights/components@2020-02-02-preview' = {
//   kind: 'web'
//   location: location
//   name: '${prefix}webinsights'
//   properties: {
//     Application_Type: 'web'
//     IngestionMode: 'ApplicationInsights'
//     publicNetworkAccessForIngestion: 'Enabled'
//     publicNetworkAccessForQuery: 'Enabled'
//   }
// }
