# GDS Blazor Components Demo - Project Summary

## Overview
This is a comprehensive demonstration application for the GDS Blazor Components library, ready for deployment to Azure.

## Project Structure

### Core Application Files
- **Program.cs** - Application entry point with service configuration
- **Components/App.razor** - Root component with GOV.UK Frontend styles
- **Components/_Imports.razor** - Global using statements
- **Components/Layout/MainLayout.razor** - Main layout with Header, Footer, and Phase Banner
- **Components/Pages/Home.razor** - Landing page with component directory

### Component Demo Pages

#### Form Components (10 pages)
1. **ButtonDemo.razor** - Various button styles and states
2. **CheckboxDemo.razor** - Single checkbox examples
3. **CheckboxesDemo.razor** - Multiple checkbox selection
4. **FileInputDemo.razor** - File upload component
5. **InputTextDemo.razor** - Text input with validation
6. **InputNumberDemo.razor** - Number input fields
7. **InputDateDemo.razor** - Date input component
8. **InputPartialDateDemo.razor** - Partial date entry
9. **RadioDemo.razor** - Individual radio buttons
10. **RadiosDemo.razor** - Radio button groups

#### Layout Components (4 pages)
1. **HeaderDemo.razor** - Page headers
2. **FooterDemo.razor** - Page footers
3. **FieldsetGroupDemo.razor** - Form fieldset grouping
4. **FormGroupDemo.razor** - Form group organization

#### Content Components (7 pages)
1. **ErrorMessageDemo.razor** - Error message display
2. **ErrorSummaryDemo.razor** - Form error summary
3. **HintDemo.razor** - Help text hints
4. **LabelDemo.razor** - Form labels
5. **InsetTextDemo.razor** - Highlighted content
6. **NotificationBannerDemo.razor** - Alert banners
7. **PhaseBannerDemo.razor** - Service phase indicators
8. **WarningDemo.razor** - Warning messages
9. **SpinnerDemo.razor** - Loading indicators

#### Navigation Components (1 page)
1. **SkipLinkDemo.razor** - Accessibility skip links

### Documentation
- **README.md** - Project overview and local setup instructions
- **AZURE_DEPLOYMENT.md** - Azure deployment guide
- **.gitignore** - Git ignore configuration

## Features Demonstrated

### Interactive Examples
- Working form validation
- State management
- Event handling
- Component composition

### Best Practices
- Accessibility with GOV.UK patterns
- Responsive design
- Validation error handling
- User feedback patterns

## Technology Stack
- **.NET 10** - Latest .NET version
- **Blazor Server** - Server-side rendering
- **GDS Blazor Components 2.0.2** - Component library
- **GOV.UK Frontend 5.0.0** - Design system styles

## Azure Deployment Ready

### Features
- ✅ Production-ready configuration
- ✅ HTTPS enforcement
- ✅ Status code page handling (404)
- ✅ Environment-based configuration
- ✅ Antiforgery protection
- ✅ Static asset mapping

### Deployment Options
1. **Azure CLI** - Command-line deployment
2. **Visual Studio** - IDE publishing
3. **GitHub Actions** - CI/CD pipeline
4. **Azure Bicep** - Infrastructure as Code

## Key Components Configuration

### Phase Banner
- Uses `GdsPhaseBanner.Phases.Beta` enum
- Shown on every page via MainLayout

### Validation
- DataAnnotationsValidator integration
- GdsErrorSummary for form errors
- Per-field error messages

### Styling
- GOV.UK Frontend CSS from CDN
- Width helpers (InputWidth.*)
- Type-safe component parameters

## Running the Application

### Local Development
```bash
cd GdsBlazorComponents-Demo
dotnet run
```
Navigate to https://localhost:5001

### Build for Production
```bash
dotnet publish -c Release
```

### Deploy to Azure
See AZURE_DEPLOYMENT.md for detailed instructions.

## Component Library Details

### Package Information
- **Package**: Dorset-Council-UK.GdsBlazorComponents
- **Version**: 2.0.2
- **GitHub**: https://github.com/Dorset-Council-UK/GdsBlazorComponents

### Component Types
All components are strongly-typed with generic type parameters where needed:
- `GdsCheckbox<T>` and `GdsCheckboxes<T>`
- `GdsRadio<T>` and `GdsRadios<T>`
- Form validation integrated with EditForm

## Next Steps

### To Deploy to Azure:
1. Review AZURE_DEPLOYMENT.md
2. Choose your deployment method
3. Configure Azure resources
4. Deploy the application
5. Access via your Azure URL

### To Extend:
1. Add more component examples
2. Integrate with backend APIs
3. Add authentication
4. Customize styling
5. Add additional pages

## Notes
- All components follow GOV.UK Design System patterns
- Accessibility features built-in
- Mobile-responsive design
- Production-ready code quality
