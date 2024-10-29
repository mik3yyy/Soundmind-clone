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
import 'package:sound_mind/features/Authentication/domain/usecases/change_password.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/check_user.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/create_account.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/log_out.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/login.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/resend_otp.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/update_user.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/verify_email.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/cubit/resend_otp_cubit.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/update_user/update_user_cubit.dart';
import 'package:sound_mind/features/Security/data/datasources/Security_hive_data_source.dart';
import 'package:sound_mind/features/Security/data/repositories/Security_repository_impl.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';
import 'package:sound_mind/features/Security/domain/usecases/check_pin.dart';
import 'package:sound_mind/features/Security/domain/usecases/clear_pin.dart';
import 'package:sound_mind/features/Security/domain/usecases/is_pin_set.dart';
import 'package:sound_mind/features/Security/domain/usecases/save_pin.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';
import 'package:sound_mind/features/Security/presentation/blocs/change_pin/change_pin_cubit.dart';
import 'package:sound_mind/features/appointment/data/datasources/appointment_hive_data_source.dart';
import 'package:sound_mind/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:sound_mind/features/appointment/domain/usecases/create_booking.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_accepted_appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_doctor.detail.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_doctors.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_pending_appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_physician_schedule.dart';
import 'package:sound_mind/features/appointment/domain/usecases/make_appointment_payment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/rejected_appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/upcoming_appointment.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/appointment_bloc.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/booking/booking_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor/doctor_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/doctor_details/doctor_details_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/get_accepted_appointments/get_accepted_appointments_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/get_pending_appointments/get_pending_appointments_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/get_rejected_appointments/get_rejected_appointments_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/payment/payment_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/physician_schedule/physician_schedule_cubit.dart';
import 'package:sound_mind/features/appointment/presentation/blocs/upcoming_appointment/upcoming_appointment_cubit.dart';

import 'package:sound_mind/features/chat/data/datasources/chat_hive_data_source.dart';
import 'package:sound_mind/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:sound_mind/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:sound_mind/features/chat/domain/repositories/chat_repository.dart';
import 'package:sound_mind/features/chat/domain/usecases/get_chat_data.dart';
import 'package:sound_mind/features/chat/presentation/blocs/get_chat_room_messages/get_chat_room_messages_cubit.dart';
import 'package:sound_mind/features/chat/presentation/blocs/get_user_chat_rooms/get_user_chat_rooms_cubit.dart';
import 'package:sound_mind/features/chat/presentation/blocs/chat_bloc.dart';
import 'package:sound_mind/features/notification/data/datasources/notification_hive_data_source.dart';
import 'package:sound_mind/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:sound_mind/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:sound_mind/features/notification/domain/repositories/notification_repository.dart';
import 'package:sound_mind/features/notification/domain/usecases/get_notification_data.dart';
import 'package:sound_mind/features/notification/presentation/blocs/notification_bloc.dart';
import 'package:sound_mind/features/setting/data/datasources/setting_hive_data_source.dart';
import 'package:sound_mind/features/setting/data/datasources/setting_remote_data_source.dart';
import 'package:sound_mind/features/setting/data/repositories/setting_repository_impl.dart';
import 'package:sound_mind/features/setting/domain/repositories/setting_repository.dart';
import 'package:sound_mind/features/setting/domain/usecases/change_password.dart';
import 'package:sound_mind/features/setting/domain/usecases/get_setting_data.dart';
import 'package:sound_mind/features/setting/domain/usecases/get_user_data.dart';
import 'package:sound_mind/features/setting/domain/usecases/update_user_details.dart';
import 'package:sound_mind/features/setting/presentation/blocs/setting_bloc.dart';
import 'package:sound_mind/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:sound_mind/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:sound_mind/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:sound_mind/features/wallet/domain/usecases/confirm_wallet_top_up.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_banks.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_user_transaction.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_user_wallet.dart';
import 'package:sound_mind/features/wallet/domain/usecases/initiate_wallet_top_up.dart';
import 'package:sound_mind/features/wallet/domain/usecases/resolve_bank.dart';
import 'package:sound_mind/features/wallet/domain/usecases/withdraw_to_bank.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank/get_banks_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/get_bank_transactions/get_bank_transactions_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/resolve_bank_account/resolve_bank_account_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/top_up/topup_wallet_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/wallet_bloc.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/withdraw_to_bank/withdraw_to_bank_cubit.dart';

import '../../features/appointment/data/repositories/appointment_repository_impl.dart';

// import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';
// import 'package:sound_mind/features/appointment/domain/usecases/get_accepted_appointment.dart';
// import 'package:sound_mind/features/appointment/domain/usecases/get_pending_appointment.dart';
// import 'package:sound_mind/features/appointment/domain/usecases/rejected_appointment.dart';
// import 'package:sound_mind/features/appointment/domain/usecases/upcoming_appointment.dart';
// import 'package:sound_mind/features/appointment/presentation/blocs/appointment_bloc.dart';
// import '../../features/appointment/data/repositories/appointment_repository_impl.dart';

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
  sl..registerFactory(() => ResendOtpCubit(resendVerificationOtp: sl()));
  sl
    ..registerFactory(() => AuthenticationBloc(
        login: sl(),
        createAccount: sl(),
        checkUser: sl(),
        logOutUsecase: sl(),
        verifyEmail: sl(),
        resendVerificationOtp: sl()))
    ..registerLazySingleton(() => ResendVerificationOtp(repository: sl()))
    ..registerLazySingleton(() => CreateAccount(repository: sl()))
    ..registerLazySingleton(() => LogOutUsecase(repository: sl()))
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

  sl..registerFactory(() => ChangePinCubit(checkPin: sl()));
  sl
    ..registerFactory(() => UpdateUserCubit(updateUserUseCase: sl()))
    ..registerLazySingleton(() => UpdateUserUseCase(repository: sl()));

  sl
    ..registerFactory(() => ResolveBankAccountCubit(resolveBankAccount: sl()))
    ..registerLazySingleton(() => ResolveBankAccount(repository: sl()));
  sl
    ..registerFactory(() => ChangePasswordCubit(changePasswordUseCase: sl()))
    ..registerLazySingleton(() => ChangePasswordUseCase(repository: sl()));

  sl
    ..registerFactory(
        () => TopUpCubit(initiateWalletTopUp: sl(), confirmWalletTopUp: sl()))
    ..registerLazySingleton(() => InitiateWalletTopUp(repository: sl()))
    ..registerLazySingleton(() => ConfirmWalletTopUp(repository: sl()));

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
    ..registerFactory(() => DoctorCubit(getDoctorsUseCase: sl()))
    ..registerLazySingleton(() => GetDoctorsUseCase(repository: sl()));

  sl
    ..registerFactory(() => PaymentCubit(makePaymentForAppointment: sl()))
    ..registerLazySingleton(() => MakePaymentForAppointment(repository: sl()));

  // ..registerLazySingleton(() => GetU[(repository: sl()));

  sl
    ..registerFactory(
        () => PhysicianScheduleCubit(getPhysicianScheduleUseCase: sl()))
    ..registerLazySingleton(
        () => GetPhysicianScheduleUseCase(repository: sl()));

  sl
    ..registerFactory(() => DoctorDetailsCubit(getDoctorDetailsUseCase: sl()))
    ..registerLazySingleton(() => GetDoctorDetailsUseCase(repository: sl()));

  sl
    ..registerFactory(() => CreateBookingCubit(createBooking: sl()))
    ..registerLazySingleton(() => CreateBooking(repository: sl()));

  sl
    ..registerFactory(
        () => GetBankTransactionsCubit(getUserWalletTransactions: sl()))
    ..registerLazySingleton(() => GetUserWalletTransactions(repository: sl()));
  sl
    ..registerFactory(() => GetBanksCubit(getBanks: sl()))
    ..registerLazySingleton(() => GetBanks(repository: sl()));

  sl
    ..registerFactory(() => WithdrawToBankCubit(withdrawToBank: sl()))
    ..registerLazySingleton(() => WithdrawToBank(repository: sl()));

  sl
    ..registerFactory(
        () => UpcomingAppointmentCubit(getUpcomingAppointments: sl()))
    ..registerLazySingleton(() => GetUpcomingAppointments(repository: sl()));

  sl
    ..registerFactory(() => NotificationBloc(getNotificationData: sl()))
    ..registerLazySingleton(() => GetNotificationData(repository: sl()))

    // AuthenticationHiveDataSource
    ..registerLazySingleton<NotificationRepository>(() =>
        NotificationRepositoryImpl(
            remoteDataSource: sl(), hiveDataSource: sl()))
    ..registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<NotificationHiveDataSource>(
      () => NotificationHiveDataSourceImpl(),
    );

  // Cubits
  sl.registerFactory<RejectedAppointmentsCubit>(
    () => RejectedAppointmentsCubit(sl<GetRejectedAppointments>()),
  );
  sl.registerFactory<AcceptedAppointmentsCubit>(
    () => AcceptedAppointmentsCubit(sl<GetAcceptedAppointments>()),
  );
  sl.registerFactory<PendingAppointmentsCubit>(
    () => PendingAppointmentsCubit(sl<GetPendingAppointments>()),
  );
  sl
    ..registerFactory(() => AppointmentBloc(
        getUpcomingAppointments: sl(),
        getAcceptedAppointments: sl(),
        getPendingAppointments: sl(),
        getRejectedAppointments: sl()))
    ..registerLazySingleton(() => GetAcceptedAppointments(repository: sl()))
    ..registerLazySingleton(() => GetPendingAppointments(repository: sl()))
    ..registerLazySingleton(() => GetRejectedAppointments(repository: sl()))

    // AuthenticationHiveDataSource

    ..registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(network: sl()),
    )
    ..registerLazySingleton<AppointmentHiveDataSource>(
      () => AppointmentHiveDataSourceImpl(box: sl()),
    )
    ..registerLazySingleton<AppointmentRepository>(
        () => AppointmentRepositoryImpl(
              remoteDataSource: sl(),
              appointmentHiveDataSource: sl(),
            ));

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

  sl
    ..registerFactory(
        () => GetChatRoomMessagesCubit(getChatRoomMessagesUseCase: sl()))
    ..registerLazySingleton(() => GetChatRoomMessagesUseCase(repository: sl()));

  sl
    ..registerFactory(
        () => GetUserChatRoomsCubit(getUserChatRoomsUseCase: sl()))
    ..registerLazySingleton(() => GetUserChatRoomsUseCase(repository: sl()));

  sl
    ..registerFactory(() => WalletBloc(getUserWallet: sl()))
    ..registerLazySingleton(() => GetUserWallet(repository: sl()))
    ..registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton<WalletRemoteDataSource>(
      () => WalletRemoteDataSourceImpl(network: sl()),
    );

  final box = Hive.box('userBox');
  sl.registerSingleton<Box>(box);

  Bloc.observer = SimpleBlocObserver();
}
