import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:hulutaxi_driver/core/network/network_info.dart';
import 'package:hulutaxi_driver/core/util/input_converter.dart';
import 'package:hulutaxi_driver/features/login/data/datasources/remote_data_source.dart';
import 'package:hulutaxi_driver/features/login/data/repositories/repository_impl.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_driver.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_login_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_login_resend_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_pic.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_registration_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_registration_resend_otp.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/login_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/otp_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/login/data/datasources/local_data_source.dart';
import 'features/login/presentation/bloc/pic_bloc.dart';
import 'features/login/presentation/bloc/registration_bloc.dart';
import 'features/login/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Features
  //Bloc
  sl.registerFactory(() => SplashBloc(
        getConfiguration: sl(),
        getDriver: sl(),
      ));
  sl.registerFactory(() => LoginBloc(
        postLoginOTP: sl(),
        inputConverter: sl(),
      ));
  sl.registerFactory(() => OtpBloc(
        postOtp: sl(),
        postLoginOTP: sl(),
        postRegistrationOTP: sl(),
      ));
  sl.registerFactory(() => RegistrationBloc(
        postRegistrationOTP: sl(),
        inputConverter: sl(),
      ));
  sl.registerFactory(() => PicBloc(
        postPic: sl(),
        postDriver: sl(),
        getDriver: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => PostRegistrationOTP(sl()));
  sl.registerLazySingleton(() => PostLoginOTP(sl()));
  sl.registerLazySingleton(() => PostOtp(sl()));
  sl.registerLazySingleton(() => PostResendOTPLogin(sl()));
  sl.registerLazySingleton(() => PostResendOTPRegistration(sl()));
  sl.registerLazySingleton(() => PostPic(sl()));
  sl.registerLazySingleton(() => PostDriver(sl()));
  sl.registerLazySingleton(() => GetConfiguration(sl()));
  sl.registerLazySingleton(() => GetDriver(sl()));

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
    () => RemoteDataSourceImpl(client: sl(), sharedPreferences: sl()),
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
