import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive_utils.dart';

class AppTheme {
  // Color Scheme
  static const Color primaryColor = Color(0xFF667eea);
  static const Color secondaryColor = Color(0xFF764ba2);
  static const Color backgroundColor = Color(0xFFF8F9FF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color successColor = Color(0xFF48BB78);
  static const Color warningColor = Color(0xFFED8936);
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color surfaceColor = Color(0xFFEDF2F7);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF7FAFC)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundColor, Color(0xFFEDF2F7)],
  );

  // Text Styles
  static TextStyle get headingLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static TextStyle get headingMedium => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get headingSmall => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textPrimary,
  );

  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle get captionText => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondary,
  );

  // Responsive Text Styles
  static TextStyle responsiveHeadingLarge(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 28,
          tablet: 32,
          desktop: 36,
        ),
        fontWeight: FontWeight.bold,
        color: textPrimary,
      );

  static TextStyle responsiveHeadingMedium(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 20,
          tablet: 24,
          desktop: 28,
        ),
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  static TextStyle responsiveHeadingSmall(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 16,
          tablet: 20,
          desktop: 22,
        ),
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  static TextStyle responsiveBodyLarge(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 14,
          tablet: 16,
          desktop: 18,
        ),
        fontWeight: FontWeight.w400,
        color: textPrimary,
      );

  static TextStyle responsiveBodyMedium(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        ),
        fontWeight: FontWeight.w400,
        color: textPrimary,
      );

  static TextStyle responsiveBodySmall(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 10,
          tablet: 12,
          desktop: 14,
        ),
        fontWeight: FontWeight.w400,
        color: textSecondary,
      );

  static TextStyle responsiveButtonText(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: ResponsiveUtils.responsiveFontSize(
          context,
          mobile: 14,
          tablet: 16,
          desktop: 18,
        ),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: primaryColor.withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 6),
    ),
  ];

  // Border Radius
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(12),
  );
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(10));

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Responsive Spacing
  static double responsiveSpacingXS(BuildContext context) =>
      ResponsiveUtils.responsiveSpacing(
        context,
        mobile: 4.0,
        tablet: 6.0,
        desktop: 8.0,
      );

  static double responsiveSpacingSM(BuildContext context) =>
      ResponsiveUtils.responsiveSpacing(
        context,
        mobile: 8.0,
        tablet: 12.0,
        desktop: 16.0,
      );

  static double responsiveSpacingMD(BuildContext context) =>
      ResponsiveUtils.responsiveSpacing(
        context,
        mobile: 16.0,
        tablet: 20.0,
        desktop: 24.0,
      );

  static double responsiveSpacingLG(BuildContext context) =>
      ResponsiveUtils.responsiveSpacing(
        context,
        mobile: 24.0,
        tablet: 32.0,
        desktop: 40.0,
      );

  static double responsiveSpacingXL(BuildContext context) =>
      ResponsiveUtils.responsiveSpacing(
        context,
        mobile: 32.0,
        tablet: 48.0,
        desktop: 64.0,
      );

  static double responsiveSpacingXXL(BuildContext context) =>
      ResponsiveUtils.responsiveSpacing(
        context,
        mobile: 48.0,
        tablet: 64.0,
        desktop: 80.0,
      );

  // Responsive Padding
  static EdgeInsets responsivePadding(BuildContext context) =>
      ResponsiveUtils.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(24.0),
        desktop: const EdgeInsets.all(32.0),
      );

  static EdgeInsets responsiveCardPadding(BuildContext context) =>
      ResponsiveUtils.responsivePadding(
        context,
        mobile: const EdgeInsets.all(12.0),
        tablet: const EdgeInsets.all(16.0),
        desktop: const EdgeInsets.all(20.0),
      );

  // Theme Data
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: textPrimary),
      titleTextStyle: headingMedium,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: primaryColor.withOpacity(0.3),
        shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingLG,
          vertical: spacingMD,
        ),
        textStyle: buttonText,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: BorderSide(color: surfaceColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: BorderSide(color: surfaceColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: inputRadius,
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMD,
        vertical: spacingMD,
      ),
      hintStyle: bodyMedium.copyWith(color: textSecondary),
      labelStyle: bodyMedium.copyWith(color: textSecondary),
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: const RoundedRectangleBorder(borderRadius: cardRadius),
    ),
  );
}
