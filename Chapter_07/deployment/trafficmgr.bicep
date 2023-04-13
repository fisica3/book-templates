targetScope = 'subscription'

param systemName string = 'maracuya'
param location string = deployment().location

param usWebAppId string = 'usWebAppId'
param weWebAppId string = 'weWebAppId'
param asiWebAppId string = 'asiWebAppId'

@allowed([
  'dev'
  'test'
  'acc'
  'prod'
])
param environmentName string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${systemName}-${environmentName}'
  location: location
}

module trafficManagerModule 'Network/trafficmanagerprofiles.bicep' = {
  name: 'trafficManagerModule'
  scope: resourceGroup
  params: {
    systemName: systemName
    environmentName: environmentName
    usWebAppId : usWebAppId
    weWebAppId : weWebAppId
    asiWebAppId : asiWebAppId
  }
}
