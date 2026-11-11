import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppRadius {
  AppRadius._();
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 28;
  static const double pill = 100;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppTheme {
  AppTheme._();

  // Headings look like Fraunces, body looks like Nunito. Swap here if your
  // design file uses different fonts.
  static TextStyle _heading(double size, {FontWeight weight = FontWeight.w700}) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight,
        color: AppColors.textPrimary,
        height: 1.15,
      );

  static TextStyle _body(double size,
          {FontWeight weight = FontWeight.w500, Color? color}) =>
      GoogleFonts.nunito(
        fontSize: size,
        fontWeight: weight,
        color: color ?? AppColors.textPrimary,
        height: 1.35,
      );

  static final TextTheme _textTheme = TextTheme(
    headlineLarge: _heading(32),
    headlineMedium: _heading(26),
    headlineSmall: _heading(22),
    titleLarge: _heading(20),
    titleMedium: _body(16, weight: FontWeight.w800),
    titleSmall: _body(14, weight: FontWeight.w700),
    bodyLarge: _body(15),
    bodyMedium: _body(13.5),
    bodySmall: _body(12, color: AppColors.textSecondary),
    labelLarge: _body(16, weight: FontWeight.w800),
    labelMedium: _body(13, weight: FontWeight.w700),
    labelSmall: _body(11, weight: FontWeight.w700, color: AppColors.textSecondary),
  );

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(color: color, width: width),
      );

  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.green,
      onSecondary: AppColors.white,
      error: AppColors.urgent,
      onError: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme,
      splashFactory: InkRipple.splashFactory,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: _heading(22),
      ),

      // Primary button (filled orange)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(54),
          textStyle: _textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),

      // Secondary button (outlined orange)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.adopted,
          backgroundColor: AppColors.surface,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: _textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.adopted,
          textStyle: _body(14, weight: FontWeight.w800),
        ),
      ),

      // Text fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: _body(14, color: AppColors.textHint),
        labelStyle: _body(14, weight: FontWeight.w800),
        prefixIconColor: AppColors.textPrimary,
        suffixIconColor: AppColors.textPrimary,
        border: _inputBorder(AppColors.border),
        enabledBorder: _inputBorder(AppColors.border),
        focusedBorder: _inputBorder(AppColors.primary, width: 1.5),
        errorBorder: _inputBorder(AppColors.urgent),
        focusedErrorBorder: _inputBorder(AppColors.urgent, width: 1.5),
      ),

      // Filter chips (All / Dogs / Cats ...). Use ChoiceChip with
      // showCheckmark: false.
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        side: const BorderSide(color: AppColors.border),
        shape: const StadiumBorder(),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        labelStyle: _body(13, weight: FontWeight.w800),
        secondaryLabelStyle:
            _body(13, weight: FontWeight.w800, color: AppColors.white),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      // Filters, Report listing, plan-limit popups
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
        modalBackgroundColor: AppColors.background,
        showDragHandle: true,
        dragHandleColor: AppColors.surfaceDim,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(AppColors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.green
              : AppColors.surfaceDim,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : AppColors.border,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // Used when you build the bottom bar. The bar itself is a custom widget
      // (rounded brown pill with a floating Post button).
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.brown,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.surfaceDim,
        selectedLabelStyle: _body(11, weight: FontWeight.w800),
        unselectedLabelStyle: _body(11, weight: FontWeight.w800),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}