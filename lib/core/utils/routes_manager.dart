import 'package:flutter/material.dart';
import 'package:todo_app/presentation/home/home_screen.dart';

import '../../presentation/auth/login/login.dart';
import '../../presentation/auth/register/register.dart';

class RoutesManager{
  static const String home="/home";
  static const String splash = '/splash';
  static const String register = '/register';
  static const String login = '/login';
  static Route? router(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(builder: (context)=>HomeScreen());
      case register:
        return MaterialPageRoute(
          builder: (context) => const Register(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
    }
  }
}