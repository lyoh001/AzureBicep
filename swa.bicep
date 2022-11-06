param location string = resourceGroup().location
param prefix string = replace(resourceGroup().name, 'rg', '')
// param prefix string = concat(replace(resourceGroup().name, 'rg', ''), substring(newGuid(), 0, 7))
@secure()
param token string

resource static_web_apps 'Microsoft.Web/staticSites@2021-01-15' = {
  name: '${prefix}swa'
  location: location
  sku: {
    tier: 'Free'
    name: 'Free'
  }
  properties: {
    repositoryUrl: 'https://github.com/lyoh001/AzureStaticWebApps.git'
    branch: 'main'
    repositoryToken: token
    buildProperties: {
      apiLocation: ''
      appLocation: '/'
      appArtifactLocation: ''
      skipGithubActionWorkflowGeneration: true
      githubActionSecretNameOverride: 'AZURE_STATIC_WEB_APPS_API_TOKEN'
    }
  }
}
