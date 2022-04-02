import 'package:flutter_tour_app_firebase/constants/app_theme.dart';
import 'package:flutter_tour_app_firebase/constants/strings.dart';
import 'package:flutter_tour_app_firebase/data/driver_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/data/repository.dart';
import 'package:flutter_tour_app_firebase/data/repository/firebase_auth_repository.dart';
import 'package:flutter_tour_app_firebase/data/vendor_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/di/components/service_locator.dart';
import 'package:flutter_tour_app_firebase/stores/driver/driver_store.dart';
import 'package:flutter_tour_app_firebase/stores/firebase_user/firebaseuser_store.dart';
import 'package:flutter_tour_app_firebase/stores/vendor/vendor_store.dart';
import 'package:flutter_tour_app_firebase/ui/app/home_screen.dart';
import 'package:flutter_tour_app_firebase/ui/app/register_screen.dart';
import 'package:flutter_tour_app_firebase/ui/login/vendor_dashboard.dart';
import 'package:flutter_tour_app_firebase/utils/routes/routes.dart';
import 'package:flutter_tour_app_firebase/stores/language/language_store.dart';
import 'package:flutter_tour_app_firebase/stores/post/post_store.dart';
import 'package:flutter_tour_app_firebase/stores/theme/theme_store.dart';
import 'package:flutter_tour_app_firebase/stores/user/user_store.dart';
import 'package:flutter_tour_app_firebase/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../widgets/geolocator_widget.dart';
import 'app/booked_trip_screen.dart';
import 'app/login_screen.dart';
import 'app/trip_details_screen.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  final VendorStore _vendorStore = VendorStore(getIt<VendorFireStoreRepository>());
  final DriverStore _driverStore = DriverStore(getIt<DriverFireStoreRepository>());
  final FirebaseUser _firebaseUserStore = FirebaseUser(getIt<FireAuthRepository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<VendorStore>(create: (_) => _vendorStore),
        Provider<DriverStore>(create: (_) => _driverStore),
        Provider<FirebaseUser>(create: (_) => _firebaseUserStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: RegisterScreen(),
          );
        },
      ),
    );
  }
}