targetScope = 'resourceGroup'

param location string
param appServicePlanId string
param nameServiceA string
param nameServiceB string

resource appServiceA 'Microsoft.Web/sites@2024-11-01' = {
  name: nameServiceA
  location: location
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|9.0'
      ftpsState: 'Disabled'
      appSettings: [
        {
          name: 'ServiceName'
          value: 'Service A'
        }
      ]
    }
  }
}

resource appServiceB 'Microsoft.Web/sites@2024-11-01' = {
  name: nameServiceB
  location: location
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|9.0'
      ftpsState: 'Disabled'
      appSettings: [
        {
          name: 'ServiceName'
          value: 'Service B'
        }
      ]
    }
  }
}

resource proxyAppService 'Microsoft.Web/sites@2024-11-01' = {
  name: 'proxy-web-service'
  location: location
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlanId
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|9.0'
      ftpsState: 'Disabled'
      appSettings: [
        {
          name: 'UrlServiceA'
          value: 'https://${appServiceA.properties.defaultHostName}'
        }
        {
          name: 'UrlServiceB'
          value: 'https://${appServiceB.properties.defaultHostName}'
        }
      ]
    }
  }
}
