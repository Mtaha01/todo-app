import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/routes_manager.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute:RoutesManager.router,
        initialRoute: RoutesManager.homeRoute,
        title: 'ToDo App',
        theme: AppTheme.light,
    );
  }
}
