# Component Demo Pages - Complete List

## Homepage
- **/** - Main landing page with links to all components

## Form Components

### Button Component
- **/button** - Demonstrates all button variations:
  - Default button
  - Start button (with arrow icon)
  - Secondary button
  - Warning button (red)
  - Disabled button
  - All with click event handling

### Checkbox Components
- **/checkbox** - Single checkbox examples:
  - Basic checkbox
  - Checkbox with label and hint
  - Form submission with validation

- **/checkboxes** - Multiple selection:
  - Checkbox group
  - Multi-select functionality
  - Collection binding

### File Input
- **/file-input** - File upload component:
  - File selection
  - File metadata display
  - Validation support

### Text Input
- **/input-text** - Text input fields:
  - Full name input
  - Email input (with email validation)
  - Phone number input
  - Postcode input (with width constraint)
  - All with hints and autocomplete

### Number Input
- **/input-number** - Number input fields:
  - Age input
  - Income input (with prefix £)
  - Weight input (with suffix kg)
  - Number-specific keyboard on mobile

### Date Input
- **/input-date** - Date entry:
  - Date of birth
  - Appointment date
  - Day/Month/Year format
  - Date validation

### Partial Date Input
- **/input-partial-date** - Flexible date entry:
  - Month and year only
  - Year only
  - Useful for approximate dates

### Radio Components
- **/radio** - Individual radio buttons:
  - Basic radio button usage
  - Radio button groups

- **/radios** - Radio button groups:
  - Vertical layout
  - Inline layout
  - With hints on options
  - Single selection validation

## Layout Components

### Header
- **/header** - Page header examples:
  - Basic header
  - Header with service name
  - Header with navigation

### Footer
- **/footer** - Page footer:
  - Standard footer
  - Footer with links
  - Copyright information

### Form Group
- **/form-group** - Form organization:
  - Grouping form elements
  - Proper spacing
  - Error handling

### Fieldset Group
- **/fieldset-group** - Related field grouping:
  - Address form example
  - Legend as page heading
  - Grouped validation

## Content Components

### Error Handling
- **/error-message** - Individual error messages:
  - Inline error display
  - Error styling

- **/error-summary** - Form-level errors:
  - Summary at top of form
  - Links to error fields
  - Complete validation example

### Help and Information
- **/hint** - Help text:
  - Inline hints
  - Examples of good hint text
  - Accessibility considerations

- **/label** - Form labels:
  - Basic labels
  - Labels as page headings
  - Different sizes

- **/inset-text** - Highlighted content:
  - Important information
  - Differentiated text blocks

### Notifications and Warnings
- **/notification-banner** - Alert messages:
  - Information banners
  - Success banners
  - Custom titles

- **/warning** - Warning messages:
  - Important warnings
  - Legal notices
  - Critical information

- **/phase-banner** - Service phase:
  - Alpha phase
  - Beta phase
  - Feedback integration

### Utility Components
- **/spinner** - Loading indicators:
  - Basic spinner
  - Spinner with text
  - Simulated loading demo

## Navigation Components

### Skip Link
- **/skip-link** - Accessibility:
  - Keyboard navigation aid
  - Jump to main content
  - Screen reader support

## Features Demonstrated

### Validation
- Required field validation
- Email validation
- Range validation
- Custom error messages
- Error summary integration

### Accessibility
- ARIA labels
- Skip links
- Keyboard navigation
- Screen reader support
- Semantic HTML

### User Experience
- Autocomplete attributes
- Input type optimization
- Width constraints for inputs
- Inline vs vertical layouts
- Loading states

### State Management
- Two-way binding (@bind-Value)
- Form submission handling
- Conditional rendering
- Event handling

### Styling
- GOV.UK Design System compliance
- Responsive design
- Mobile-optimized inputs
- Consistent spacing
- Brand colors

## Testing the Application

### Local Testing
```bash
dotnet run
```
Then navigate to https://localhost:5001

### Test Each Component
1. Visit homepage
2. Click through each component link
3. Try form submissions
4. Test validation errors
5. Check responsive design (resize browser)
6. Test keyboard navigation (Tab key)

### Component Integration
- All components work together in forms
- Error summary collects all validation errors
- Consistent styling throughout
- Accessible by default

## For Developers

### Adding New Demo Pages
1. Create new .razor file in Components/Pages/
2. Add @page directive with route
3. Include back link to home
4. Add component examples
5. Update Home.razor with link

### Customizing Examples
- Models are defined inline in @code blocks
- Easy to modify and extend
- Comments explain key concepts
- Follow GDS patterns

### Code Structure
- Each demo is self-contained
- Minimal dependencies
- Clear separation of concerns
- Reusable patterns

## Component Usage Patterns

### Basic Component
```razor
<GdsButton>Click me</GdsButton>
```

### Component with Parameters
```razor
<GdsInputText @bind-Value="model.Name" Label="Full name" />
```

### Component with Child Content
```razor
<GdsCheckbox @bind-Value="model.Agree">
    I agree to the terms
</GdsCheckbox>
```

### Strongly-Typed Components
```razor
<GdsRadios T="string" @bind-Value="model.Choice" Label="Choose">
    <GdsRadio T="string" Value="option1">Option 1</GdsRadio>
</GdsRadios>
```

## Next Steps

1. Explore each component demo
2. Review the code for examples
3. Customize for your needs
4. Deploy to Azure (see DEPLOYMENT_GUIDE.md)
5. Build your own GOV.UK service!
