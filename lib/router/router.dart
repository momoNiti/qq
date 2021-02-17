import 'package:qq/models/restaurant.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/views/hoc/app_screen.dart';
import 'package:qq/views/customer/home_page.dart';
import 'package:qq/views/login_screen.dart';
import 'package:qq/views/customer/restaurant_screen.dart';
import 'package:qq/views/signup_screen.dart';
import 'package:qq/views/splash_screen.dart';
import 'package:flutter/material.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.login:
        return MaterialPageRoute(
            settings: settings, builder: (context) => LoginScreen());
        break;
      case RoutePath.signup:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SignUpScreen());
        break;
      case RoutePath.appScreen:
        return MaterialPageRoute(
            settings: settings, builder: (context) => AppScreen());
        break;
      case RoutePath.restaurant:
        Restaurant restaurant = settings.arguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => RestaurantScreen(
                  restaurant: restaurant,
                ));
        break;
      case RoutePath.tabHome:
        return MaterialPageRoute(
            settings: settings, builder: (context) => HomePage());
      default:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SplashScreen());
    }
  }
}
