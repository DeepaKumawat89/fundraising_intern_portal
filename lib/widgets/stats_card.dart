import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_utils.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.responsiveCardPadding(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: ResponsiveUtils.responsiveBorderRadius(
          context,
          mobile: 12,
          tablet: 16,
          desktop: 20,
        ),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(AppTheme.responsiveSpacingSM(context)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.responsiveValue(
                      context,
                      mobile: 6,
                      tablet: 8,
                      desktop: 10,
                    ),
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: ResponsiveUtils.responsiveIconSize(
                    context,
                    mobile: 18,
                    tablet: 20,
                    desktop: 24,
                  ),
                ),
              ),
              Icon(
                Icons.trending_up,
                color: AppTheme.successColor,
                size: ResponsiveUtils.responsiveIconSize(
                  context,
                  mobile: 14,
                  tablet: 16,
                  desktop: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.responsiveSpacingMD(context)),
          Text(
            value,
            style: AppTheme.responsiveHeadingMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppTheme.responsiveSpacingXS(context)),
          Text(
            title,
            style: AppTheme.responsiveBodySmall(
              context,
            ).copyWith(color: AppTheme.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
