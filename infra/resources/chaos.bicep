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

resource experimentStopServiceA 'Microsoft.Chaos/experiments@2025-01-01' = {
  name: 'stop-service-a'
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    steps: [
      {
        name: 'Step: Stop service A'
        branches: [
          {
            name: 'Branch 0'
            actions: [
              {
                name: 'urn:csci:microsoft:appService:stop/1.0'
                type: 'continuous'
                duration: 'PT5M'
                parameters: []
                selectorId: '38ff80b8-076d-4e09-b7c6-27576d4322f3'
              }
            ]
          }
        ]
      }
    ]
    selectors: [
      {
        id: '38ff80b8-076d-4e09-b7c6-27576d4322f3'
        type: 'List'
        targets: [
          {
            id: targetServiceA.id
            type: 'ChaosTarget'
          }
        ]
      }
    ]
  }
}

// TODO: Move to RBAC file
var roleDefinitionResourceId = 'de139f84-1756-47ae-9be6-808fbbe84772'
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(experimentStopServiceA.id, roleDefinitionResourceId)
  scope: appServiceA
  properties: {
    principalId: experimentStopServiceA.identity.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionResourceId)
  }
}
