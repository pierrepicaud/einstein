// TODO: Implement dynamic route
// source: https://www.youtube.com/watch?v=nyvwx7o277U

// import 'package:einstein/ui/authentication/login_screen.dart';
import 'dart:html';
import 'package:einstein/ui/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:einstein/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final agrs = settings.arguments;
    switch (settings.name) {
      case '/':
        // return MaterialPageRoute(builder: (_) => LoginScreen.routeName);
      case '/second': // another page
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
