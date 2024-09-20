import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/core/bloc_config/observer.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/network/url_config.dart';
import 'package:sound_mind/core/notifications/notification_service.dart';
import 'package:sound_mind/core/notifications/push_notification.dart';
import 'package:sound_mind/core/storage/hive/hive_service.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:sound_mind/features/Authentication/data/repositories/Authentication_repository_impl.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/check_user.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/create_account.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/login.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/verify_email.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Security/data/datasources/Security_hive_data_source.dart';
import 'package:sound_mind/features/Security/data/repositories/Security_repository_impl.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';
import 'package:sound_mind/features/Security/domain/usecases/check_pin.dart';
import 'package:sound_mind/features/Security/domain/usecases/clear_pin.dart';
import 'package:sound_mind/features/Security/domain/usecases/is_pin_set.dart';
import 'package:sound_mind/features/Security/domain/usecases/save_pin.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';
import 'package:sound_mind/features/chat/data/datasources/chat_hive_data_source.dart';
import 'package:sound_mind/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:sound_mind/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:sound_mind/features/chat/domain/repositories/chat_repository.dart';
import 'package:sound_mind/features/chat/domain/usecases/get_chat_data.dart';
import 'package:sound_mind/features/chat/presentation/blocs/chat_bloc.dart';
import 'package:sound_mind/features/setting/data/datasources/setting_hive_data_source.dart';
import 'package:sound_mind/features/setting/data/datasources/setting_remote_data_source.dart';
import 'package:sound_mind/features/setting/data/repositories/setting_repository_impl.dart';
import 'package:sound_mind/features/setting/domain/repositories/setting_repository.dart';
import 'package:sound_mind/features/setting/domain/usecases/change_password.dart';
import 'package:sound_mind/features/setting/domain/usecases/get_setting_data.dart';
import 'package:sound_mind/features/setting/domain/usecases/get_user_data.dart';
import 'package:sound_mind/features/setting/domain/usecases/update_user_details.dart';
import 'package:sound_mind/features/setting/presentation/blocs/setting_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton(() => LocalNotificationService());
  sl.registerLazySingleton(() => PushNotificationService());

  // Hive initialization
  final hiveService = HiveService();
  await hiveService.init();
  await Hive.openBox("userBox");
  sl.registerLazySingleton(() => hiveService);

  sl
    ..registerFactory(() => AuthenticationBloc(
        createAccount: sl(), verifyEmail: sl(), login: sl(), checkUser: sl()))
    ..registerLazySingleton(() => CreateAccount(repository: sl()))
    ..registerLazySingleton(() => CheckUserUseCase(repository: sl()))
    ..registerLazySingleton(() => VerifyEmail(repository: sl()))
    ..registerLazySingleton(() => Login(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(
            authenticationRemoteDataSource: sl(),
            authenticationHiveDataSource: sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<AuthenticationHiveDataSource>(
        () => AuthenticationHiveDataSourceImpl(box: sl()))
    ..registerLazySingleton(
        () => Network(baseUrl: UrlConfig.baseUrl, showLog: true));

  sl
    ..registerFactory(() => SecurityBloc(
        checkPin: sl(), clearPin: sl(), savePin: sl(), isPinSets: sl()))
    ..registerLazySingleton(() => CheckPin(repository: sl()))
    ..registerLazySingleton(() => IsPinSetuseCase(repository: sl()))
    ..registerLazySingleton(() => ClearPin(repository: sl()))
    ..registerLazySingleton(() => SavePin(repository: sl()))
    ..registerLazySingleton<SecurityRepository>(
        () => SecurityRepositoryImpl(securityHiveDataSource: sl()))
    ..registerLazySingleton<SecurityHiveDataSource>(
        () => SecurityHiveDataSourceImpl(box: sl()));

  sl
    ..registerFactory(() => SettingBloc(
        getUserDetails: sl(),
        updateUserDetails: sl(),
        changePassword: sl(),
        getSettingData: sl()))
    ..registerLazySingleton(() => GetSettingData(repository: sl()))
    ..registerLazySingleton(() => GetUserDetails(repository: sl()))
    ..registerLazySingleton(() => UpdateUserDetails(repository: sl()))
    ..registerLazySingleton(() => ChangePassword(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<SettingRepository>(() =>
        SettingRepositoryImpl(remoteDataSource: sl(), hiveDataSource: sl()))
    ..registerLazySingleton<SettingRemoteDataSource>(
      () => SettingRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<SettingHiveDataSource>(
      () => SettingHiveDataSourceImpl(box: sl()),
    );

  sl
    ..registerFactory(() => ChatBloc(getChatData: sl()))
    ..registerLazySingleton(() => GetChatData(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<ChatHiveDataSource>(
      () => ChatHiveDataSourceImpl(),
    );

  final box = Hive.box('userBox');
  sl.registerSingleton<Box>(box);

  Bloc.observer = SimpleBlocObserver();
}
