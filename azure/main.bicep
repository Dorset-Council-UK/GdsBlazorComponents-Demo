@description('Name of the application')
param appName string = 'gds-blazor-demo'

@description('Location for all resources')
param location string = resourceGroup().location

@description('The pricing tier for the App Service plan')
@allowed([
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1v3'
  'P2v3'
  'P3v3'
])
param sku string = 'B1'

@description('Environment name')
@allowed([
  'dev'
  'staging'
  'production'
])
param environment string = 'production'

var appServicePlanName = '${appName}-plan-${environment}'
var webAppName = '${appName}-${environment}'
var tags = {
  Environment: environment
  Application: 'GDS Blazor Components Demo'
  ManagedBy: 'Bicep'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  kind: 'linux'
  sku: {
    name: sku
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE:10.0'
      alwaysOn: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      http20Enabled: true
      healthCheckPath: '/'
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: environment == 'production' ? 'Production' : 'Development'
        }
      ]
    }
    httpsOnly: true
    clientAffinityEnabled: false
  }
}

// Application Insights for monitoring
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${appName}-insights-${environment}'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 30
  }
}

// Configure App Insights connection
resource webAppAppSettings 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: webApp
  name: 'appsettings'
  properties: {
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsights.properties.ConnectionString
    ApplicationInsightsAgent_EXTENSION_VERSION: '~3'
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output webAppName string = webApp.name
output appInsightsKey string = appInsights.properties.InstrumentationKey
output resourceGroupName string = resourceGroup().name
