targetScope = 'resourceGroup'

param location string

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

output appServicePlanId string = appServicePlan.id
