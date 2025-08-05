targetScope = 'subscription'

param resourceGroupName string

resource chaosResourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: deployment().location
}
