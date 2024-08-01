import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sound_mind/core/bloc_config/observer.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/network/url_config.dart';
import 'package:sound_mind/core/notifications/notification_service.dart';
import 'package:sound_mind/core/notifications/push_notification.dart';
import 'package:sound_mind/core/storage/hive/hive_service.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:sound_mind/features/Authentication/data/repositories/Authentication_repository_impl.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/create_account.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/login.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/verify_email.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton(() => LocalNotificationService());
  sl.registerLazySingleton(() => PushNotificationService());

  // Hive initialization
  final hiveService = HiveService();
  await hiveService.init();
  sl.registerLazySingleton(() => hiveService);

  sl
    ..registerFactory(() =>
        AuthenticationBloc(createAccount: sl(), verifyEmail: sl(), login: sl()))
    ..registerLazySingleton(() => CreateAccount(repository: sl()))
    ..registerLazySingleton(() => VerifyEmail(repository: sl()))
    ..registerLazySingleton(() => Login(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(authenticationRemoteDataSource: sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton(
        () => Network(baseUrl: UrlConfig.baseUrl, showLog: true));

  Bloc.observer = SimpleBlocObserver();
}
