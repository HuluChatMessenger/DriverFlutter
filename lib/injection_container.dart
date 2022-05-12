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
import 'package:hulutaxi_driver/features/login/domain/usecases/get_earning_six.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_earnings.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_earnings_initial.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_history_initial.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_history_next.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_hulu_coin_balance.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_logout.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_service.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_wallet_initial.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_wallet_next.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_airtime.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_document.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_feedback.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_login_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_login_resend_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_main.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_pic.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_registration_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_registration_resend_otp.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_vehicle.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/put_driver.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/login_bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/otp_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/login/data/datasources/local_data_source.dart';
import 'features/login/presentation/bloc/pic_bloc.dart';
import 'features/login/presentation/bloc/registration_bloc.dart';
import 'features/login/presentation/bloc/splash_bloc.dart';
import 'features/login/presentation/bloc/vehicle_bloc.dart';

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
        getConfiguration: sl(),
      ));
  sl.registerFactory(() => RegistrationBloc(
        postRegistrationOTP: sl(),
        inputConverter: sl(),
      ));
  sl.registerFactory(() => PicBloc(
        postPic: sl(),
        putDriver: sl(),
        getDriver: sl(),
      ));
  sl.registerFactory(() => VehicleBloc(
        postVehicle: sl(),
      ));
  sl.registerFactory(() => DocumentBloc(
        postDocument: sl(),
        getConfiguration: sl(),
      ));
  sl.registerFactory(() => WaitingBloc(
        getDriver: sl(),
        getConfiguration: sl(),
      ));
  sl.registerFactory(() => MainBloc(
        postMain: sl(),
        getDriver: sl(),
      ));
  sl.registerFactory(() => ProfileBloc(
        getDriver: sl(),
        getEarningSix: sl(),
        getLogout: sl(),
      ));
  sl.registerFactory(() => FeedbackBloc(
        postFeedback: sl(),
      ));
  sl.registerFactory(() => WalletBloc(
        getWalletInitial: sl(),
        getWalletNext: sl(),
      ));
  sl.registerFactory(() => HistoryBloc(
        getHistoryInitial: sl(),
        getHistoryNext: sl(),
      ));
  sl.registerFactory(() => CoinBloc(
        getService: sl(),
        getHuluCoinBalance: sl(),
        postAirtime: sl(),
      ));
  sl.registerFactory(() => EarningsBloc(
        getEarningsInitial: sl(),
        getEarnings: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => PostRegistrationOTP(sl()));
  sl.registerLazySingleton(() => PostLoginOTP(sl()));
  sl.registerLazySingleton(() => PostOtp(sl()));
  sl.registerLazySingleton(() => PostResendOTPLogin(sl()));
  sl.registerLazySingleton(() => PostResendOTPRegistration(sl()));
  sl.registerLazySingleton(() => PostPic(sl()));
  sl.registerLazySingleton(() => PostVehicle(sl()));
  sl.registerLazySingleton(() => PostDocument(sl()));
  sl.registerLazySingleton(() => PostMain(sl()));
  sl.registerLazySingleton(() => PostFeedback(sl()));
  sl.registerLazySingleton(() => PutDriver(sl()));
  sl.registerLazySingleton(() => PostAirtime(sl()));
  sl.registerLazySingleton(() => GetConfiguration(sl()));
  sl.registerLazySingleton(() => GetDriver(sl()));
  sl.registerLazySingleton(() => GetWalletInitial(sl()));
  sl.registerLazySingleton(() => GetWalletNext(sl()));
  sl.registerLazySingleton(() => GetEarningSix(sl()));
  sl.registerLazySingleton(() => GetHistoryInitial(sl()));
  sl.registerLazySingleton(() => GetHistoryNext(sl()));
  sl.registerLazySingleton(() => GetHuluCoinBalance(sl()));
  sl.registerLazySingleton(() => GetService(sl()));
  sl.registerLazySingleton(() => GetEarnings(sl()));
  sl.registerLazySingleton(() => GetEarningsInitial(sl()));
  sl.registerLazySingleton(() => GetLogout(sl()));

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
