# Azure Deployment Files

This directory contains Azure-specific configuration files for deploying the application.

## GitHub Actions Deployment

You can deploy this application to Azure using GitHub Actions. Here's a sample workflow file:

Create `.github/workflows/azure-deploy.yml`:

```yaml
name: Deploy to Azure

on:
  push:
    branches:
      - main
  workflow_dispatch:

env:
  AZURE_WEBAPP_NAME: gds-blazor-demo
  DOTNET_VERSION: '10.0.x'

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: ${{ env.DOTNET_VERSION }}
    
    - name: Restore dependencies
      run: dotnet restore GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj
    
    - name: Build
      run: dotnet build GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj --configuration Release --no-restore
    
    - name: Publish
      run: dotnet publish GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj --configuration Release --no-build --output ./publish
    
    - name: Deploy to Azure Web App
      uses: azure/webapps-deploy@v2
      with:
        app-name: ${{ env.AZURE_WEBAPP_NAME }}
        publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
        package: ./publish
```

## Azure Bicep Deployment

Create `azure/main.bicep`:

```bicep
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
  'P1v2'
  'P2v2'
  'P3v2'
])
param sku string = 'B1'

var appServicePlanName = '${appName}-plan'
var webAppName = appName

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  sku: {
    name: sku
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|10.0'
      alwaysOn: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
```

Deploy using:
```bash
az deployment group create --resource-group GdsBlazorDemo --template-file azure/main.bicep
```
