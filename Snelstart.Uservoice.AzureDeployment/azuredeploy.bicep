param location string  = resourceGroup().location
param appServicePlanName string
param sku string
param dotnetVersion string
param webAppName string
param webAppInsightsName string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'app'
}

resource webApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: dotnetVersion 
    }
  }
}

resource webAppInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: webAppInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'rest'
  }
}