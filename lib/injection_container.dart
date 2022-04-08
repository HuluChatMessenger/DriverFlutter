import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:hulutaxi_driver/core/network/network_info.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/remote_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/repositories/repository_impl.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_login_otp.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/login/data/datasources/local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Features
  //Bloc
  sl.registerFactory(() => LoginBloc(
        getLoginOTP: sl(),
        inputConverter: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => GetLoginOTP(sl()));

  //Repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl()),
  );

  ///Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
