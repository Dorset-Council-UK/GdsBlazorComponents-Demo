# Corrections Made - GDS Blazor Components Demo

## Summary
This document outlines the corrections made to align the demo application with the actual GDS Blazor Components library patterns from the official GitHub repository.

## Key Corrections

### 1. App.razor - CSS and JavaScript References
**Before:**
```html
<link rel="stylesheet" href="https://unpkg.com/govuk-frontend@5.0.0/dist/govuk/govuk-frontend.min.css" />
```

**After:**
```html
<html lang="en-GB" class="govuk-template">
<link rel="stylesheet" href="@Assets["_content/Dorset-Council-UK.GdsBlazorComponents/gds.css"]" />
<script type="module" src="@Assets["_content/Dorset-Council-UK.GdsBlazorComponents/gds.js"]"></script>
<body class="govuk-template__body govuk-frontend-supported">
```

**Reason:** The library includes its own CSS and JS that should be referenced from the package, not from a CDN. The HTML element needs proper GDS class attributes.

### 2. GdsCheckboxes and GdsRadios - Using GdsOptionItem Collections
**Before (Incorrect):**
```razor
<GdsCheckboxes @bind-Value="model.Interests">
    <GdsCheckbox Value="technology">Technology</GdsCheckbox>
    <GdsCheckbox Value="science">Science</GdsCheckbox>
</GdsCheckboxes>
```

**After (Correct):**
```razor
<GdsCheckboxes T="string" Options="@interestOptions" Name="Interests" />

@code {
    private IReadOnlyCollection<GdsOptionItem<string>> interestOptions = [
        new ("interestTechnology", "Technology", "technology"),
        new ("interestScience", "Science", "science"),
    ];
}
```

**Reason:** GdsCheckboxes and GdsRadios components use `GdsOptionItem<T>` collections passed via the `Options` parameter, not child `<GdsCheckbox>` or `<GdsRadio>` components.

### 3. GdsRadios - Requires InputRadioGroup Wrapper
**Before (Incorrect):**
```razor
<GdsRadios T="string" @bind-Value="model.Choice">
    ...
</GdsRadios>
```

**After (Correct):**
```razor
<InputRadioGroup @bind-Value="model.Choice">
    <GdsRadios T="string" Options="@options" />
</InputRadioGroup>
```

**Reason:** GdsRadios must be wrapped in Blazor's `InputRadioGroup` component for proper form binding.

### 4. GdsFormGroup and GdsFieldsetGroup - Structured Content
**Before (Incorrect):**
```razor
<GdsFormGroup>
    <GdsLabel>Label text</GdsLabel>
    <GdsInputText @bind-Value="model.Name" />
</GdsFormGroup>
```

**After (Correct):**
```razor
<GdsFormGroup For="() => model.Name">
    <GdsFieldsetGroup>
        <Heading>
            <h2 class="govuk-fieldset__heading">Question text</h2>
        </Heading>
        <Content>
            <GdsHint>Hint text</GdsHint>
            <GdsErrorMessage />
            <GdsRadios T="string" Options="@options" />
        </Content>
    </GdsFieldsetGroup>
</GdsFormGroup>
```

**Reason:** GdsFieldsetGroup uses render fragments (`<Heading>` and `<Content>`) to structure the content properly for accessibility.

### 5. GdsInputNumber - Dual Binding Pattern
**Before (Incorrect):**
```razor
<GdsInputNumber TNumberValue="int" @bind-Value="model.Age" />
```

**After (Correct):**
```razor
<GdsInputNumber @bind-Value=model.AgeText @bind-NumberValue=model.Age class="govuk-input govuk-input--width-10" />

@code {
    public class Model {
        public string? AgeText { get; set; }
        public int? Age { get; set; }
    }
}
```

**Reason:** GdsInputNumber requires both a string value (`@bind-Value`) and a typed numeric value (`@bind-NumberValue`) for proper validation and display.

### 6. GdsPhaseBanner - Using FeedbackText Parameter
**Before (Incorrect):**
```razor
<GdsPhaseBanner Phase="@GdsPhaseBanner.Phases.Beta">
    This is a demo application
</GdsPhaseBanner>
```

**After (Correct):**
```razor
<GdsPhaseBanner Phase="@GdsPhaseBanner.Phases.Beta" FeedbackText="This is a demo application" />
```

**Reason:** The phase banner uses the `FeedbackText` parameter, not child content.

### 7. GdsOptionItem Constructor - Parameter Order
**Correct Constructor:**
```csharp
public GdsOptionItem(
    ReadOnlySpan<char> id, 
    ReadOnlySpan<char> label, 
    T value, 
    bool selected = false, 
    bool isExclusive = false, 
    ReadOnlySpan<char> hint = default
)
```

**Example with hint:**
```csharp
new ("contactPhone", "Phone", 1, false, false, "We'll call you during business hours")
```

**Reason:** The hint parameter is the last parameter, not a named parameter. Selected and IsExclusive default to false.

### 8. Collection Types
**Before:**
```csharp
private ICollection<GdsOptionItem<int>> options = [...];
```

**After:**
```csharp
private IReadOnlyCollection<GdsOptionItem<int>> options = [...];
```

**Reason:** The components expect `IReadOnlyCollection<GdsOptionItem<T>>`, not `ICollection<T>`.

### 9. Type Parameters
Components like `GdsCheckboxes` and `GdsRadios` require explicit type parameters:
```razor
<GdsCheckboxes T="int" Options="@options" />
<GdsRadios T="string" Options="@options" />
```

##Removed Components

### Removed: GdsButton
The library doesn't include a `GdsButton` component. Standard HTML buttons with GOV.UK classes should be used instead:
```html
<button type="submit" class="govuk-button">Submit</button>
<button type="button" class="govuk-button govuk-button--secondary">Secondary</button>
<button type="button" class="govuk-button govuk-button--warning">Delete</button>
<a href="/" role="button" class="govuk-button govuk-button--start">Start now</a>
```

### Removed: GdsCheckbox (standalone)
Individual `GdsCheckbox` components are not used directly with binding. They're used within custom layouts or the `GdsCheckboxes` component renders them internally.

### Removed: GdsRadio (standalone)
Similar to checkboxes, `GdsRadio` components are rendered by `GdsRadios`, not used individually with binding.

## Added Components

### GdsBreadcrumbs
```razor
<GdsBreadcrumbs Items="@breadcrumbs" />

@code {
    private IReadOnlyCollection<GdsBreadcrumb> breadcrumbs = [
        new GdsBreadcrumb("", "Home"),
        new GdsBreadcrumb("current-page", "Current Page"),
    ];
}
```

### GdsTag
```razor
<GdsTag Text="Completed" />
<GdsTag Colour="GdsTagColour.Green" Text="Approved" />
```

## File Structure Changes

### Updated Files
- `App.razor` - Correct HTML structure and CSS/JS references
- `MainLayout.razor` - Correct PhaseBanner usage
- `CheckboxesDemo.razor` - Complete rewrite using GdsOptionItem
- `RadiosDemo.razor` - Complete rewrite using GdsOptionItem and InputRadioGroup
- `InputNumberDemo.razor` - Dual binding pattern
- `Home.razor` - Added Breadcrumbs and Tag, removed Button

### New Files
- `BreadcrumbsDemo.razor` - Breadcrumbs component demo
- `TagDemo.razor` - Tag component demo with all colors

### Removed Files
- `ButtonDemo.razor` - Component doesn't exist in library
- `RadioDemo.razor` - Merged into RadiosDemo

## Validation Integration

All form demos now properly use:
```razor
<EditForm Model="@model" OnValidSubmit="@HandleValidSubmit">
    <DataAnnotationsValidator />
    <GdsErrorSummary />
    
    <GdsFormGroup For="() => model.Property">
        <GdsErrorMessage />
        <!-- component -->
    </GdsFormGroup>
</EditForm>
```

## Best Practices Applied

1. **Use GdsFormGroup** for all form controls with `For` parameter
2. **Use GdsFieldsetGroup** for grouping related controls with proper heading/content structure
3. **Use InputRadioGroup** to wrap GdsRadios
4. **Provide explicit type parameters** (T) for generic components
5. **Use IReadOnlyCollection** for option collections
6. **Follow GDS Design System patterns** for HTML structure and CSS classes

## Testing
All corrections have been verified to build successfully and follow the patterns documented in the official GDS Blazor Components repository.
