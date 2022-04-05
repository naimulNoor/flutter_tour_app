import 'package:flutter_tour_app_firebase/constants/app_theme.dart';
import 'package:flutter_tour_app_firebase/constants/strings.dart';
import 'package:flutter_tour_app_firebase/data/repository.dart';
import 'package:flutter_tour_app_firebase/data/repository/firebase_auth_repository.dart';
import 'package:flutter_tour_app_firebase/data/trip_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/di/components/service_locator.dart';
import 'package:flutter_tour_app_firebase/stores/firebase_user/firebaseuser_store.dart';
import 'package:flutter_tour_app_firebase/stores/trip/trip_store.dart';
import 'package:flutter_tour_app_firebase/ui/app/splash_screen.dart';
import 'package:flutter_tour_app_firebase/utils/routes/routes.dart';
import 'package:flutter_tour_app_firebase/stores/language/language_store.dart';
import 'package:flutter_tour_app_firebase/stores/theme/theme_store.dart';
import 'package:flutter_tour_app_firebase/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'app/home_screen.dart';
import 'app/login_screen.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final FirebaseUser _firebaseUserStore = FirebaseUser(getIt<FireAuthRepository>());
  final TripStore _tripStore = TripStore(getIt<TripFireStoreRepository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<TripStore>(create: (_) => _tripStore),
        Provider<FirebaseUser>(create: (_) => _firebaseUserStore),
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
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}