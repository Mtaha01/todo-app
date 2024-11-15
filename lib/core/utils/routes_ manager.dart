import 'package:flutter/material.dart';

import '../../presentation/home/home_screen.dart';
//import 'package:todo_app_c12_online_sat/presentation/screens/auth/login/login.dart';
//import 'package:todo_app_c12_online_sat/presentation/screens/auth/register/register.dart';
//import 'package:todo_app_c12_online_sat/presentation/screens/home/home_screen.dart';

class RoutesManager {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String register = '/register';
  static const String login = '/login';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      // case register:
      //   return MaterialPageRoute(
      //     builder: (context) => const Register(),
      //   );
      // case login:
      //   return MaterialPageRoute(
      //     builder: (context) => const Login(),
      //   );
    }
  }
}
