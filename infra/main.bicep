targetScope = 'subscription'

param resourceGroupName string

var nameServiceA = 'web-service-a'
var nameServiceB = 'web-service-b'

module moduleResourceGroup 'resources/resourceGroup.bicep' = {
  scope: subscription()
  params: {
    resourceGroupName: resourceGroupName
  }
}

module moduleAppServicePlan 'resources/appServicePlan.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    location: deployment().location
  }
  dependsOn: [moduleResourceGroup]
}

module appServices 'resources/appServices.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    appServicePlanId: moduleAppServicePlan.outputs.appServicePlanId
    location: deployment().location
    nameServiceA: nameServiceA
    nameServiceB: nameServiceB
  }
}

module chaos 'resources/chaos.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    nameServiceA: nameServiceA
  }
  dependsOn: [appServices]
}
