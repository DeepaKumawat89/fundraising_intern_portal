import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget child;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return mobile;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints)
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints);
      },
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;
  final Alignment alignment;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.constraints,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.responsiveValue(
              context,
              mobile: 4,
              tablet: 24,
              desktop: 32,
            ),
          ),
      margin: margin,
      constraints:
          constraints ?? ResponsiveUtils.responsiveConstraints(context),
      alignment: alignment,
      child: child,
    );
  }
}

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int? fixedColumns;
  final double? childAspectRatio;
  final EdgeInsets? padding;

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.fixedColumns,
    this.childAspectRatio = 1.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final columns = fixedColumns ?? ResponsiveUtils.responsiveColumns(context);

    return Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: runSpacing,
          childAspectRatio: childAspectRatio ?? 1.0,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool wrap;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.wrap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (wrap && ResponsiveUtils.isMobile(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .map(
              (child) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: child,
              ),
            )
            .toList(),
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

class ResponsiveSizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const ResponsiveSizedBox({super.key, this.width, this.height, this.child});

  const ResponsiveSizedBox.height(double height, {super.key})
    : width = null,
      height = height,
      child = null;

  const ResponsiveSizedBox.width(double width, {super.key})
    : width = width,
      height = null,
      child = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null
          ? ResponsiveUtils.responsiveValue(
              context,
              mobile: width!,
              tablet: width! * 1.2,
              desktop: width! * 1.5,
            )
          : null,
      height: height != null
          ? ResponsiveUtils.responsiveValue(
              context,
              mobile: height!,
              tablet: height! * 1.2,
              desktop: height! * 1.5,
            )
          : null,
      child: child,
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final Color? color;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ??
          ResponsiveUtils.responsiveMargin(
            context,
            mobile: const EdgeInsets.all(8),
            tablet: const EdgeInsets.all(12),
            desktop: const EdgeInsets.all(16),
          ),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: ResponsiveUtils.responsiveBorderRadius(
          context,
          mobile: 12,
          tablet: 16,
          desktop: 20,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: ResponsiveUtils.responsiveValue(
              context,
              mobile: 15,
              tablet: 20,
              desktop: 25,
            ),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding:
            padding ??
            ResponsiveUtils.responsivePadding(
              context,
              mobile: const EdgeInsets.all(16),
              tablet: const EdgeInsets.all(20),
              desktop: const EdgeInsets.all(24),
            ),
        child: child,
      ),
    );
  }
}
