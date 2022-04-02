import 'package:flutter_tour_app_firebase/ui/home/home.dart';
import 'package:flutter_tour_app_firebase/ui/login/vendor_dashboard.dart';

import 'package:flutter_tour_app_firebase/ui/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../ui/app/login_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/vendor_dashboard';
  static const String trip_details = '/driver_map';
  static const String bookedTrip = '/verify_otp';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    trip_details: (BuildContext context) => VendorDashboard(),
    bookedTrip: (BuildContext context) => VendorDashboard(),

  };
}



