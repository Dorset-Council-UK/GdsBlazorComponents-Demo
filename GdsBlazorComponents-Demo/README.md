# GDS Blazor Components Demo

A demonstration application showcasing the [Dorset Council GDS Blazor Components](https://github.com/Dorset-Council-UK/GdsBlazorComponents) library.

## Overview

This Blazor Server application demonstrates all major components from the GDS Blazor Components library, which implements the GOV.UK Design System in Blazor.

## Features

- Comprehensive demos of all GDS Blazor Components
- Interactive examples showing component usage
- Real-world form validation examples
- Responsive GOV.UK Design System styling

## Components Demonstrated

### Form Components
- Button
- Checkbox
- Checkboxes
- File Input
- Input Text
- Input Number
- Input Date
- Input Partial Date
- Radio
- Radios

### Layout Components
- Header
- Footer
- Fieldset Group
- Form Group

### Content Components
- Error Message
- Error Summary
- Hint
- Label
- Inset Text
- Notification Banner
- Phase Banner
- Warning
- Spinner

### Navigation Components
- Skip Link

## Running Locally

### Prerequisites
- .NET 10 SDK

### Steps
1. Clone the repository
2. Navigate to the project directory
3. Run `dotnet run`
4. Open your browser to the URL displayed (usually https://localhost:5001)

## Deployment to Azure

This application is configured for deployment to Azure App Service.

### Deploy using Azure CLI

```bash
# Login to Azure
az login

# Create a resource group (if needed)
az group create --name GdsBlazorDemo --location uksouth

# Create an App Service plan
az appservice plan create --name GdsBlazorDemoPlan --resource-group GdsBlazorDemo --sku B1 --is-linux

# Create a web app
az webapp create --name gds-blazor-demo --resource-group GdsBlazorDemo --plan GdsBlazorDemoPlan --runtime "DOTNETCORE:10.0"

# Deploy the application
dotnet publish -c Release
cd bin/Release/net10.0/publish
zip -r ../../../deploy.zip *
az webapp deployment source config-zip --resource-group GdsBlazorDemo --name gds-blazor-demo --src ../../../deploy.zip
```

### Deploy using Visual Studio
1. Right-click the project in Solution Explorer
2. Select "Publish"
3. Choose "Azure" as the target
4. Select "Azure App Service (Linux)"
5. Follow the wizard to create or select an App Service
6. Click "Publish"

## Technology Stack

- .NET 10
- Blazor Server
- GDS Blazor Components 2.0.2
- GOV.UK Frontend styles

## License

This demo application is provided as an example. The GDS Blazor Components library is licensed under the MIT License.

## Links

- [GDS Blazor Components GitHub](https://github.com/Dorset-Council-UK/GdsBlazorComponents)
- [GOV.UK Design System](https://design-system.service.gov.uk/)
