import 'package:flutter_tour_app_firebase/ui/app/booked_trip_screen.dart';
import 'package:flutter_tour_app_firebase/ui/app/home_screen.dart';
import 'package:flutter_tour_app_firebase/ui/app/register_screen.dart';
import 'package:flutter_tour_app_firebase/ui/app/splash_screen.dart';
import 'package:flutter_tour_app_firebase/ui/app/trip_details_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/app/login_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String trip_details = '/trip_details';
  static const String bookedTrip = '/booked_trip';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => HomeScreen(),
    trip_details: (BuildContext context) => TripDetailsScreen(),
    bookedTrip: (BuildContext context) => BookedTripScreen(),

  };
}



