import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_strucuture/features/login/cubit/cubit.dart';
import 'package:new_strucuture/features/main_screen/cubit/cubit.dart';
import 'package:new_strucuture/features/splash/cubit/cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:new_strucuture/core/remote/service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';

// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => SplashCubit(),
  );

  serviceLocator.registerFactory(
    () => LoginCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MainCubit(
      serviceLocator(),
    ),
  );

  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(() => PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
            enabled: kDebugMode,
            // filter: (options, args){

            //   }
          )
      //    LogInterceptor(
      //     request: true,
      //     requestBody: true,
      //     requestHeader: true,
      //     responseBody: true,
      //     responseHeader: true,
      //     error: true,
      //   ),
      );
}
