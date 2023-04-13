param systemName string = 'tomatoe'

@allowed([
  'dev'
  'test'
  'acc'
  'prod'
])
param environmentName string

param usWebAppId string
param weWebAppId string
param asiWebAppId string

resource trafficManager 'Microsoft.Network/trafficmanagerprofiles@2022-04-01-preview' = {
  name: '${systemName}-${environmentName}'
  location: 'global'
  properties: {
    trafficRoutingMethod: 'Geographic'
    dnsConfig: {
      relativeName: '${systemName}-${environmentName}'
      ttl: 60
    }
    monitorConfig: {
      profileMonitorStatus: 'Online'
      protocol: 'HTTPS'
      path: '/'
      port: 443
      intervalInSeconds: 30
      toleratedNumberOfFailures: 3
      timeoutInSeconds: 10
    }
    endpoints: [
      {
        name: 'eur'
        type: 'Microsoft.Network/trafficManagerProfiles/AzureEndpoints'
        properties: {
          target: '${systemName}-${environmentName}-we-app.azurewebsites.net'
          targetResourceId: weWebAppId
          weight: 1
          priority: 1
          endpointLocation: 'West Europe'
          geoMapping: [
            'GEO-EU'
          ]
        }
      }
      {
        name: 'asi'
        type: 'Microsoft.Network/trafficManagerProfiles/AzureEndpoints'
        properties: {
          target: '${systemName}-${environmentName}-asi-app.azurewebsites.net'
          targetResourceId: asiWebAppId
          weight: 1
          priority: 2
          endpointLocation: 'East Asia'
          geoMapping: [
            'GEO-AS'
            'GEO-AP'
            'GEO-ME'
          ]
        }
      }
      {
        name: 'global'
        type: 'Microsoft.Network/trafficManagerProfiles/AzureEndpoints'
        properties: {
          target: '${systemName}-${environmentName}-us-app.azurewebsites.net'
          targetResourceId: usWebAppId
          weight: 1
          priority: 3
          endpointLocation: 'West US'
          geoMapping: [
            'WORLD'
          ]
        }
      }
    ]
  }
}
