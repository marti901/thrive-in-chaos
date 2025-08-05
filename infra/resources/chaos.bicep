targetScope = 'resourceGroup'

param nameServiceA string

resource appServiceA 'Microsoft.Web/sites@2024-11-01' existing = {
  name: nameServiceA
}

resource targetServiceA 'Microsoft.Chaos/targets@2025-01-01' = {
  name: 'microsoft-appservice'
  scope: appServiceA
  properties: {}
}

resource serviceStopCapability 'Microsoft.Chaos/targets/capabilities@2025-01-01' = {
  parent: targetServiceA
  name: 'Stop-1.0'
}
