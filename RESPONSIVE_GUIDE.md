# Responsive Design Implementation

This document explains how to use the responsive design system implemented in the InternRaise Flutter app.

## Overview

The app now includes a comprehensive responsive design system that adapts to different screen sizes:
- **Mobile**: < 600px width
- **Tablet**: 600px - 900px width  
- **Desktop**: > 900px width
- **Large Desktop**: > 1200px width

## Key Files Added

### 1. `lib/utils/responsive_utils.dart`
Core utility class with responsive helper methods and device detection.

### 2. `lib/widgets/responsive_layout.dart`
Pre-built responsive widgets for common layout patterns.

### 3. `lib/examples/responsive_examples.dart`
Comprehensive examples showing how to use the responsive system.

## Updated Files

### Theme (`lib/theme/app_theme.dart`)
- Added responsive text styles
- Added responsive spacing methods
- Added responsive padding methods

### Main App (`lib/main.dart`)
- Updated SplashScreen with responsive sizing
- Added responsive constraints and padding

### Screens
- **Login Screen**: Responsive layout with adaptive card sizing
- **Dashboard Screen**: Responsive grid layouts for stats cards

### Widgets
- **StatsCard**: Responsive padding, fonts, and icons

## Usage Guide

### 1. Device Detection

```dart
// Using context extensions
if (context.isMobile) {
  // Mobile layout
} else if (context.isTablet) {
  // Tablet layout  
} else {
  // Desktop layout
}

// Using utility methods
if (ResponsiveUtils.isMobile(context)) {
  // Mobile-specific code
}
```

### 2. Responsive Values

```dart
// Responsive sizing
double width = ResponsiveUtils.responsiveValue(
  context,
  mobile: 200,
  tablet: 300,
  desktop: 400,
);

// Responsive font size
double fontSize = ResponsiveUtils.responsiveFontSize(
  context,
  mobile: 16,
  tablet: 18,
  desktop: 20,
);
```

### 3. Responsive Text Styles

```dart
// Use responsive text styles from AppTheme
Text(
  'Heading',
  style: AppTheme.responsiveHeadingLarge(context),
)

Text(
  'Body text',
  style: AppTheme.responsiveBodyMedium(context),
)
```

### 4. Responsive Spacing

```dart
// Responsive spacing
SizedBox(height: AppTheme.responsiveSpacingMD(context))

// Responsive padding
Padding(
  padding: AppTheme.responsivePadding(context),
  child: child,
)
```

### 5. Responsive Layouts

```dart
// Responsive container with constraints
ResponsiveContainer(
  child: YourWidget(),
)

// Responsive grid
ResponsiveGridView(
  children: [
    Widget1(),
    Widget2(),
    Widget3(),
  ],
)

// Responsive row (becomes column on mobile)
ResponsiveRow(
  children: [
    Expanded(child: Widget1()),
    Expanded(child: Widget2()),
  ],
)
```

### 6. Different Layouts for Different Screens

```dart
ResponsiveLayout(
  mobile: MobileWidget(),
  tablet: TabletWidget(),
  desktop: DesktopWidget(),
  child: Container(), // Required but unused
)
```

### 7. Responsive Cards

```dart
ResponsiveCard(
  child: Text('Card content'),
  // Automatically handles responsive padding, margins, and border radius
)
```

## Best Practices

### 1. Always Use Context
- Always pass `BuildContext` to responsive methods
- Use context extensions for cleaner code: `context.isMobile`

### 2. Consistent Breakpoints
- Stick to the defined breakpoints (600px, 900px, 1200px)
- Use the utility methods rather than hardcoding values

### 3. Progressive Enhancement
- Start with mobile design
- Enhance for larger screens
- Provide fallbacks: `tablet ?? mobile`

### 4. Test on Multiple Devices
- Use Device Preview for testing
- Test actual devices when possible
- Verify in landscape and portrait modes

### 5. Performance
- Avoid rebuilding responsive values frequently
- Cache calculated values when appropriate
- Use `LayoutBuilder` sparingly

## Common Patterns

### 1. Responsive Grid Layout
```dart
// Dashboard stats cards
if (context.isMobile) {
  // 2x2 grid for mobile
  return Column(
    children: [
      Row(children: [card1, card2]),
      Row(children: [card3, card4]),
    ],
  );
} else {
  // Single row for tablet/desktop
  return Row(children: [card1, card2, card3, card4]);
}
```

### 2. Responsive Navigation
```dart
// Show different navigation based on screen size
if (context.isMobile) {
  return BottomNavigationBar(...);
} else {
  return SideNavigationRail(...);
}
```

### 3. Responsive Modal/Dialog
```dart
showDialog(
  context: context,
  builder: (context) => Dialog(
    child: Container(
      width: ResponsiveUtils.responsiveValue(
        context,
        mobile: MediaQuery.of(context).size.width * 0.9,
        tablet: 400,
        desktop: 500,
      ),
      child: DialogContent(),
    ),
  ),
);
```

## Screen Size Information

You can access screen dimensions and device info:

```dart
// Screen dimensions
double width = context.screenWidth;
double height = context.screenHeight;

// Safe area padding
EdgeInsets padding = context.safeAreaPadding;

// Orientation
bool isLandscape = context.isLandscape;
bool isPortrait = context.isPortrait;
```

## Migration Guide

To make existing widgets responsive:

1. Replace fixed dimensions with responsive values
2. Replace static text styles with responsive ones
3. Replace fixed padding/margins with responsive versions
4. Add device-specific layouts where needed
5. Test on different screen sizes

## Example Implementation

See `lib/examples/responsive_examples.dart` for a complete example screen showing all responsive features in action.

## Future Enhancements

- Add responsive animations
- Implement responsive images
- Add support for foldable devices
- Create responsive form layouts
- Add accessibility improvements for different screen sizes
