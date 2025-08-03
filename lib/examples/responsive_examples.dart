// Example file showing how to use responsive utilities in your Flutter app

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/responsive_layout.dart';

class ResponsiveExampleScreen extends StatelessWidget {
  const ResponsiveExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Design Examples')),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Responsive Text
              Text(
                'Responsive Heading',
                style: AppTheme.responsiveHeadingLarge(context),
              ),
              SizedBox(height: AppTheme.responsiveSpacingMD(context)),

              // 2. Responsive Layout using Extension
              Text(
                context.isMobile
                    ? 'Mobile Layout'
                    : context.isTablet
                    ? 'Tablet Layout'
                    : 'Desktop Layout',
                style: AppTheme.responsiveBodyLarge(context),
              ),
              SizedBox(height: AppTheme.responsiveSpacingLG(context)),

              // 3. Responsive Grid
              ResponsiveGridView(
                children: [
                  _buildExampleCard('Card 1'),
                  _buildExampleCard('Card 2'),
                  _buildExampleCard('Card 3'),
                  _buildExampleCard('Card 4'),
                ],
                childAspectRatio: 1.5,
              ),

              SizedBox(height: AppTheme.responsiveSpacingXL(context)),

              // 4. Responsive Row (becomes column on mobile)
              ResponsiveRow(
                children: [
                  Expanded(child: _buildExampleCard('Responsive Card 1')),
                  SizedBox(width: AppTheme.responsiveSpacingMD(context)),
                  Expanded(child: _buildExampleCard('Responsive Card 2')),
                ],
              ),

              SizedBox(height: AppTheme.responsiveSpacingXL(context)),

              // 5. Responsive Layout Builder
              ResponsiveLayout(
                mobile: _buildMobileLayout(),
                child: Container(), // Required but not used in this pattern
              ),

              SizedBox(height: AppTheme.responsiveSpacingXL(context)),

              // 6. Responsive Values
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Responsive Container',
                    style: AppTheme.responsiveBodyMedium(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: AppTheme.responsiveSpacingXXL(context)),

              // 7. Screen Size Information
              ResponsiveCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Screen Information',
                      style: AppTheme.responsiveHeadingSmall(context),
                    ),
                    SizedBox(height: AppTheme.responsiveSpacingMD(context)),
                    Text(
                      'Width: ${context.screenWidth.toStringAsFixed(0)}px',
                      style: AppTheme.responsiveBodyMedium(context),
                    ),
                    Text(
                      'Height: ${context.screenHeight.toStringAsFixed(0)}px',
                      style: AppTheme.responsiveBodyMedium(context),
                    ),
                    Text(
                      'Device Type: ${_getDeviceType(context)}',
                      style: AppTheme.responsiveBodyMedium(context),
                    ),
                    Text(
                      'Orientation: ${context.isLandscape ? "Landscape" : "Portrait"}',
                      style: AppTheme.responsiveBodyMedium(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(String title) {
    return ResponsiveCard(child: Text(title, textAlign: TextAlign.center));
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Container(
          height: 100,
          color: Colors.red.withOpacity(0.3),
          child: const Center(child: Text('Mobile Layout')),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Container(
          height: 120,
          color: Colors.green.withOpacity(0.3),
          child: const Center(child: Text('Tablet Layout')),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Container(
          height: 150,
          color: Colors.blue.withOpacity(0.3),
          child: const Center(child: Text('Desktop Layout')),
        ),
      ],
    );
  }

  String _getDeviceType(BuildContext context) {
    if (context.isMobile) return 'Mobile';
    if (context.isTablet) return 'Tablet';
    return 'Desktop';
  }
}

// Usage Examples for Common Patterns:

// 1. Responsive Padding
class ResponsivePaddingExample extends StatelessWidget {
  const ResponsivePaddingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveUtils.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16),
        tablet: const EdgeInsets.all(24),
        desktop: const EdgeInsets.all(32),
      ),
      child: const Text('Content with responsive padding'),
    );
  }
}

// 2. Responsive Font Size
class ResponsiveFontExample extends StatelessWidget {
  const ResponsiveFontExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Responsive Text',
      style: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 16,
          tablet: 18,
          desktop: 20,
        ),
      ),
    );
  }
}

// 3. Responsive Icon Size
class ResponsiveIconExample extends StatelessWidget {
  const ResponsiveIconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: ResponsiveUtils.responsiveIconSize(
        context,
        mobile: 24,
        tablet: 28,
        desktop: 32,
      ),
    );
  }
}

// 4. Conditional Widget Based on Screen Size
class ConditionalWidgetExample extends StatelessWidget {
  const ConditionalWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const Column(
        children: [
          Text('Mobile: Vertical Layout'),
          // Mobile-specific widgets
        ],
      );
    } else {
      return const Row(
        children: [
          Text('Tablet/Desktop: Horizontal Layout'),
          // Tablet/Desktop-specific widgets
        ],
      );
    }
  }
}
