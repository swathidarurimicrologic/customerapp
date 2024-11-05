import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class OtherAppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        colorScheme: const ColorScheme(
          primary: AppColors.blackColor,
          secondary: AppColors.whiteColor,
          surface: AppColors.blackColor,
          onSurface: AppColors.blackColor,
          brightness: Brightness.light,
          onError: AppColors.errorColor,
          onPrimary: AppColors.whiteColor,
          onSecondary: AppColors.blackColor,
          error: AppColors.errorColor,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          headlineMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headlineLarge: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          titleMedium: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
          titleSmall: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
          ),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          bodySmall: TextStyle(color: AppColors.blackColor, fontSize: 12),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.blackColor),
        appBarTheme: const AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 20, color: AppColors.darkGreyColor),
            centerTitle: true,
            backgroundColor: AppColors.whiteColor),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Get.theme.colorScheme.secondary.withOpacity(0.5);
                    } else if (states.contains(WidgetState.disabled)) {
                      return AppColors.disableButtonColor;
                    } else if (states.contains(WidgetState.error)) {
                      return Get.theme.colorScheme.error.withOpacity(0.5);
                    }
                    return AppColors.whiteColor; // Use the component's default.
                  },
                ),
                textStyle: WidgetStateProperty.all(TextStyle(
                    fontSize: 16,
                    foreground: Paint()..color = AppColors.whiteColor)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Get.theme.colorScheme.primary.withOpacity(0.5);
                  } else if (states.contains(WidgetState.disabled)) {
                    return AppColors.disableButtonColor;
                  }
                  return AppColors.blackColor; // Use the component's default.
                },
              ),
              textStyle: WidgetStateProperty.all(TextStyle(
                  fontSize: 16,
                  foreground: Paint()..color = AppColors.whiteColor))),
        ),
        dividerTheme: const DividerThemeData(
            color: AppColors.disableButtonColor, thickness: 1),
        listTileTheme:
            const ListTileThemeData(selectedColor: AppColors.primaryColor //
                ));
  }
}
