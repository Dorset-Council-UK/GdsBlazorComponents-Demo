# Deploy GDS Blazor Components Demo to Azure

This guide provides step-by-step instructions for deploying the GDS Blazor Components Demo to Azure.

## Prerequisites

- Azure subscription
- Azure CLI installed (https://docs.microsoft.com/cli/azure/install-azure-cli)
- .NET 10 SDK installed
- Git (optional, for version control)

## Deployment Steps

### Option 1: Quick Deployment with Azure CLI

1. **Login to Azure**
```bash
az login
```

2. **Set your subscription** (if you have multiple)
```bash
az account set --subscription "Your Subscription Name"
```

3. **Create a resource group**
```bash
az group create --name GdsBlazorDemo --location uksouth
```

4. **Deploy infrastructure using Bicep**
```bash
az deployment group create \
  --resource-group GdsBlazorDemo \
  --template-file azure/main.bicep \
  --parameters appName=gds-blazor-demo environment=production
```

5. **Build and publish the application**
```bash
cd GdsBlazorComponents-Demo
dotnet publish -c Release -o ./publish
```

6. **Create deployment package**
```bash
# Windows PowerShell
Compress-Archive -Path ./publish/* -DestinationPath ./deploy.zip -Force

# Linux/Mac
cd publish
zip -r ../deploy.zip .
cd ..
```

7. **Deploy to Azure**
```bash
az webapp deployment source config-zip \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production \
  --src ./deploy.zip
```

8. **Access your application**
```bash
az webapp browse --resource-group GdsBlazorDemo --name gds-blazor-demo-production
```

### Option 2: GitHub Actions CI/CD

1. **Fork or clone this repository to your GitHub account**

2. **Get Azure publish profile**
```bash
az webapp deployment list-publishing-profiles \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production \
  --xml > publish-profile.xml
```

3. **Add GitHub Secret**
   - Go to your GitHub repository
   - Settings > Secrets and variables > Actions
   - Create new secret: `AZURE_WEBAPP_PUBLISH_PROFILE`
   - Paste the contents of publish-profile.xml

4. **Create GitHub Actions workflow**

Create `.github/workflows/azure-deploy.yml`:

```yaml
name: Deploy to Azure App Service

on:
  push:
    branches: [ main ]
  workflow_dispatch:

env:
  AZURE_WEBAPP_NAME: gds-blazor-demo-production
  DOTNET_VERSION: '10.0.x'

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: ${{ env.DOTNET_VERSION }}
    
    - name: Restore dependencies
      run: dotnet restore GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj
    
    - name: Build
      run: dotnet build GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj --configuration Release --no-restore
    
    - name: Test
      run: dotnet test GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj --configuration Release --no-build --verbosity normal || true
    
    - name: Publish
      run: dotnet publish GdsBlazorComponents-Demo/GdsBlazorComponents-Demo.csproj --configuration Release --no-build --output ./publish
    
    - name: Deploy to Azure Web App
      uses: azure/webapps-deploy@v3
      with:
        app-name: ${{ env.AZURE_WEBAPP_NAME }}
        publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
        package: ./publish
```

5. **Push to GitHub** - The workflow will automatically deploy on push to main

### Option 3: Visual Studio Publish

1. **Open the solution in Visual Studio**

2. **Right-click the project** > Select **Publish**

3. **Choose Target**: Azure

4. **Specific Target**: Azure App Service (Linux)

5. **Create New or Select Existing** App Service
   - Name: gds-blazor-demo-production
   - Subscription: Your subscription
   - Resource Group: GdsBlazorDemo (or create new)
   - Hosting Plan: Create new or select existing
   - Region: UK South

6. **Configure**:
   - Deployment type: Publish (generates publish files)
   - Runtime: .NET 10

7. **Click Publish**

8. **Wait for deployment to complete** - browser will automatically open

## Post-Deployment Configuration

### Configure Custom Domain (Optional)

1. **Add custom domain**
```bash
az webapp config hostname add \
  --resource-group GdsBlazorDemo \
  --webapp-name gds-blazor-demo-production \
  --hostname yourdomain.com
```

2. **Enable HTTPS** (managed certificate)
```bash
az webapp config ssl create \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production \
  --hostname yourdomain.com
```

### Configure Application Settings

```bash
az webapp config appsettings set \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production \
  --settings ASPNETCORE_ENVIRONMENT=Production
```

### Enable Application Insights

Application Insights is automatically configured via the Bicep template. View metrics:

```bash
az monitor app-insights component show \
  --resource-group GdsBlazorDemo \
  --app gds-blazor-demo-insights-production
```

## Monitoring and Management

### View Logs
```bash
az webapp log tail \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production
```

### Stream Logs
```bash
az webapp log config \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production \
  --application-logging filesystem

az webapp log tail \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production
```

### Restart Application
```bash
az webapp restart \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-production
```

### Scale Application
```bash
az appservice plan update \
  --resource-group GdsBlazorDemo \
  --name gds-blazor-demo-plan-production \
  --sku S1
```

## Troubleshooting

### Application not starting
1. Check logs: `az webapp log tail --resource-group GdsBlazorDemo --name gds-blazor-demo-production`
2. Verify .NET runtime version in Azure Portal
3. Check Application Settings

### 502/503 Errors
1. Restart the application
2. Check if App Service Plan has sufficient resources
3. Scale up if needed

### Slow Performance
1. Enable Application Insights
2. Check diagnostics in Azure Portal
3. Consider scaling up or out

## Cost Optimization

### Development Environment
```bash
az deployment group create \
  --resource-group GdsBlazorDemo-Dev \
  --template-file azure/main.bicep \
  --parameters appName=gds-blazor-demo environment=dev sku=B1
```

### Production with Auto-scaling
```bash
az monitor autoscale create \
  --resource-group GdsBlazorDemo \
  --resource gds-blazor-demo-plan-production \
  --resource-type Microsoft.Web/serverfarms \
  --name autoscale-prod \
  --min-count 1 \
  --max-count 3 \
  --count 1
```

## Cleanup

To remove all resources:

```bash
az group delete --name GdsBlazorDemo --yes --no-wait
```

## Security Best Practices

1. **Enable managed identity** for Azure resource access
2. **Use Key Vault** for sensitive configuration
3. **Enable HTTPS only** (already configured)
4. **Regular updates** - keep .NET and packages updated
5. **Monitor security** - use Azure Security Center

## Additional Resources

- [Azure App Service Documentation](https://docs.microsoft.com/azure/app-service/)
- [Blazor on Azure](https://docs.microsoft.com/aspnet/core/blazor/host-and-deploy/azure)
- [GDS Blazor Components](https://github.com/Dorset-Council-UK/GdsBlazorComponents)
