param systemName string
param environmentName string
param location string = resourceGroup().location
@allowed([
  'we' // West europe
  'us' // East US (1)
  'asi' // East Japan
])
param locationAbbriviation string

var serverFarmName = '${systemName}-${environmentName}-${locationAbbriviation}-plan'

resource serverFarm 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: serverFarmName
  location: location
  kind: 'app'
  sku: {
    name: 'B1'
    capacity: 1
  }
}

output serverFarmId string = serverFarm.id
