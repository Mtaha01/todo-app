import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/routes_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/provider/setting_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var myProvider=Provider.of<SettingsProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), // Spanish
          ],
          locale: Locale(myProvider.currentLang),
          onGenerateRoute: RoutesManager.router,
          initialRoute: RoutesManager.login,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode:myProvider.currentTheme ),
    );
  }
}
