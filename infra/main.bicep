targetScope='resourceGroup'

param location string = 'West Europe'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: 'chaos-app-service-plan'
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
  }
  kind: 'linux'
}

resource appServiceA 'Microsoft.Web/sites@2024-11-01' = {
  name: 'web-service-a'
  location: location
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|9.0'
      ftpsState: 'Disabled'
    }
  }
}

resource appServiceB 'Microsoft.Web/sites@2024-11-01' = {
  name: 'web-service-b'
  location: location
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|9.0'
      ftpsState: 'Disabled'
    }
  }
}
