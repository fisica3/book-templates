param systemName string
param environmentName string
param location string = resourceGroup().location
@allowed([
  'we' // West europe
  'us' // East US (1)
  'asi' // East Japan
])
param locationAbbriviation string

param serverFarmId string

var webAppName = '${systemName}-${environmentName}-${locationAbbriviation}-app'

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: serverFarmId
  }
}

output webAppId string = webApp.id
output webAppName string = webAppName
