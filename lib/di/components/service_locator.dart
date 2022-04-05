
import 'package:dio/dio.dart';
import 'package:flutter_tour_app_firebase/data/driver_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/data/local/datasources/post/post_datasource.dart';
import 'package:flutter_tour_app_firebase/data/network/apis/posts/post_api.dart';
import 'package:flutter_tour_app_firebase/data/network/dio_client.dart';
import 'package:flutter_tour_app_firebase/data/network/rest_client.dart';
import 'package:flutter_tour_app_firebase/data/repository.dart';
import 'package:flutter_tour_app_firebase/data/repository/firebase_auth_repository.dart';
import 'package:flutter_tour_app_firebase/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_tour_app_firebase/data/trip_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/di/module/local_module.dart';
import 'package:flutter_tour_app_firebase/di/module/network_module.dart';
import 'package:flutter_tour_app_firebase/stores/driver/driver_store.dart';
import 'package:flutter_tour_app_firebase/stores/error/error_store.dart';
import 'package:flutter_tour_app_firebase/stores/firebase_user/firebaseuser_store.dart';
import 'package:flutter_tour_app_firebase/stores/form/form_store.dart';
import 'package:flutter_tour_app_firebase/stores/language/language_store.dart';
import 'package:flutter_tour_app_firebase/stores/post/post_store.dart';
import 'package:flutter_tour_app_firebase/stores/theme/theme_store.dart';
import 'package:flutter_tour_app_firebase/stores/trip/trip_store.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));

  // data sources
  getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<PostApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<PostDataSource>(),
  ));
  getIt.registerSingleton(TripFireStoreRepository());
  getIt.registerSingleton(DriverFireStoreRepository());
  getIt.registerSingleton(FireAuthRepository(
    getIt<SharedPreferenceHelper>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(PostStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));

  getIt.registerSingleton(TripStore(getIt<TripFireStoreRepository>()));
  getIt.registerSingleton(DriverStore(getIt<DriverFireStoreRepository>()));
  getIt.registerSingleton(FirebaseUser(getIt<FireAuthRepository>()));


}
