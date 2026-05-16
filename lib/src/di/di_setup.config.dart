// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
import '../features/authentication/domain/use_cases/phone_number_validator_use_case.dart'
    as _i826;
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
import '../features/dashboard/data/data_sources/dashboard_data_source.dart'
    as _i320;
import '../features/dashboard/data/data_sources/dashboard_data_source_impl.dart'
    as _i822;
import '../features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i650;
import '../features/dashboard/data/service/dashboard_service.dart' as _i953;
import '../features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i602;
import '../features/dashboard/domain/use_cases/get_dashboard_data_use_case.dart'
    as _i208;
import '../features/dashboard/presentation/cubit/dashboard_cubit.dart' as _i932;
import '../features/evaluation/data/remote/data_sources/evaluation_remote_data_source.dart'
    as _i1023;
import '../features/evaluation/data/remote/data_sources/evaluation_remote_data_source_impl.dart'
    as _i832;
import '../features/evaluation/data/remote/service/evaluation_service.dart'
    as _i606;
import '../features/evaluation/data/repositories/evaluation_repository_impl.dart'
    as _i903;
import '../features/evaluation/domain/repositories/evaluation_repository.dart'
    as _i122;
import '../features/evaluation/domain/usecase/accept_evaluation_use_case.dart'
    as _i531;
import '../features/evaluation/domain/usecase/get_aid_services_list_use_case.dart'
    as _i270;
import '../features/evaluation/domain/usecase/get_categories_list_use_case.dart'
    as _i1016;
import '../features/evaluation/domain/usecase/get_defects_list_use_case.dart'
    as _i163;
import '../features/evaluation/domain/usecase/get_service_detail_evaluation_use_case.dart'
    as _i16;
import '../features/evaluation/domain/usecase/post_evaluation_use_case.dart'
    as _i296;
import '../features/indicator_report/data/data_sources/indicator_report_data_source.dart'
    as _i691;
import '../features/indicator_report/data/data_sources/indicator_report_data_source_impl.dart'
    as _i87;
import '../features/indicator_report/data/repositories/indicator_report_repository_impl.dart'
    as _i282;
import '../features/indicator_report/data/service/indicator_report_service.dart'
    as _i140;
import '../features/indicator_report/domain/repositories/indicator_report_repository.dart'
    as _i227;
import '../features/indicator_report/domain/use_cases/fetch_indicator_report_use_case.dart'
    as _i375;
import '../features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart'
    as _i951;
import '../features/services/data/data_source/request_history_data_source.dart'
    as _i1016;
import '../features/services/data/data_source/request_history_data_source_impl.dart'
    as _i576;
import '../features/services/data/repository/request_repository_impl.dart'
    as _i794;
import '../features/services/data/repository/request_repository_share_data_impl.dart'
    as _i318;
import '../features/services/data/service/request_service.dart' as _i483;
import '../features/services/domain/repository/request_repository.dart'
    as _i603;
import '../features/services/domain/repository/request_repository_share_data.dart'
    as _i838;
import '../features/services/domain/usecases/cancel_service_request_use_case.dart'
    as _i320;
import '../features/services/domain/usecases/change_home_service_request_address_use_case.dart'
    as _i998;
import '../features/services/domain/usecases/change_home_service_request_time_use_case.dart'
    as _i509;
import '../features/services/domain/usecases/complete_aid_urgent_request_use_case.dart'
    as _i364;
import '../features/services/domain/usecases/create_follow_up_use_case.dart'
    as _i949;
import '../features/services/domain/usecases/fetch_selected_request_item_use_case.dart'
    as _i376;
import '../features/services/domain/usecases/get_basic_data_use_case.dart'
    as _i1061;
import '../features/services/domain/usecases/get_cancel_reason_request_use_case.dart'
    as _i433;
import '../features/services/domain/usecases/get_cartable_cycle_list_use_case.dart'
    as _i765;
import '../features/services/domain/usecases/get_chassis_request_history_list_use_case.dart'
    as _i581;
import '../features/services/domain/usecases/get_check_depot_use_case.dart'
    as _i990;
import '../features/services/domain/usecases/get_distance_kilometer_use_case.dart'
    as _i985;
import '../features/services/domain/usecases/get_emdadgar_followups_data_use_case.dart'
    as _i734;
import '../features/services/domain/usecases/get_emdadgar_info_use_case.dart'
    as _i786;
import '../features/services/domain/usecases/get_emdadgar_list_use_case.dart'
    as _i955;
import '../features/services/domain/usecases/get_evaluation_history_list_use_case.dart'
    as _i467;
import '../features/services/domain/usecases/get_follow_up_status_type_list_use_case.dart'
    as _i474;
import '../features/services/domain/usecases/get_home_service_request_by_id_use_case.dart'
    as _i63;
import '../features/services/domain/usecases/get_home_service_request_list_use_case.dart'
    as _i809;
import '../features/services/domain/usecases/get_home_service_times_use_case.dart'
    as _i352;
import '../features/services/domain/usecases/get_minimal_customer_info_use_case.dart'
    as _i812;
import '../features/services/domain/usecases/get_non_cooperation_list_use_case.dart'
    as _i707;
import '../features/services/domain/usecases/get_reference_car_use_case.dart'
    as _i639;
import '../features/services/domain/usecases/get_relief_request_by_id_use_case.dart'
    as _i672;
import '../features/services/domain/usecases/get_relief_request_list_use_case.dart'
    as _i192;
import '../features/services/domain/usecases/get_request_control_info_use_case.dart'
    as _i543;
import '../features/services/domain/usecases/get_request_followup_history_use_case.dart'
    as _i67;
import '../features/services/domain/usecases/get_request_status_history_use_case.dart'
    as _i955;
import '../features/services/domain/usecases/service_assign_use_case.dart'
    as _i595;
import '../features/services/domain/usecases/set_selected_request_item_use_case.dart'
    as _i369;
import '../features/services/domain/usecases/update_service_request_use_case.dart'
    as _i180;
import '../features/services/presentation/cancel_request_page/cubit/cancel_request_cubit.dart'
    as _i872;
import '../features/services/presentation/cartable_cycle_page/cubit/cartable_cycle_cubit.dart'
    as _i1029;
import '../features/services/presentation/change_home_service_request_address_page/cubit/change_home_service_request_address_cubit.dart'
    as _i806;
import '../features/services/presentation/change_home_service_request_time_page/cubit/change_home_service_request_time_cubit.dart'
    as _i815;
import '../features/services/presentation/chassis_request_history_page/cubit/chassis_request_history_cubit.dart'
    as _i891;
import '../features/services/presentation/complete_urgent_request_page/cubit/complete_urgent_request_cubit.dart'
    as _i1038;
import '../features/services/presentation/control_info_page/cubit/control_info_cubit.dart'
    as _i66;
import '../features/services/presentation/emdadgar_invoice_page/cubit/emdadgar_invoice_cubit.dart'
    as _i362;
import '../features/services/presentation/evaluation_history/cubit/evaluation_history_cubit.dart'
    as _i154;
import '../features/services/presentation/followup_register_page/cubit/follow_up_register_cubit.dart'
    as _i264;
import '../features/services/presentation/home_service_request_list_page/cubit/home_service_request_list_cubit.dart'
    as _i1013;
import '../features/services/presentation/non_cooperation_page/cubit/non_cooperation_cubit.dart'
    as _i165;
import '../features/services/presentation/online_map_page/cubit/online_map_cubit.dart'
    as _i709;
import '../features/services/presentation/pre_invoice_page/cubit/pre_invoice_cubit.dart'
    as _i809;
import '../features/services/presentation/relief_request_list_page/cubit/relief_request_list_cubit.dart'
    as _i1048;
import '../features/services/presentation/request_detail/cubit/request_detail_cubit.dart'
    as _i802;
import '../features/services/presentation/request_status_history_page/cubit/request_status_history_cubit.dart'
    as _i563;
import '../features/services/presentation/update_request_page/cubit/update_request_cubit.dart'
    as _i792;
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
import '../shared/features/invoice/domain/use_case/customer_pre_invoice_on_the_fly_use_case.dart'
    as _i335;
import '../shared/features/invoice/domain/use_case/get_emdadgar_invoice_use_case.dart'
    as _i204;
import '../shared/features/invoice/domain/use_case/get_pre_invoice_use_case.dart'
    as _i116;
import '../shared/features/map/data/data_source/location_permission_data_source.dart'
    as _i221;
import '../shared/features/map/data/data_source/location_permission_data_source_impl.dart'
    as _i1040;
import '../shared/features/map/data/data_source/map_data_source.dart' as _i971;
import '../shared/features/map/data/data_source/map_data_source_impl.dart'
    as _i583;
import '../shared/features/map/data/repository_impl/location_permission_repository_impl.dart'
    as _i838;
import '../shared/features/map/data/repository_impl/map_repository_impl.dart'
    as _i810;
import '../shared/features/map/data/repository_impl/map_share_data_repository_impl.dart'
    as _i173;
import '../shared/features/map/data/service/address_service.dart' as _i1036;
import '../shared/features/map/data/service/location_permission_service.dart'
    as _i988;
import '../shared/features/map/data/service/map_service.dart' as _i929;
import '../shared/features/map/domain/repository/location_permission_repository.dart'
    as _i995;
import '../shared/features/map/domain/repository/map_repository.dart' as _i92;
import '../shared/features/map/domain/repository/map_share_data_repository.dart'
    as _i837;
import '../shared/features/map/domain/usecase/apply_high_accuracy_use_case.dart'
    as _i296;
import '../shared/features/map/domain/usecase/ensure_location_reading_use_case.dart'
    as _i283;
import '../shared/features/map/domain/usecase/fetch_address_info_use_case.dart'
    as _i406;
import '../shared/features/map/domain/usecase/fetch_address_to_location_use_case.dart'
    as _i739;
import '../shared/features/map/domain/usecase/fetch_location_to_address_use_case.dart'
    as _i730;
import '../shared/features/map/domain/usecase/get_area_base_info_use_case.dart'
    as _i159;
import '../shared/features/map/domain/usecase/get_current_location_use_case.dart'
    as _i705;
import '../shared/features/map/domain/usecase/get_location_data_use_case.dart'
    as _i850;
import '../shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart'
    as _i265;
import '../shared/features/map/domain/usecase/get_route_use_case.dart' as _i678;
import '../shared/features/map/domain/usecase/set_address_info_use_case.dart'
    as _i453;
import '../shared/features/map/presentation/cubit/map_cubit.dart' as _i84;
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
import '../shared/features/server_date_time/data/data_sources/date_time_info_data_source.dart'
    as _i670;
import '../shared/features/server_date_time/data/data_sources/indicator_report_data_source_impl.dart'
    as _i940;
import '../shared/features/server_date_time/data/repositories/dashboard_report_repository_impl.dart'
    as _i258;
import '../shared/features/server_date_time/data/service/date_time_service.dart'
    as _i99;
import '../shared/features/server_date_time/domain/repositories/date_time_info_repository.dart'
    as _i489;
import '../shared/features/server_date_time/domain/use_cases/get_server_date_time_use_case.dart'
    as _i100;
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
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final slidingPanelControllerModule = _$SlidingPanelControllerModule();
  final networkModule = _$NetworkModule();
  final appModule = _$AppModule();
  gh.factory<_i757.AppCubit>(() => _i757.AppCubit());
  gh.factory<_i336.BottomNavigationBarCubit>(
    () => _i336.BottomNavigationBarCubit(),
  );
  gh.factory<_i190.ThemeCubit>(() => _i190.ThemeCubit());
  gh.singleton<_i882.PanelController>(
    () => slidingPanelControllerModule.panelController,
  );
  gh.singleton<_i466.DioTokenInterceptor>(
    () => networkModule.dioTokenInterceptor,
  );
  gh.singleton<_i137.PrettyDioLogger>(() => networkModule.prettyDioLogger);
  gh.lazySingleton<_i238.StartupGuard>(() => appModule.startupGuard);
  gh.lazySingleton<_i826.PhoneNumberValidatorUseCase>(
    () => _i826.PhoneNumberValidatorUseCase(),
  );
  gh.lazySingleton<_i838.RequestRepositoryShareData>(
    () => _i318.RequestRepositoryShareDataImpl(),
  );
  gh.lazySingleton<_i837.MapShareDataRepository>(
    () => _i173.MapShareDataRepositoryImpl(),
  );
  gh.lazySingleton<_i376.FetchSelectedRequestItemUseCase>(
    () => _i376.FetchSelectedRequestItemUseCase(
      gh<_i838.RequestRepositoryShareData>(),
    ),
  );
  gh.lazySingleton<_i369.SetSelectedRequestItemUseCase>(
    () => _i369.SetSelectedRequestItemUseCase(
      gh<_i838.RequestRepositoryShareData>(),
    ),
  );
  gh.lazySingleton<_i406.FetchAddressInfoUseCase>(
    () => _i406.FetchAddressInfoUseCase(gh<_i837.MapShareDataRepository>()),
  );
  gh.lazySingleton<_i453.SetAddressInfoUseCase>(
    () => _i453.SetAddressInfoUseCase(gh<_i837.MapShareDataRepository>()),
  );
  gh.lazySingleton<_i988.ILocationDeviceService>(
    () => _i988.LocationDeviceService(),
  );
  gh.lazySingleton<_i308.SessionStorage>(
    () => _i577.SessionStorageMobileImpl(),
    registerFor: {_mobile},
  );
  gh.lazySingleton<_i988.IPermissionDeviceService>(
    () => _i988.PermissionDeviceService(),
  );
  gh.lazySingleton<_i221.LocationPermissionDataSource>(
    () => _i1040.LocationPermissionDataSourceImpl(
      gh<_i988.ILocationDeviceService>(),
      gh<_i988.IPermissionDeviceService>(),
    ),
  );
  gh.lazySingleton<_i528.ConnectivityService>(
    () => _i528.ConnectivityServiceImpl(gh<_i895.Connectivity>()),
  );
  gh.singleton<_i361.Dio>(
    () => networkModule.dio(
      gh<_i466.DioTokenInterceptor>(),
      gh<_i137.PrettyDioLogger>(),
    ),
  );
  gh.lazySingleton<_i308.SessionStorage>(
    () => _i718.SessionStorageWebImpl(),
    registerFor: {_web},
  );
  gh.lazySingleton<_i995.LocationPermissionRepository>(
    () => _i838.LocationPermissionRepositoryImpl(
      gh<_i221.LocationPermissionDataSource>(),
    ),
  );
  gh.lazySingleton<_i333.ObserveNetworkDataSource>(
    () => _i52.ObserveNetworkDataSourceImpl(gh<_i528.ConnectivityService>()),
  );
  gh.lazySingleton<_i626.AuthService>(() => _i626.AuthService(gh<_i361.Dio>()));
  gh.lazySingleton<_i438.MainService>(() => _i438.MainService(gh<_i361.Dio>()));
  gh.lazySingleton<_i953.DashboardService>(
    () => _i953.DashboardService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i606.EvaluationService>(
    () => _i606.EvaluationService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i140.IndicatorReportService>(
    () => _i140.IndicatorReportService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i483.RequestService>(
    () => _i483.RequestService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i634.InvoiceService>(
    () => _i634.InvoiceService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i1036.AddressService>(
    () => _i1036.AddressService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i929.MapService>(() => _i929.MapService(gh<_i361.Dio>()));
  gh.lazySingleton<_i99.DateTimeService>(
    () => _i99.DateTimeService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i313.UserService>(() => _i313.UserService(gh<_i361.Dio>()));
  gh.lazySingleton<_i691.IndicatorReportDataSource>(
    () =>
        _i87.IndicatorReportDataSourceImpl(gh<_i140.IndicatorReportService>()),
  );
  gh.lazySingleton<_i320.DashboardDataSource>(
    () => _i822.DashboardDataSourceImpl(gh<_i953.DashboardService>()),
  );
  gh.lazySingleton<_i227.IndicatorReportRepository>(
    () => _i282.IndicatorReportRepositoryImpl(
      gh<_i691.IndicatorReportDataSource>(),
    ),
  );
  gh.lazySingleton<_i475.MainRemoteDataSource>(
    () => _i203.MainRemoteDataSourceImpl(gh<_i438.MainService>()),
  );
  gh.lazySingleton<_i854.MainRepository>(
    () => _i320.MainRepositoryImpl(gh<_i475.MainRemoteDataSource>()),
  );
  gh.lazySingleton<_i602.DashboardRepository>(
    () => _i650.DashboardRepositoryImpl(gh<_i320.DashboardDataSource>()),
  );
  gh.lazySingleton<_i296.ApplyHighAccuracyUseCase>(
    () => _i296.ApplyHighAccuracyUseCase(
      gh<_i995.LocationPermissionRepository>(),
    ),
  );
  gh.lazySingleton<_i283.EnsureLocationReadingUseCase>(
    () => _i283.EnsureLocationReadingUseCase(
      gh<_i995.LocationPermissionRepository>(),
    ),
  );
  gh.lazySingleton<_i705.GetCurrentLocationUseCase>(
    () => _i705.GetCurrentLocationUseCase(
      gh<_i995.LocationPermissionRepository>(),
    ),
  );
  gh.lazySingleton<_i935.InvoiceDataSource>(
    () => _i981.InvoiceDataSourceImpl(gh<_i634.InvoiceService>()),
  );
  gh.lazySingleton<_i670.DateTimeInfoDataSource>(
    () => _i940.DateTimeInfoDataSourceImpl(gh<_i99.DateTimeService>()),
  );
  gh.lazySingleton<_i971.MapDataSource>(
    () => _i583.MapDataSourceImpl(
      gh<_i929.MapService>(),
      gh<_i1036.AddressService>(),
    ),
  );
  gh.lazySingleton<_i375.FetchIndicatorReportUseCase>(
    () => _i375.FetchIndicatorReportUseCase(
      gh<_i227.IndicatorReportRepository>(),
    ),
  );
  gh.lazySingleton<_i92.MapRepository>(
    () => _i810.MapRepositoryImpl(gh<_i971.MapDataSource>()),
  );
  gh.lazySingleton<_i565.UrgentRequestUseCase>(
    () => _i565.UrgentRequestUseCase(gh<_i854.MainRepository>()),
  );
  gh.lazySingleton<_i1016.RequestDataSource>(
    () => _i576.RequestDataSourceImpl(gh<_i483.RequestService>()),
  );
  gh.lazySingleton<_i1023.EvaluationRemoteDataSource>(
    () => _i832.FinalizeInvoiceRemoteDataSourceImpl(
      gh<_i606.EvaluationService>(),
    ),
  );
  gh.lazySingleton<_i479.AuthRemoteDataSource>(
    () => _i51.AuthRemoteDataSourceImpl(gh<_i626.AuthService>()),
  );
  gh.lazySingleton<_i829.InvoiceRepository>(
    () => _i161.InvoiceRepositoryImpl(gh<_i935.InvoiceDataSource>()),
  );
  gh.lazySingleton<_i1039.UserDataSource>(
    () => _i793.UserDataSourceImpl(gh<_i313.UserService>()),
  );
  gh.lazySingleton<_i603.RequestRepository>(
    () => _i794.RequestRepositoryImpl(gh<_i1016.RequestDataSource>()),
  );
  gh.lazySingleton<_i998.ChangeHomeServiceRequestAddressUseCase>(
    () => _i998.ChangeHomeServiceRequestAddressUseCase(
      gh<_i603.RequestRepository>(),
    ),
  );
  gh.lazySingleton<_i509.ChangeHomeServiceRequestTimeUseCase>(
    () => _i509.ChangeHomeServiceRequestTimeUseCase(
      gh<_i603.RequestRepository>(),
    ),
  );
  gh.lazySingleton<_i352.GetHomeServiceTimesTimesUseCase>(
    () => _i352.GetHomeServiceTimesTimesUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i422.ObserveNetworkRepository>(
    () =>
        _i16.ObserveNetworkRepositoryImpl(gh<_i333.ObserveNetworkDataSource>()),
  );
  gh.lazySingleton<_i471.GetCurrentNetworkStatusUseCase>(
    () => _i471.GetCurrentNetworkStatusUseCase(
      gh<_i422.ObserveNetworkRepository>(),
    ),
  );
  gh.lazySingleton<_i1061.ObserveNetworkUseCase>(
    () => _i1061.ObserveNetworkUseCase(gh<_i422.ObserveNetworkRepository>()),
  );
  gh.lazySingleton<_i74.UserRepository>(
    () => _i880.UserRepositoryImpl(gh<_i1039.UserDataSource>()),
  );
  gh.lazySingleton<_i489.DateTimeInfoRepository>(
    () => _i258.DateTimeRepositoryImpl(gh<_i670.DateTimeInfoDataSource>()),
  );
  gh.lazySingleton<_i499.FetchProfileUseCase>(
    () => _i499.FetchProfileUseCase(gh<_i74.UserRepository>()),
    registerFor: {_default, _mobile},
  );
  gh.lazySingleton<_i739.FetchAddressToLocationUseCase>(
    () => _i739.FetchAddressToLocationUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i730.FetchLocationToAddressUseCase>(
    () => _i730.FetchLocationToAddressUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i159.GetAreaBaseInfoUseCase>(
    () => _i159.GetAreaBaseInfoUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i850.GetLocationDataUseCase>(
    () => _i850.GetLocationDataUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i265.GetProvinceWithCityListUseCase>(
    () => _i265.GetProvinceWithCityListUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i678.GetRouteUseCase>(
    () => _i678.GetRouteUseCase(gh<_i92.MapRepository>()),
  );
  gh.factory<_i84.MapCubit>(
    () => _i84.MapCubit(
      gh<_i406.FetchAddressInfoUseCase>(),
      gh<_i283.EnsureLocationReadingUseCase>(),
      gh<_i296.ApplyHighAccuracyUseCase>(),
      gh<_i705.GetCurrentLocationUseCase>(),
      gh<_i730.FetchLocationToAddressUseCase>(),
      gh<_i453.SetAddressInfoUseCase>(),
      gh<_i739.FetchAddressToLocationUseCase>(),
    ),
  );
  gh.lazySingleton<_i320.CancelServiceRequestUseCase>(
    () => _i320.CancelServiceRequestUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i364.CompleteAidUrgentRequestUseCase>(
    () => _i364.CompleteAidUrgentRequestUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i949.CreateFollowUpUseCase>(
    () => _i949.CreateFollowUpUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i1061.GetBasicDataUseCase>(
    () => _i1061.GetBasicDataUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i433.GetCancelReasonRequestUseCase>(
    () => _i433.GetCancelReasonRequestUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i765.GetCartableCycleListUseCase>(
    () => _i765.GetCartableCycleListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i581.GetChassisRequestHistoryListUseCase>(
    () => _i581.GetChassisRequestHistoryListUseCase(
      gh<_i603.RequestRepository>(),
    ),
  );
  gh.lazySingleton<_i990.GetCheckDepotUseCase>(
    () => _i990.GetCheckDepotUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i985.GetDistanceKilometerUseCase>(
    () => _i985.GetDistanceKilometerUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i734.GetEmdadgarFollowupsDataUseCase>(
    () => _i734.GetEmdadgarFollowupsDataUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i786.GetEmdadgarInfoUseCase>(
    () => _i786.GetEmdadgarInfoUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i955.GetEmdadgarListUseCase>(
    () => _i955.GetEmdadgarListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i467.GetEvaluationHistoryListUseCase>(
    () => _i467.GetEvaluationHistoryListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i474.GetFollowUpStatusTypeListUseCase>(
    () => _i474.GetFollowUpStatusTypeListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i63.GetHomeServiceRequestByIdUseCase>(
    () => _i63.GetHomeServiceRequestByIdUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i809.GetHomeServiceRequestListUseCase>(
    () => _i809.GetHomeServiceRequestListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i812.GetMinimalCustomerInfoUseCase>(
    () => _i812.GetMinimalCustomerInfoUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i707.GetNonCooperationListUseCase>(
    () => _i707.GetNonCooperationListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i639.GetReferenceCarUseCase>(
    () => _i639.GetReferenceCarUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i672.GetReliefRequestByIdUseCase>(
    () => _i672.GetReliefRequestByIdUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i192.GetReliefRequestListUseCase>(
    () => _i192.GetReliefRequestListUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i543.GetRequestControlInfoUseCase>(
    () => _i543.GetRequestControlInfoUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i67.GetRequestFollowupHistoryUseCase>(
    () => _i67.GetRequestFollowupHistoryUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i955.GetRequestStatusHistoryUseCase>(
    () => _i955.GetRequestStatusHistoryUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i595.ServiceAssignUseCase>(
    () => _i595.ServiceAssignUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i180.UpdateServiceRequestUseCase>(
    () => _i180.UpdateServiceRequestUseCase(gh<_i603.RequestRepository>()),
  );
  gh.lazySingleton<_i100.GetServerDateTimeUseCase>(
    () => _i100.GetServerDateTimeUseCase(gh<_i489.DateTimeInfoRepository>()),
  );
  gh.factory<_i891.ChassisRequestHistoryCubit>(
    () => _i891.ChassisRequestHistoryCubit(
      gh<_i581.GetChassisRequestHistoryListUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
    ),
  );
  gh.lazySingleton<_i208.GetDashboardDataUseCase>(
    () => _i208.GetDashboardDataUseCase(gh<_i602.DashboardRepository>()),
  );
  gh.lazySingleton<_i138.LogoutUseCase>(
    () => _i138.LogoutUseCase(
      gh<_i74.UserRepository>(),
      gh<_i308.SessionStorage>(),
    ),
  );
  gh.factory<_i1029.CartableCycleCubit>(
    () => _i1029.CartableCycleCubit(
      gh<_i765.GetCartableCycleListUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
    ),
  );
  gh.factory<_i264.FollowUpRegisterCubit>(
    () => _i264.FollowUpRegisterCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i67.GetRequestFollowupHistoryUseCase>(),
      gh<_i474.GetFollowUpStatusTypeListUseCase>(),
      gh<_i949.CreateFollowUpUseCase>(),
      gh<_i100.GetServerDateTimeUseCase>(),
    ),
  );
  gh.factory<_i66.ControlInfoCubit>(
    () => _i66.ControlInfoCubit(
      gh<_i543.GetRequestControlInfoUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
    ),
  );
  gh.factory<_i815.ChangeHomeServiceRequestTimeCubit>(
    () => _i815.ChangeHomeServiceRequestTimeCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i352.GetHomeServiceTimesTimesUseCase>(),
      gh<_i509.ChangeHomeServiceRequestTimeUseCase>(),
    ),
  );
  gh.lazySingleton<_i335.CustomerPreInvoiceOnTheFlyUseCase>(
    () =>
        _i335.CustomerPreInvoiceOnTheFlyUseCase(gh<_i829.InvoiceRepository>()),
  );
  gh.lazySingleton<_i204.GetEmdadgarInvoiceUseCase>(
    () => _i204.GetEmdadgarInvoiceUseCase(gh<_i829.InvoiceRepository>()),
  );
  gh.lazySingleton<_i116.GetPreInvoiceUseCase>(
    () => _i116.GetPreInvoiceUseCase(gh<_i829.InvoiceRepository>()),
  );
  gh.factory<_i951.IndicatorReportCubit>(
    () => _i951.IndicatorReportCubit(gh<_i375.FetchIndicatorReportUseCase>()),
  );
  gh.lazySingleton<_i716.AuthRepository>(
    () => _i781.AuthRepositoryImpl(
      gh<_i479.AuthRemoteDataSource>(),
      gh<_i308.SessionStorage>(),
    ),
  );
  gh.lazySingleton<_i139.LoginUseCase>(
    () => _i139.LoginUseCase(gh<_i716.AuthRepository>()),
  );
  gh.factory<_i563.RequestStatusHistoryCubit>(
    () => _i563.RequestStatusHistoryCubit(
      gh<_i955.GetRequestStatusHistoryUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
    ),
  );
  gh.factory<_i566.LoginCubit>(
    () => _i566.LoginCubit(
      gh<_i139.LoginUseCase>(),
      gh<_i826.PhoneNumberValidatorUseCase>(),
    ),
  );
  gh.lazySingleton<_i122.EvaluationRepository>(
    () =>
        _i903.EvaluationRepositoryImpl(gh<_i1023.EvaluationRemoteDataSource>()),
  );
  gh.factory<_i932.DashboardCubit>(
    () => _i932.DashboardCubit(
      gh<_i208.GetDashboardDataUseCase>(),
      gh<_i100.GetServerDateTimeUseCase>(),
    ),
  );
  gh.lazySingleton<_i216.FetchBaseUserInfoUseCase>(
    () => _i216.FetchBaseUserInfoUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i422.FetchCarSelectedUseCase>(
    () => _i422.FetchCarSelectedUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i435.FetchColorListUseCase>(
    () => _i435.FetchColorListUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i979.FetchCoverCarListUseCase>(
    () => _i979.FetchCoverCarListUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i489.FetchDegreeListUseCase>(
    () => _i489.FetchDegreeListUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i332.FetchUserJobsUseCase>(
    () => _i332.FetchUserJobsUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i1055.ObserveCarInfoListUseCase>(
    () => _i1055.ObserveCarInfoListUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i147.ObserveUserEntityUseCase>(
    () => _i147.ObserveUserEntityUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i605.SetCarSelectedUseCase>(
    () => _i605.SetCarSelectedUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i422.SetProfileUseCase>(
    () => _i422.SetProfileUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i254.UpdateProfileUseCase>(
    () => _i254.UpdateProfileUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i274.GetThemeUseCase>(
    () => _i274.GetThemeUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i776.SetThemeUseCase>(
    () => _i776.SetThemeUseCase(gh<_i74.UserRepository>()),
  );
  gh.lazySingleton<_i994.UpdateUserUseCase>(
    () => _i994.UpdateUserUseCase(gh<_i74.UserRepository>()),
  );
  gh.factory<_i154.EvaluationHistoryCubit>(
    () => _i154.EvaluationHistoryCubit(
      gh<_i467.GetEvaluationHistoryListUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
    ),
  );
  gh.factory<_i1013.HomeServiceRequestListCubit>(
    () => _i1013.HomeServiceRequestListCubit(
      gh<_i809.GetHomeServiceRequestListUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
    ),
  );
  gh.lazySingleton<_i856.SetCarSelectedKilometerUseCase>(
    () => _i856.SetCarSelectedKilometerUseCase(
      gh<_i74.UserRepository>(),
      gh<_i422.FetchCarSelectedUseCase>(),
    ),
  );
  gh.factory<_i1038.CompleteUrgentRequestCubit>(
    () => _i1038.CompleteUrgentRequestCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i1061.GetBasicDataUseCase>(),
      gh<_i639.GetReferenceCarUseCase>(),
      gh<_i812.GetMinimalCustomerInfoUseCase>(),
      gh<_i364.CompleteAidUrgentRequestUseCase>(),
    ),
  );
  gh.factory<_i806.ChangeHomeServiceRequestAddressCubit>(
    () => _i806.ChangeHomeServiceRequestAddressCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i265.GetProvinceWithCityListUseCase>(),
      gh<_i998.ChangeHomeServiceRequestAddressUseCase>(),
    ),
  );
  gh.factory<_i809.PreInvoiceCubit>(
    () => _i809.PreInvoiceCubit(
      gh<_i116.GetPreInvoiceUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
    ),
  );
  gh.factory<_i709.OnlineMapCubit>(
    () => _i709.OnlineMapCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i678.GetRouteUseCase>(),
    ),
  );
  gh.factory<_i1048.ReliefRequestListCubit>(
    () => _i1048.ReliefRequestListCubit(
      gh<_i192.GetReliefRequestListUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
    ),
  );
  gh.factory<_i165.NonCooperationCubit>(
    () => _i165.NonCooperationCubit(
      gh<_i707.GetNonCooperationListUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
    ),
  );
  gh.factory<_i802.RequestDetailCubit>(
    () => _i802.RequestDetailCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i67.GetRequestFollowupHistoryUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i955.GetRequestStatusHistoryUseCase>(),
    ),
  );
  gh.factory<_i362.EmdadgarInvoiceCubit>(
    () => _i362.EmdadgarInvoiceCubit(
      gh<_i204.GetEmdadgarInvoiceUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
    ),
  );
  gh.lazySingleton<_i531.AcceptEvaluationUseCase>(
    () => _i531.AcceptEvaluationUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i270.GetAidServicesListUseCase>(
    () => _i270.GetAidServicesListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i1016.GetCategoriesListUseCase>(
    () => _i1016.GetCategoriesListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i163.GetDefectsListUseCase>(
    () => _i163.GetDefectsListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i16.GetServiceDetailEvaluationUseCase>(
    () => _i16.GetServiceDetailEvaluationUseCase(
      gh<_i122.EvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i296.PostEvaluationUseCase>(
    () => _i296.PostEvaluationUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.factory<_i792.UpdateRequestCubit>(
    () => _i792.UpdateRequestCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i265.GetProvinceWithCityListUseCase>(),
      gh<_i850.GetLocationDataUseCase>(),
      gh<_i163.GetDefectsListUseCase>(),
      gh<_i270.GetAidServicesListUseCase>(),
      gh<_i180.UpdateServiceRequestUseCase>(),
    ),
  );
  gh.factory<_i872.CancelRequestCubit>(
    () => _i872.CancelRequestCubit(
      gh<_i433.GetCancelReasonRequestUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i985.GetDistanceKilometerUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i16.GetServiceDetailEvaluationUseCase>(),
      gh<_i296.PostEvaluationUseCase>(),
      gh<_i320.CancelServiceRequestUseCase>(),
      gh<_i335.CustomerPreInvoiceOnTheFlyUseCase>(),
      gh<_i531.AcceptEvaluationUseCase>(),
      gh<_i734.GetEmdadgarFollowupsDataUseCase>(),
    ),
  );
  return getIt;
}

class _$SlidingPanelControllerModule
    extends _i997.SlidingPanelControllerModule {}

class _$NetworkModule extends _i453.NetworkModule {}

class _$AppModule extends _i460.AppModule {}
