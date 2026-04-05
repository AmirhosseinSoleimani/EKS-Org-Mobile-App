// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sliding_up_panel/sliding_up_panel.dart' as _i882;

import '../app/cubit/app_cubit/app_cubit.dart' as _i757;
import '../features/authentication/data/data_sources/auth_remote_data_source.dart'
    as _i479;
import '../features/authentication/data/data_sources/auth_remote_data_source_impl.dart'
    as _i51;
import '../features/authentication/data/repositories/auth_repository_impl.dart'
    as _i781;
import '../features/authentication/data/service/auth_service.dart' as _i626;
import '../features/authentication/domain/repositories/auth_repository.dart'
    as _i716;
import '../features/authentication/domain/use_cases/login_use_case.dart'
    as _i139;
import '../features/authentication/domain/use_cases/otp_number_validator_use_case.dart'
    as _i632;
import '../features/authentication/domain/use_cases/otp_validator_use_case.dart'
    as _i458;
import '../features/authentication/domain/use_cases/phone_number_validator_use_case.dart'
    as _i826;
import '../features/authentication/domain/use_cases/send_opt_code_use_case.dart'
    as _i563;
import '../features/authentication/presentation/login/cubit/login_cubit.dart'
    as _i566;
import '../features/bottom_navigation_bar/data/remote/data_soures/main_remote_data_source.dart'
    as _i475;
import '../features/bottom_navigation_bar/data/remote/data_soures/main_remote_data_source_impl.dart'
    as _i203;
import '../features/bottom_navigation_bar/data/remote/service/main_service.dart'
    as _i438;
import '../features/bottom_navigation_bar/data/repositories/main_repository_impl.dart'
    as _i320;
import '../features/bottom_navigation_bar/domain/repositories/main_repository.dart'
    as _i854;
import '../features/bottom_navigation_bar/domain/use_case/urgent_request_usecase.dart'
    as _i565;
import '../features/bottom_navigation_bar/presentation/cubit/bottom_navigation_bar_cubit.dart'
    as _i336;
import '../features/requests/data/remote/data_source/request_history_data_source.dart'
    as _i1056;
import '../features/requests/data/remote/data_source/request_history_data_source_impl.dart'
    as _i30;
import '../features/requests/data/remote/service/request_history_service.dart'
    as _i1048;
import '../features/requests/data/repository/request_repository_impl.dart'
    as _i230;
import '../features/requests/data/repository/request_repository_share_data_impl.dart'
    as _i786;
import '../features/requests/domain/repository/request_repository.dart'
    as _i314;
import '../features/requests/domain/repository/request_repository_share_data.dart'
    as _i296;
import '../features/requests/domain/use_case/cancel_request_use_case.dart'
    as _i1011;
import '../features/requests/domain/use_case/change_time_use_case.dart'
    as _i1028;
import '../features/requests/domain/use_case/fetch_active_service_request_use_case.dart'
    as _i538;
import '../features/requests/domain/use_case/fetch_selected_request_item_use_case.dart'
    as _i827;
import '../features/requests/domain/use_case/get_all_request_list_use_case.dart'
    as _i702;
import '../features/requests/domain/use_case/get_cancel_reasons_use_case.dart'
    as _i616;
import '../features/requests/domain/use_case/get_time_use_case.dart' as _i642;
import '../features/requests/domain/use_case/set_selected_request_item_use_case.dart'
    as _i559;
import '../features/requests/domain/use_case/update_payment_use_case.dart'
    as _i31;
import '../features/requests/presentation/active_request/cubit/active_request_cubit.dart'
    as _i1059;
import '../features/requests/presentation/invoice/cubit/request_history_invoice_cubit.dart'
    as _i531;
import '../features/requests/presentation/request_detail/cubit/request_detail_cubit.dart'
    as _i55;
import '../features/requests/presentation/request_list/cubit/request_list_cubit.dart'
    as _i736;
import '../routes/startup_guard.dart' as _i238;
import '../services/local_service/session_local_storage_service/data/data_source/secure_session_storage_mobile_impl.dart'
    as _i577;
import '../services/local_service/session_local_storage_service/data/data_source/secure_session_storage_web_impl.dart'
    as _i718;
import '../services/local_service/session_local_storage_service/data/data_source/session_storage.dart'
    as _i308;
import '../services/network/di/network_module.dart' as _i453;
import '../services/network/interceptors/dio_token_interceptor.dart' as _i466;
import '../services/network/interceptors/pretty_dio_logger.dart' as _i137;
import '../shared/features/invoice/data/remote/data_source/invoice_data_source.dart'
    as _i935;
import '../shared/features/invoice/data/remote/data_source/invoice_data_source_impl.dart'
    as _i981;
import '../shared/features/invoice/data/remote/service/invoice_service.dart'
    as _i634;
import '../shared/features/invoice/data/repository/invoice_repository_impl.dart'
    as _i161;
import '../shared/features/invoice/domain/repository/invoice_repository.dart'
    as _i829;
import '../shared/features/invoice/domain/use_case/confirm_home_service_invoice_use_case.dart'
    as _i242;
import '../shared/features/invoice/domain/use_case/fetch_invoice_use_case.dart'
    as _i981;
import '../shared/features/invoice/domain/use_case/fetch_pre_invoice_on_the_fly_use_case.dart'
    as _i349;
import '../shared/features/invoice/domain/use_case/fetch_pre_invoice_use_case.dart'
    as _i949;
import '../shared/features/observe_network/data/data_source/observe_network_data_source.dart'
    as _i333;
import '../shared/features/observe_network/data/data_source/observe_network_data_source_impl.dart'
    as _i52;
import '../shared/features/observe_network/data/repository/observe_network_repository_impl.dart'
    as _i16;
import '../shared/features/observe_network/data/service/observe_network_service.dart'
    as _i528;
import '../shared/features/observe_network/domain/repository/observe_network_respository.dart'
    as _i422;
import '../shared/features/observe_network/domain/use_case/get_current_network_use_case.dart'
    as _i471;
import '../shared/features/observe_network/domain/use_case/observe_network_use_case.dart'
    as _i1061;
import '../shared/features/user/data/data_source/user_data_source.dart'
    as _i1039;
import '../shared/features/user/data/data_source/user_data_source_impl.dart'
    as _i793;
import '../shared/features/user/data/repository/user_repository_impl.dart'
    as _i880;
import '../shared/features/user/data/service/user_service.dart' as _i313;
import '../shared/features/user/domain/repository/user_repository.dart' as _i74;
import '../shared/features/user/domain/use_case/fetch_base_user_info_use_case.dart'
    as _i216;
import '../shared/features/user/domain/use_case/fetch_car_selected_use_case.dart'
    as _i422;
import '../shared/features/user/domain/use_case/fetch_color_list_use_case.dart'
    as _i435;
import '../shared/features/user/domain/use_case/fetch_cover_car_list_use_case.dart'
    as _i979;
import '../shared/features/user/domain/use_case/fetch_degree_list_use_case.dart'
    as _i489;
import '../shared/features/user/domain/use_case/fetch_profile_use_case.dart'
    as _i499;
import '../shared/features/user/domain/use_case/fetch_user_jobs_use_case.dart'
    as _i332;
import '../shared/features/user/domain/use_case/logout_use_case.dart' as _i138;
import '../shared/features/user/domain/use_case/observe_car_info_list_use_case.dart'
    as _i1055;
import '../shared/features/user/domain/use_case/observe_user_entity_use_case.dart'
    as _i147;
import '../shared/features/user/domain/use_case/set_car_selected_kilometer_use_case.dart'
    as _i856;
import '../shared/features/user/domain/use_case/set_car_selected_use_case.dart'
    as _i605;
import '../shared/features/user/domain/use_case/set_profile_use_case.dart'
    as _i422;
import '../shared/features/user/domain/use_case/update_profile_use_case.dart'
    as _i254;
import '../shared/theme/cubit/theme_cubit.dart' as _i190;
import '../shared/usecase/user_use_case/get_theme_usecase.dart' as _i274;
import '../shared/usecase/user_use_case/set_theme_usecase.dart' as _i776;
import '../shared/usecase/user_use_case/update_user_usecase.dart' as _i994;
import 'app_module.dart' as _i460;
import 'sliding_panel_module.dart' as _i997;

const String _mobile = 'mobile';
const String _web = 'web';
const String _default = 'default';

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final slidingPanelControllerModule = _$SlidingPanelControllerModule();
  final networkModule = _$NetworkModule();
  final appModule = _$AppModule();
  gh.factory<_i757.AppCubit>(() => _i757.AppCubit());
  gh.factory<_i190.ThemeCubit>(() => _i190.ThemeCubit());
  gh.singleton<_i882.PanelController>(
      () => slidingPanelControllerModule.panelController);
  gh.singleton<_i466.DioTokenInterceptor>(
      () => networkModule.dioTokenInterceptor);
  gh.singleton<_i137.PrettyDioLogger>(() => networkModule.prettyDioLogger);
  gh.lazySingleton<_i238.StartupGuard>(() => appModule.startupGuard);
  gh.lazySingleton<_i632.OtpNumberValidatorUseCase>(
      () => _i632.OtpNumberValidatorUseCase());
  gh.lazySingleton<_i458.OtpValidatorUseCase>(
      () => _i458.OtpValidatorUseCase());
  gh.lazySingleton<_i826.PhoneNumberValidatorUseCase>(
      () => _i826.PhoneNumberValidatorUseCase());
  gh.lazySingleton<_i296.RequestRepositoryShareData>(
      () => _i786.RequestRepositoryShareDataImpl());
  gh.lazySingleton<_i308.SessionStorage>(
    () => _i577.SessionStorageMobileImpl(),
    registerFor: {_mobile},
  );
  gh.lazySingleton<_i528.ConnectivityService>(
      () => _i528.ConnectivityServiceImpl(gh<_i895.Connectivity>()));
  gh.lazySingleton<_i308.SessionStorage>(
    () => _i718.SessionStorageWebImpl(),
    registerFor: {_web},
  );
  gh.singleton<_i361.Dio>(() => networkModule.dio(
        gh<_i466.DioTokenInterceptor>(),
        gh<_i137.PrettyDioLogger>(),
      ));
  gh.lazySingleton<_i333.ObserveNetworkDataSource>(
      () => _i52.ObserveNetworkDataSourceImpl(gh<_i528.ConnectivityService>()));
  gh.lazySingleton<_i422.ObserveNetworkRepository>(() =>
      _i16.ObserveNetworkRepositoryImpl(gh<_i333.ObserveNetworkDataSource>()));
  gh.lazySingleton<_i827.FetchSelectedRequestItemUseCase>(() =>
      _i827.FetchSelectedRequestItemUseCase(
          gh<_i296.RequestRepositoryShareData>()));
  gh.lazySingleton<_i559.SetSelectedRequestItemUseCase>(() =>
      _i559.SetSelectedRequestItemUseCase(
          gh<_i296.RequestRepositoryShareData>()));
  gh.lazySingleton<_i626.AuthService>(() => _i626.AuthService(gh<_i361.Dio>()));
  gh.lazySingleton<_i438.MainService>(() => _i438.MainService(gh<_i361.Dio>()));
  gh.lazySingleton<_i1048.RequestService>(
      () => _i1048.RequestService(gh<_i361.Dio>()));
  gh.lazySingleton<_i634.InvoiceService>(
      () => _i634.InvoiceService(gh<_i361.Dio>()));
  gh.lazySingleton<_i313.UserService>(() => _i313.UserService(gh<_i361.Dio>()));
  gh.lazySingleton<_i475.MainRemoteDataSource>(
      () => _i203.MainRemoteDataSourceImpl(gh<_i438.MainService>()));
  gh.lazySingleton<_i471.GetCurrentNetworkStatusUseCase>(() =>
      _i471.GetCurrentNetworkStatusUseCase(
          gh<_i422.ObserveNetworkRepository>()));
  gh.lazySingleton<_i1061.ObserveNetworkUseCase>(
      () => _i1061.ObserveNetworkUseCase(gh<_i422.ObserveNetworkRepository>()));
  gh.lazySingleton<_i1056.RequestDataSource>(
      () => _i30.RequestHistoryDataSourceImpl(gh<_i1048.RequestService>()));
  gh.lazySingleton<_i479.AuthRemoteDataSource>(
      () => _i51.AuthRemoteDataSourceImpl(gh<_i626.AuthService>()));
  gh.lazySingleton<_i314.RequestRepository>(
      () => _i230.RequestRepositoryImpl(gh<_i1056.RequestDataSource>()));
  gh.lazySingleton<_i1039.UserDataSource>(
      () => _i793.UserDataSourceImpl(gh<_i313.UserService>()));
  gh.lazySingleton<_i716.AuthRepository>(() => _i781.AuthRepositoryImpl(
        gh<_i479.AuthRemoteDataSource>(),
        gh<_i308.SessionStorage>(),
      ));
  gh.lazySingleton<_i854.MainRepository>(
      () => _i320.MainRepositoryImpl(gh<_i475.MainRemoteDataSource>()));
  gh.lazySingleton<_i935.InvoiceDataSource>(
      () => _i981.InvoiceDataSourceImpl(gh<_i634.InvoiceService>()));
  gh.lazySingleton<_i829.InvoiceRepository>(
      () => _i161.InvoiceRepositoryImpl(gh<_i935.InvoiceDataSource>()));
  gh.lazySingleton<_i1011.CancelRequestUseCase>(
      () => _i1011.CancelRequestUseCase(gh<_i314.RequestRepository>()));
  gh.lazySingleton<_i538.FetchActiveServiceRequestUseCase>(() =>
      _i538.FetchActiveServiceRequestUseCase(gh<_i314.RequestRepository>()));
  gh.lazySingleton<_i702.GetAllRequestListUseCase>(
      () => _i702.GetAllRequestListUseCase(gh<_i314.RequestRepository>()));
  gh.lazySingleton<_i31.UpdatePaymentUseCase>(
      () => _i31.UpdatePaymentUseCase(gh<_i314.RequestRepository>()));
  gh.lazySingleton<_i242.ConfirmHomeServiceInvoiceUseCase>(() =>
      _i242.ConfirmHomeServiceInvoiceUseCase(gh<_i829.InvoiceRepository>()));
  gh.lazySingleton<_i981.FetchInvoiceUseCase>(
      () => _i981.FetchInvoiceUseCase(gh<_i829.InvoiceRepository>()));
  gh.lazySingleton<_i349.FetchPreInvoiceOnTheFlyUseCase>(() =>
      _i349.FetchPreInvoiceOnTheFlyUseCase(gh<_i829.InvoiceRepository>()));
  gh.lazySingleton<_i949.FetchPreInvoiceUseCase>(
      () => _i949.FetchPreInvoiceUseCase(gh<_i829.InvoiceRepository>()));
  gh.lazySingleton<_i74.UserRepository>(
      () => _i880.UserRepositoryImpl(gh<_i1039.UserDataSource>()));
  gh.lazySingleton<_i1028.ChangeTimeUseCase>(
      () => _i1028.ChangeTimeUseCase(gh<_i314.RequestRepository>()));
  gh.lazySingleton<_i616.GetCancelReasonsUseCase>(
      () => _i616.GetCancelReasonsUseCase(gh<_i314.RequestRepository>()));
  gh.lazySingleton<_i642.GetTimesUseCase>(
      () => _i642.GetTimesUseCase(gh<_i314.RequestRepository>()));
  gh.factory<_i736.RequestListCubit>(() => _i736.RequestListCubit(
        gh<_i702.GetAllRequestListUseCase>(),
        gh<_i559.SetSelectedRequestItemUseCase>(),
      ));
  gh.lazySingleton<_i139.LoginUseCase>(
      () => _i139.LoginUseCase(gh<_i716.AuthRepository>()));
  gh.lazySingleton<_i563.SendOTPCodeUseCase>(
      () => _i563.SendOTPCodeUseCase(gh<_i716.AuthRepository>()));
  gh.lazySingleton<_i565.UrgentRequestUseCase>(
      () => _i565.UrgentRequestUseCase(gh<_i854.MainRepository>()));
  gh.lazySingleton<_i499.FetchProfileUseCase>(
    () => _i499.FetchProfileUseCase(gh<_i74.UserRepository>()),
    registerFor: {
      _default,
      _mobile,
    },
  );
  gh.lazySingleton<_i138.LogoutUseCase>(() => _i138.LogoutUseCase(
        gh<_i74.UserRepository>(),
        gh<_i308.SessionStorage>(),
      ));
  gh.factory<_i55.RequestDetailCubit>(() => _i55.RequestDetailCubit(
        gh<_i827.FetchSelectedRequestItemUseCase>(),
        gh<_i616.GetCancelReasonsUseCase>(),
        gh<_i1011.CancelRequestUseCase>(),
        gh<_i642.GetTimesUseCase>(),
        gh<_i1028.ChangeTimeUseCase>(),
        gh<_i31.UpdatePaymentUseCase>(),
      ));
  gh.lazySingleton<_i216.FetchBaseUserInfoUseCase>(
      () => _i216.FetchBaseUserInfoUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i422.FetchCarSelectedUseCase>(
      () => _i422.FetchCarSelectedUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i435.FetchColorListUseCase>(
      () => _i435.FetchColorListUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i979.FetchCoverCarListUseCase>(
      () => _i979.FetchCoverCarListUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i489.FetchDegreeListUseCase>(
      () => _i489.FetchDegreeListUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i332.FetchUserJobsUseCase>(
      () => _i332.FetchUserJobsUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i1055.ObserveCarInfoListUseCase>(
      () => _i1055.ObserveCarInfoListUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i147.ObserveUserEntityUseCase>(
      () => _i147.ObserveUserEntityUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i605.SetCarSelectedUseCase>(
      () => _i605.SetCarSelectedUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i422.SetProfileUseCase>(
      () => _i422.SetProfileUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i254.UpdateProfileUseCase>(
      () => _i254.UpdateProfileUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i274.GetThemeUseCase>(
      () => _i274.GetThemeUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i776.SetThemeUseCase>(
      () => _i776.SetThemeUseCase(gh<_i74.UserRepository>()));
  gh.lazySingleton<_i994.UpdateUserUseCase>(
      () => _i994.UpdateUserUseCase(gh<_i74.UserRepository>()));
  gh.factory<_i566.LoginCubit>(() => _i566.LoginCubit(
        gh<_i563.SendOTPCodeUseCase>(),
        gh<_i826.PhoneNumberValidatorUseCase>(),
      ));
  gh.factory<_i336.BottomNavigationBarCubit>(() =>
      _i336.BottomNavigationBarCubit(
          gh<_i538.FetchActiveServiceRequestUseCase>()));
  gh.factory<_i531.RequestHistoryInvoiceCubit>(
      () => _i531.RequestHistoryInvoiceCubit(gh<_i981.FetchInvoiceUseCase>()));
  gh.factory<_i1059.ActiveRequestCubit>(() => _i1059.ActiveRequestCubit(
        gh<_i538.FetchActiveServiceRequestUseCase>(),
        gh<_i559.SetSelectedRequestItemUseCase>(),
      ));
  gh.lazySingleton<_i856.SetCarSelectedKilometerUseCase>(
      () => _i856.SetCarSelectedKilometerUseCase(
            gh<_i74.UserRepository>(),
            gh<_i422.FetchCarSelectedUseCase>(),
          ));
  return getIt;
}

class _$SlidingPanelControllerModule
    extends _i997.SlidingPanelControllerModule {}

class _$NetworkModule extends _i453.NetworkModule {}

class _$AppModule extends _i460.AppModule {}
