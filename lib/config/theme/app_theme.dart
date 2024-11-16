import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.blue,
          primary: ColorsManager.blue,
          onPrimary: ColorsManager.white,
          onSecondary: ColorsManager.blue
      ),
      useMaterial3: false,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: ColorsManager.blue,
          titleTextStyle: LightAppStyle.appBar),
      scaffoldBackgroundColor: ColorsManager.greenAccent,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: ColorsManager.blue,
        unselectedItemColor: ColorsManager.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 33),
        unselectedIconTheme: IconThemeData(size: 33),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(color: ColorsManager.white, width: 4)),
        backgroundColor: ColorsManager.blue,
        iconSize: 26,
        foregroundColor: ColorsManager.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        )),
      ),
      textTheme: TextTheme(
        bodyMedium: LightAppStyle.calenderSelectedDate,
        bodySmall: LightAppStyle.calenderUnSelectedDate,
        headlineSmall:LightAppStyle.todoDesc,
          titleMedium: LightAppStyle.settingsTabLabel,
          titleLarge: LightAppStyle.bottomSheetTitle,
      )
  );
  static ThemeData dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.blue,
          primary: ColorsManager.darkBlue,
          onPrimary: ColorsManager.lightBlack,
          onSecondary: ColorsManager.blue),
      useMaterial3: false,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: ColorsManager.blue,
          titleTextStyle: LightAppStyle.appBar.copyWith(color: ColorsManager.darkBlue)),
      scaffoldBackgroundColor: ColorsManager.darkBlue,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: ColorsManager.blue,
        unselectedItemColor: ColorsManager.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 33),
        unselectedIconTheme: IconThemeData(size: 33),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
        color: ColorsManager.lightBlack,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(color: ColorsManager.black, width: 4)),
        backgroundColor: ColorsManager.blue,
        iconSize: 26,
        foregroundColor: ColorsManager.black,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsManager.lightBlack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )),
      ),
      textTheme: TextTheme(
        bodyMedium: LightAppStyle.calenderSelectedDate,
        bodySmall: LightAppStyle.calenderUnSelectedDate.copyWith(color: ColorsManager.white),
        headlineSmall:LightAppStyle.todoDesc.copyWith(color: ColorsManager.white),
        titleMedium: LightAppStyle.settingsTabLabel.copyWith(color: ColorsManager.white),
        titleLarge: LightAppStyle.bottomSheetTitle.copyWith(color: ColorsManager.white),
      ),
  );

}
