import 'package:flutter/material.dart';
import 'package:qq/models/restaurant.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/views/login_screen.dart';
import 'package:qq/views/manager/manager.dart';
import 'package:qq/views/customer/customer.dart';
import 'package:qq/views/signup_screen.dart';
import 'package:qq/views/splash_screen.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ========= App ==========
      case RoutePath.login:
        return MaterialPageRoute(
            settings: settings, builder: (context) => LoginScreen());
        break;
      case RoutePath.signup:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SignUpScreen());
        break;

      // ========= App ==========
      case RoutePath.appCustomerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (context) => AppCustomerScreen());
        break;
      case RoutePath.customerTabHome:
        return MaterialPageRoute(
            settings: settings, builder: (context) => HomeCustomerTab());
      case RoutePath.customerRestaurantDetail:
        Restaurant restaurant = settings.arguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => RestaurantDetailScreen(
                  restaurant: restaurant,
                ));
        break;

      // ========= Manager ==========
      case RoutePath.appManagerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (context) => AppManagerScreen());
        break;
      case RoutePath.managerTabQueueManage:
        return MaterialPageRoute(
            settings: settings, builder: (context) => QueueManagementScreen());
      // ========= Default ==========
      default:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SplashScreen());
    }
  }
}
