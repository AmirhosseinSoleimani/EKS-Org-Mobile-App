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
import '../features/agency_info/data/data_sources/agency_info_data_source.dart'
    as _i123;
import '../features/agency_info/data/data_sources/agency_info_data_source_impl.dart'
    as _i392;
import '../features/agency_info/data/repositories/agency_info_repository_impl.dart'
    as _i29;
import '../features/agency_info/data/services/agency_info_service.dart'
    as _i427;
import '../features/agency_info/domain/repositories/agency_info_repository.dart'
    as _i233;
import '../features/agency_info/domain/use_cases/add_agency_contract_use_case.dart'
    as _i853;
import '../features/agency_info/domain/use_cases/add_agency_info_use_case.dart'
    as _i574;
import '../features/agency_info/domain/use_cases/add_agency_person_use_case.dart'
    as _i427;
import '../features/agency_info/domain/use_cases/add_agency_vehicle_use_case.dart'
    as _i657;
import '../features/agency_info/domain/use_cases/change_agency_status_use_case.dart'
    as _i147;
import '../features/agency_info/domain/use_cases/delete_agency_use_case.dart'
    as _i449;
import '../features/agency_info/domain/use_cases/get_agency_additional_information_use_case.dart'
    as _i600;
import '../features/agency_info/domain/use_cases/get_agency_contracts_use_case.dart'
    as _i201;
import '../features/agency_info/domain/use_cases/get_agency_history_use_case.dart'
    as _i879;
import '../features/agency_info/domain/use_cases/get_agency_info_by_id_use_case.dart'
    as _i632;
import '../features/agency_info/domain/use_cases/get_agency_info_list_use_case.dart'
    as _i553;
import '../features/agency_info/domain/use_cases/get_agency_info_report_use_case.dart'
    as _i881;
import '../features/agency_info/domain/use_cases/get_agency_service_types_use_case.dart'
    as _i898;
import '../features/agency_info/domain/use_cases/get_current_agency_persons_use_case.dart'
    as _i282;
import '../features/agency_info/domain/use_cases/get_current_agency_vehicles_use_case.dart'
    as _i807;
import '../features/agency_info/domain/use_cases/search_agency_info_use_case.dart'
    as _i516;
import '../features/agency_info/domain/use_cases/search_person_info_use_case.dart'
    as _i699;
import '../features/agency_info/domain/use_cases/search_vehicle_info_use_case.dart'
    as _i645;
import '../features/agency_info/presentation/cubit/add_contract/add_agency_contract_cubit.dart'
    as _i705;
import '../features/agency_info/presentation/cubit/add_person/add_agency_person_cubit.dart'
    as _i735;
import '../features/agency_info/presentation/cubit/add_vehicle/add_agency_vehicle_cubit.dart'
    as _i680;
import '../features/agency_info/presentation/cubit/agency_info_cubit.dart'
    as _i598;
import '../features/authentication/data/data_sources/auth_remote_data_source.dart'
    as _i479;
import '../features/authentication/data/data_sources/auth_remote_data_source_impl.dart'
    as _i51;
import '../features/authentication/data/data_sources/profile_remote_data_source.dart'
    as _i532;
import '../features/authentication/data/data_sources/profile_remote_data_source_impl.dart'
    as _i224;
import '../features/authentication/data/repositories/auth_repository_impl.dart'
    as _i781;
import '../features/authentication/data/repositories/profile_repository_impl.dart'
    as _i1015;
import '../features/authentication/data/service/auth_service.dart' as _i626;
import '../features/authentication/data/service/profile_service.dart' as _i1053;
import '../features/authentication/domain/repositories/auth_repository.dart'
    as _i716;
import '../features/authentication/domain/repositories/profile_repository.dart'
    as _i373;
import '../features/authentication/domain/use_cases/change_password_use_case.dart'
    as _i958;
import '../features/authentication/domain/use_cases/get_current_session.dart'
    as _i424;
import '../features/authentication/domain/use_cases/log_off_use_case.dart'
    as _i845;
import '../features/authentication/domain/use_cases/login_use_case.dart'
    as _i139;
import '../features/authentication/domain/use_cases/phone_number_validator_use_case.dart'
    as _i826;
import '../features/authentication/presentation/login/cubit/login_cubit.dart'
    as _i566;
import '../features/authentication/presentation/profile/cubit/profile_cubit.dart'
    as _i440;
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
import '../features/cartable/data/data_sources/cartable_data_source.dart'
    as _i249;
import '../features/cartable/data/data_sources/cartable_data_source_impl.dart'
    as _i18;
import '../features/cartable/data/repositories/cartable_repository_impl.dart'
    as _i304;
import '../features/cartable/data/service/cartable_service.dart' as _i1027;
import '../features/cartable/domain/repositories/cartable_repository.dart'
    as _i133;
import '../features/cartable/domain/use_cases/archive_cartable_message_use_case.dart'
    as _i657;
import '../features/cartable/domain/use_cases/delegate_cartable_message_use_case.dart'
    as _i301;
import '../features/cartable/domain/use_cases/get_cartable_item_list_use_case.dart'
    as _i862;
import '../features/cartable/domain/use_cases/get_subordinated_users_list_use_case.dart'
    as _i45;
import '../features/cartable/presentation/cubit/cartable_cubit.dart' as _i330;
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
import '../features/deployment_location/data/data_source/deployment_location_data_source.dart'
    as _i557;
import '../features/deployment_location/data/data_source/deployment_location_data_source_impl.dart'
    as _i584;
import '../features/deployment_location/data/repository/deployment_location_repository_impl.dart'
    as _i879;
import '../features/deployment_location/data/service/deployment_location_service.dart'
    as _i86;
import '../features/deployment_location/domain/repository/deployment_location_repository.dart'
    as _i6;
import '../features/deployment_location/domain/usecases/create_deployment_location_use_case.dart'
    as _i550;
import '../features/deployment_location/domain/usecases/delete_deployment_location_use_case.dart'
    as _i950;
import '../features/deployment_location/domain/usecases/get_deployment_location_by_id_use_case.dart'
    as _i510;
import '../features/deployment_location/domain/usecases/get_deployment_location_list_use_case.dart'
    as _i916;
import '../features/deployment_location/domain/usecases/update_deployment_location_use_case.dart'
    as _i676;
import '../features/deployment_location/presentation/cubit/deployment_location_cubit.dart'
    as _i75;
import '../features/emdad_unit/data/data_sources/emdad_unit_data_source.dart'
    as _i930;
import '../features/emdad_unit/data/data_sources/emdad_unit_data_source_impl.dart'
    as _i539;
import '../features/emdad_unit/data/repositories/emdad_unit_repository_impl.dart'
    as _i79;
import '../features/emdad_unit/data/services/emdad_unit_service.dart' as _i54;
import '../features/emdad_unit/domain/repositories/emdad_unit_repository.dart'
    as _i14;
import '../features/emdad_unit/domain/use_cases/assign_emdad_unit_person_use_case.dart'
    as _i125;
import '../features/emdad_unit/domain/use_cases/change_emdad_unit_location_use_case.dart'
    as _i343;
import '../features/emdad_unit/domain/use_cases/create_emdad_unit_use_case.dart'
    as _i930;
import '../features/emdad_unit/domain/use_cases/delete_emdad_unit_person_use_case.dart'
    as _i132;
import '../features/emdad_unit/domain/use_cases/delete_emdad_unit_use_case.dart'
    as _i831;
import '../features/emdad_unit/domain/use_cases/get_emdad_unit_by_id_use_case.dart'
    as _i928;
import '../features/emdad_unit/domain/use_cases/get_emdad_unit_list_use_case.dart'
    as _i262;
import '../features/emdad_unit/domain/use_cases/get_emdad_unit_lookups_use_case.dart'
    as _i690;
import '../features/emdad_unit/domain/use_cases/get_emdad_unit_persons_use_case.dart'
    as _i301;
import '../features/emdad_unit/domain/use_cases/update_emdad_unit_image_use_case.dart'
    as _i76;
import '../features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart'
    as _i471;
import '../features/emdad_vehicle/data/data_sources/emdad_vehicle_data_source.dart'
    as _i639;
import '../features/emdad_vehicle/data/data_sources/emdad_vehicle_data_source_impl.dart'
    as _i808;
import '../features/emdad_vehicle/data/repositories/emdad_vehicle_repository_impl.dart'
    as _i77;
import '../features/emdad_vehicle/data/service/emdad_vehicle_service.dart'
    as _i2;
import '../features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart'
    as _i139;
import '../features/emdad_vehicle/domain/use_cases/create_emdad_vehicle_use_case.dart'
    as _i147;
import '../features/emdad_vehicle/domain/use_cases/delete_emdad_vehicle_use_case.dart'
    as _i996;
import '../features/emdad_vehicle/domain/use_cases/get_active_vehicle_models_use_case.dart'
    as _i1054;
import '../features/emdad_vehicle/domain/use_cases/get_emdad_vehicle_by_id_use_case.dart'
    as _i263;
import '../features/emdad_vehicle/domain/use_cases/get_emdad_vehicle_list_use_case.dart'
    as _i943;
import '../features/emdad_vehicle/domain/use_cases/get_imei_list_use_case.dart'
    as _i341;
import '../features/emdad_vehicle/domain/use_cases/get_vehicle_defects_use_case.dart'
    as _i438;
import '../features/emdad_vehicle/domain/use_cases/get_vehicle_history_use_case.dart'
    as _i871;
import '../features/emdad_vehicle/domain/use_cases/get_vehicle_services_use_case.dart'
    as _i657;
import '../features/emdad_vehicle/domain/use_cases/get_vehicle_tools_use_case.dart'
    as _i1019;
import '../features/emdad_vehicle/domain/use_cases/submit_vehicle_defect_limitation_use_case.dart'
    as _i1026;
import '../features/emdad_vehicle/domain/use_cases/submit_vehicle_services_use_case.dart'
    as _i516;
import '../features/emdad_vehicle/domain/use_cases/submit_vehicle_tools_use_case.dart'
    as _i336;
import '../features/emdad_vehicle/domain/use_cases/update_emdad_vehicle_use_case.dart'
    as _i558;
import '../features/emdad_vehicle/presentation/cubit/emdad_vehicle_cubit.dart'
    as _i1071;
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
import '../features/evaluation/domain/usecase/get_home_service_package_list_use_case.dart'
    as _i392;
import '../features/evaluation/domain/usecase/get_labor_list_use_case.dart'
    as _i915;
import '../features/evaluation/domain/usecase/get_last_evaluation_use_case.dart'
    as _i476;
import '../features/evaluation/domain/usecase/get_part_list_use_case.dart'
    as _i361;
import '../features/evaluation/domain/usecase/get_part_mark_list_use_case.dart'
    as _i655;
import '../features/evaluation/domain/usecase/get_part_price_list_use_case.dart'
    as _i923;
import '../features/evaluation/domain/usecase/get_representation_list_use_case.dart'
    as _i229;
import '../features/evaluation/domain/usecase/get_service_detail_evaluation_use_case.dart'
    as _i16;
import '../features/evaluation/domain/usecase/post_evaluation_use_case.dart'
    as _i296;
import '../features/evaluation/domain/usecase/submit_evaluation_for_aid_service_use_case.dart'
    as _i571;
import '../features/general_content/data/data_source/general_content_data_source.dart'
    as _i557;
import '../features/general_content/data/data_source/general_content_data_source_impl.dart'
    as _i825;
import '../features/general_content/data/repository/general_content_repository_impl.dart'
    as _i226;
import '../features/general_content/data/service/general_content_service.dart'
    as _i881;
import '../features/general_content/domain/repository/general_content_repository.dart'
    as _i783;
import '../features/general_content/domain/usecases/add_general_content_target_use_case.dart'
    as _i392;
import '../features/general_content/domain/usecases/add_general_content_use_case.dart'
    as _i180;
import '../features/general_content/domain/usecases/delete_general_content_use_case.dart'
    as _i311;
import '../features/general_content/domain/usecases/get_general_content_list_use_case.dart'
    as _i564;
import '../features/general_content/domain/usecases/get_general_content_targets_use_case.dart'
    as _i233;
import '../features/general_content/domain/usecases/update_general_content_use_case.dart'
    as _i266;
import '../features/general_content/presentation/cubit/general_content_cubit.dart'
    as _i228;
import '../features/grade_pattern/data/data_sources/grade_pattern_data_source.dart'
    as _i480;
import '../features/grade_pattern/data/data_sources/grade_pattern_data_source_impl.dart'
    as _i88;
import '../features/grade_pattern/data/repositories/grade_pattern_repository_impl.dart'
    as _i864;
import '../features/grade_pattern/data/services/grade_pattern_service.dart'
    as _i300;
import '../features/grade_pattern/domain/repositories/grade_pattern_repository.dart'
    as _i577;
import '../features/grade_pattern/domain/use_cases/assign_grade_pattern_reference_use_case.dart'
    as _i825;
import '../features/grade_pattern/domain/use_cases/create_grade_pattern_use_case.dart'
    as _i833;
import '../features/grade_pattern/domain/use_cases/delete_grade_pattern_reference_use_case.dart'
    as _i33;
import '../features/grade_pattern/domain/use_cases/delete_grade_pattern_use_case.dart'
    as _i512;
import '../features/grade_pattern/domain/use_cases/get_grade_pattern_by_id_use_case.dart'
    as _i33;
import '../features/grade_pattern/domain/use_cases/get_grade_pattern_list_use_case.dart'
    as _i614;
import '../features/grade_pattern/domain/use_cases/get_grade_pattern_references_use_case.dart'
    as _i102;
import '../features/grade_pattern/domain/use_cases/update_grade_pattern_use_case.dart'
    as _i244;
import '../features/grade_pattern/domain/use_cases/validate_grade_pattern_use_case.dart'
    as _i928;
import '../features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart'
    as _i791;
import '../features/home_services_evaluation/data/data_source/home_service_evaluation_data_source.dart'
    as _i999;
import '../features/home_services_evaluation/data/data_source/home_service_evaluation_data_source_impl.dart'
    as _i983;
import '../features/home_services_evaluation/data/repository/home_service_evaluation_repository_impl.dart'
    as _i1063;
import '../features/home_services_evaluation/data/service/home_service_evaluation_service.dart'
    as _i204;
import '../features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart'
    as _i347;
import '../features/home_services_evaluation/domain/usecase/fetch_insert_home_service_category_use_case.dart'
    as _i178;
import '../features/home_services_evaluation/domain/usecase/fetch_insert_home_service_package_use_case.dart'
    as _i1004;
import '../features/home_services_evaluation/domain/usecase/fetch_insert_home_service_service_use_case.dart'
    as _i780;
import '../features/home_services_evaluation/domain/usecase/fetch_kilometer_from_image_use_case.dart'
    as _i1042;
import '../features/home_services_evaluation/domain/usecase/fetch_ocr_configuration_use_case.dart'
    as _i931;
import '../features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart'
    as _i226;
import '../features/home_services_evaluation/domain/usecase/get_distance_to_customer_home_service_usecase.dart'
    as _i1026;
import '../features/home_services_evaluation/domain/usecase/get_home_service_package_use_case.dart'
    as _i1015;
import '../features/home_services_evaluation/domain/usecase/get_labor_usecase.dart'
    as _i902;
import '../features/home_services_evaluation/domain/usecase/get_last_evaluation_home_service_usecase.dart'
    as _i1059;
import '../features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart'
    as _i535;
import '../features/home_services_evaluation/domain/usecase/get_part_mark_usecase.dart'
    as _i664;
import '../features/home_services_evaluation/domain/usecase/get_part_price_usecase.dart'
    as _i983;
import '../features/home_services_evaluation/domain/usecase/get_part_usecase.dart'
    as _i990;
import '../features/home_services_evaluation/domain/usecase/get_reusable_price_usecase.dart'
    as _i91;
import '../features/home_services_evaluation/domain/usecase/get_service_categories_usecase.dart'
    as _i915;
import '../features/home_services_evaluation/domain/usecase/get_services_usecase.dart'
    as _i978;
import '../features/home_services_evaluation/domain/usecase/post_evaluation_accept_usecase.dart'
    as _i626;
import '../features/home_services_evaluation/domain/usecase/post_evaluation_usecase.dart'
    as _i684;
import '../features/home_services_evaluation/domain/usecase/set_active_service_request_usecase.dart'
    as _i497;
import '../features/home_services_evaluation/domain/usecase/set_last_evaluation_usecase.dart'
    as _i570;
import '../features/home_services_evaluation/presentation/evaluation_draft.dart'
    as _i823;
import '../features/home_services_evaluation/presentation/evaluation_invoice_page/cubit/evaluation_invoice_cubit.dart'
    as _i510;
import '../features/home_services_evaluation/presentation/home_service_evaluation_first_step/cubit/home_service_evaluation_first_step_cubit.dart'
    as _i317;
import '../features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart'
    as _i337;
import '../features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart'
    as _i648;
import '../features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart'
    as _i551;
import '../features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart'
    as _i664;
import '../features/home_services_evaluation/presentation/service_list/cubit/service_list_cubit.dart'
    as _i379;
import '../features/imei/data/data_source/imei_data_source.dart' as _i1065;
import '../features/imei/data/data_source/imei_data_source_impl.dart' as _i572;
import '../features/imei/data/repository/imei_repository_impl.dart' as _i311;
import '../features/imei/data/service/imei_service.dart' as _i587;
import '../features/imei/domain/repository/imei_repository.dart' as _i14;
import '../features/imei/domain/usecases/add_imei_info_use_case.dart' as _i357;
import '../features/imei/domain/usecases/delete_imei_info_use_case.dart'
    as _i911;
import '../features/imei/domain/usecases/get_device_info_list_use_case.dart'
    as _i277;
import '../features/imei/domain/usecases/get_imei_info_by_id_use_case.dart'
    as _i1055;
import '../features/imei/domain/usecases/get_imei_info_list_use_case.dart'
    as _i518;
import '../features/imei/domain/usecases/update_imei_info_use_case.dart'
    as _i859;
import '../features/imei/presentation/cubit/imei_cubit.dart' as _i70;
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
import '../features/invoice_management/data/agency_invoice_objections/data_sources/invoice_agency_objection_data_source.dart'
    as _i1001;
import '../features/invoice_management/data/agency_invoice_objections/data_sources/invoice_agency_objection_data_source_impl.dart'
    as _i268;
import '../features/invoice_management/data/agency_invoice_objections/repositories/invoice_agency_objection_repository_impl.dart'
    as _i720;
import '../features/invoice_management/data/agency_invoice_objections/services/invoice_agency_objection_service.dart'
    as _i640;
import '../features/invoice_management/data/common/data_sources/invoice_common_data_source.dart'
    as _i424;
import '../features/invoice_management/data/common/data_sources/invoice_common_data_source_impl.dart'
    as _i623;
import '../features/invoice_management/data/common/repositories/invoice_common_repository_impl.dart'
    as _i377;
import '../features/invoice_management/data/common/services/invoice_common_service.dart'
    as _i854;
import '../features/invoice_management/data/customer_invoices/data_sources/customer_invoice_data_source.dart'
    as _i49;
import '../features/invoice_management/data/customer_invoices/data_sources/customer_invoice_data_source_impl.dart'
    as _i499;
import '../features/invoice_management/data/customer_invoices/repositories/customer_invoice_repository_impl.dart'
    as _i604;
import '../features/invoice_management/data/customer_invoices/services/customer_invoice_service.dart'
    as _i1058;
import '../features/invoice_management/data/emdadgar_invoices/data_sources/emdadgar_invoice_data_source.dart'
    as _i403;
import '../features/invoice_management/data/emdadgar_invoices/data_sources/emdadgar_invoice_data_source_impl.dart'
    as _i218;
import '../features/invoice_management/data/emdadgar_invoices/repositories/emdadgar_invoice_repository_impl.dart'
    as _i1019;
import '../features/invoice_management/data/emdadgar_invoices/services/emdadgar_invoice_service.dart'
    as _i503;
import '../features/invoice_management/domain/agency_invoice_objections/repositories/invoice_agency_objection_repository.dart'
    as _i1047;
import '../features/invoice_management/domain/agency_invoice_objections/use_cases/get_emdadgar_by_service_request_use_case.dart'
    as _i842;
import '../features/invoice_management/domain/agency_invoice_objections/use_cases/get_invoice_agency_objection_use_case.dart'
    as _i138;
import '../features/invoice_management/domain/agency_invoice_objections/use_cases/get_invoice_agency_objections_use_case.dart'
    as _i548;
import '../features/invoice_management/domain/agency_invoice_objections/use_cases/get_service_request_compact_use_case.dart'
    as _i278;
import '../features/invoice_management/domain/agency_invoice_objections/use_cases/get_service_request_operation_access_use_case.dart'
    as _i1009;
import '../features/invoice_management/domain/common/repositories/invoice_common_repository.dart'
    as _i1012;
import '../features/invoice_management/domain/common/use_cases/get_customer_invoice_document_urls_use_case.dart'
    as _i129;
import '../features/invoice_management/domain/common/use_cases/get_emdad_categories_use_case.dart'
    as _i700;
import '../features/invoice_management/domain/common/use_cases/get_emdadgar_invoice_document_urls_use_case.dart'
    as _i865;
import '../features/invoice_management/domain/common/use_cases/get_invoice_operation_access_use_case.dart'
    as _i866;
import '../features/invoice_management/domain/customer_invoices/repositories/customer_invoice_repository.dart'
    as _i332;
import '../features/invoice_management/domain/customer_invoices/use_cases/finalize_customer_invoice_use_case.dart'
    as _i74;
import '../features/invoice_management/domain/customer_invoices/use_cases/get_customer_invoice_details_use_case.dart'
    as _i245;
import '../features/invoice_management/domain/customer_invoices/use_cases/get_customer_invoices_use_case.dart'
    as _i61;
import '../features/invoice_management/domain/customer_invoices/use_cases/get_customer_pre_invoices_use_case.dart'
    as _i138;
import '../features/invoice_management/domain/emdadgar_invoices/repositories/emdadgar_invoice_repository.dart'
    as _i840;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/accept_emdadgar_invoices_use_case.dart'
    as _i729;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/accept_initial_emdadgar_invoices_use_case.dart'
    as _i952;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/get_definite_emdadgar_invoices_use_case.dart'
    as _i322;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/get_emdadgar_invoices_use_case.dart'
    as _i694;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/get_final_approval_emdadgar_invoices_use_case.dart'
    as _i762;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/get_final_correction_emdadgar_invoices_use_case.dart'
    as _i631;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/get_initial_emdadgar_invoice_details_use_case.dart'
    as _i1017;
import '../features/invoice_management/domain/emdadgar_invoices/use_cases/get_initial_emdadgar_invoices_use_case.dart'
    as _i476;
import '../features/invoice_management/presentation/customer_invoices/cubit/customer_invoice_cubit.dart'
    as _i105;
import '../features/invoice_management/presentation/customer_pre_invoices/cubit/customer_pre_invoice_cubit.dart'
    as _i47;
import '../features/invoice_management/presentation/emdadgar_invoices/cubit/emdadgar_invoice_cubit.dart'
    as _i487;
import '../features/leave/data/data_sources/leave_data_source.dart' as _i1017;
import '../features/leave/data/data_sources/leave_data_source_impl.dart'
    as _i336;
import '../features/leave/data/repositories/leave_repository_impl.dart'
    as _i691;
import '../features/leave/data/service/leave_service.dart' as _i233;
import '../features/leave/domain/repositories/leave_repository.dart' as _i217;
import '../features/leave/domain/use_cases/change_leave_status_use_case.dart'
    as _i283;
import '../features/leave/domain/use_cases/delete_leave_request_use_case.dart'
    as _i680;
import '../features/leave/domain/use_cases/get_leave_details_use_case.dart'
    as _i70;
import '../features/leave/domain/use_cases/get_leave_reasons_use_case.dart'
    as _i706;
import '../features/leave/domain/use_cases/get_leave_reports_use_case.dart'
    as _i75;
import '../features/leave/domain/use_cases/rollback_leave_request_use_case.dart'
    as _i918;
import '../features/leave/presentation/cubit/leave_cubit.dart' as _i710;
import '../features/navgan/data/data_source/navgan_data_source.dart' as _i87;
import '../features/navgan/data/data_source/navgan_data_source_impl.dart'
    as _i209;
import '../features/navgan/data/repository/navgan_repository_impl.dart'
    as _i475;
import '../features/navgan/data/service/navgan_service.dart' as _i584;
import '../features/navgan/domain/repository/navgan_repository.dart' as _i1025;
import '../features/navgan/domain/usecases/add_navgan_grade_reference_use_case.dart'
    as _i529;
import '../features/navgan/domain/usecases/delete_navgan_grade_reference_use_case.dart'
    as _i467;
import '../features/navgan/domain/usecases/get_grade_pattern_detail_use_case.dart'
    as _i1031;
import '../features/navgan/domain/usecases/get_grade_pattern_list_use_case.dart'
    as _i745;
import '../features/navgan/domain/usecases/get_grade_pattern_references_use_case.dart'
    as _i958;
import '../features/navgan/domain/usecases/get_navgan_defects_use_case.dart'
    as _i193;
import '../features/navgan/domain/usecases/get_navgan_list_use_case.dart'
    as _i570;
import '../features/navgan/domain/usecases/get_navgan_service_groups_use_case.dart'
    as _i85;
import '../features/navgan/domain/usecases/submit_navgan_defects_use_case.dart'
    as _i71;
import '../features/navgan/domain/usecases/submit_navgan_service_categories_use_case.dart'
    as _i940;
import '../features/navgan/presentation/cubit/navgan_cubit.dart' as _i93;
import '../features/plan_info/data/data_source/plan_info_data_source.dart'
    as _i49;
import '../features/plan_info/data/data_source/plan_info_data_source_impl.dart'
    as _i722;
import '../features/plan_info/data/repository/plan_info_repository_impl.dart'
    as _i185;
import '../features/plan_info/data/service/plan_info_service.dart' as _i131;
import '../features/plan_info/domain/repository/plan_info_repository.dart'
    as _i579;
import '../features/plan_info/domain/usecases/plan_info_usecases.dart' as _i203;
import '../features/plan_info/presentation/cubit/plan_info_cubit.dart' as _i943;
import '../features/representation/data/data_sources/representation_data_source.dart'
    as _i59;
import '../features/representation/data/data_sources/representation_data_source_impl.dart'
    as _i423;
import '../features/representation/data/repositories/representation_repository_impl.dart'
    as _i386;
import '../features/representation/data/service/representation_service.dart'
    as _i854;
import '../features/representation/domain/repositories/representation_repository.dart'
    as _i815;
import '../features/representation/presentation/cubit/representation_cubit.dart'
    as _i79;
import '../features/rescuer/data/data_sources/rescuer_data_source.dart'
    as _i940;
import '../features/rescuer/data/data_sources/rescuer_data_source_impl.dart'
    as _i100;
import '../features/rescuer/data/repositories/rescuer_repository_impl.dart'
    as _i61;
import '../features/rescuer/data/service/rescuer_service.dart' as _i298;
import '../features/rescuer/domain/repositories/rescuer_repository.dart'
    as _i449;
import '../features/rescuer/domain/use_cases/add_rescuer_use_case.dart'
    as _i110;
import '../features/rescuer/domain/use_cases/delete_rescuer_use_case.dart'
    as _i708;
import '../features/rescuer/domain/use_cases/get_rescuer_by_id_use_case.dart'
    as _i14;
import '../features/rescuer/domain/use_cases/get_rescuer_history_use_case.dart'
    as _i339;
import '../features/rescuer/domain/use_cases/get_rescuer_report_use_case.dart'
    as _i118;
import '../features/rescuer/domain/use_cases/get_rescuer_skill_certificates_use_case.dart'
    as _i833;
import '../features/rescuer/domain/use_cases/get_rescuers_use_case.dart'
    as _i557;
import '../features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart'
    as _i21;
import '../features/rescuer/presentation/cubit/detail/rescuer_detail_cubit.dart'
    as _i63;
import '../features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart'
    as _i404;
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
import '../features/services/domain/usecases/get_request_operation_access_use_case.dart'
    as _i385;
import '../features/services/domain/usecases/get_request_status_history_use_case.dart'
    as _i955;
import '../features/services/domain/usecases/service_assign_use_case.dart'
    as _i595;
import '../features/services/domain/usecases/set_selected_request_item_use_case.dart'
    as _i369;
import '../features/services/domain/usecases/update_service_request_use_case.dart'
    as _i180;
import '../features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart'
    as _i860;
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
import '../features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart'
    as _i319;
import '../features/services/presentation/evaluation_history/cubit/evaluation_history_cubit.dart'
    as _i154;
import '../features/services/presentation/evaluation_home_service_request_page/cubit/evaluation_home_service_request_cubit.dart'
    as _i866;
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
import '../features/shift/data/data_sources/shift_data_source.dart' as _i970;
import '../features/shift/data/data_sources/shift_data_source_impl.dart' as _i5;
import '../features/shift/data/repositories/shift_repository_impl.dart'
    as _i520;
import '../features/shift/data/services/shift_service.dart' as _i401;
import '../features/shift/domain/repositories/shift_repository.dart' as _i399;
import '../features/shift/domain/use_cases/create_shift_use_case.dart' as _i904;
import '../features/shift/domain/use_cases/delete_shift_use_case.dart' as _i585;
import '../features/shift/domain/use_cases/get_shift_by_id_use_case.dart'
    as _i76;
import '../features/shift/domain/use_cases/get_shift_list_use_case.dart'
    as _i113;
import '../features/shift/domain/use_cases/update_shift_use_case.dart' as _i25;
import '../features/shift/domain/use_cases/validate_shift_use_case.dart'
    as _i325;
import '../features/shift/presentation/cubit/shift_form_cubit.dart' as _i309;
import '../features/shift/presentation/cubit/shift_list_cubit.dart' as _i727;
import '../features/skills_certificates/data/data_source/skills_certificates_data_source.dart'
    as _i82;
import '../features/skills_certificates/data/data_source/skills_certificates_data_source_impl.dart'
    as _i518;
import '../features/skills_certificates/data/repository/skills_certificates_repository_impl.dart'
    as _i526;
import '../features/skills_certificates/data/service/skills_certificates_service.dart'
    as _i654;
import '../features/skills_certificates/domain/repository/skills_certificates_repository.dart'
    as _i615;
import '../features/skills_certificates/domain/usecases/skills_certificates_usecases.dart'
    as _i974;
import '../features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart'
    as _i751;
import '../features/special_plan/data/data_source/special_plan_data_source.dart'
    as _i407;
import '../features/special_plan/data/data_source/special_plan_data_source_impl.dart'
    as _i206;
import '../features/special_plan/data/repository/special_plan_repository_impl.dart'
    as _i922;
import '../features/special_plan/data/service/special_plan_service.dart'
    as _i626;
import '../features/special_plan/domain/repository/special_plan_repository.dart'
    as _i630;
import '../features/special_plan/domain/usecases/create_special_plan_use_case.dart'
    as _i150;
import '../features/special_plan/domain/usecases/delete_special_plan_use_case.dart'
    as _i723;
import '../features/special_plan/domain/usecases/get_special_plan_list_use_case.dart'
    as _i944;
import '../features/special_plan/domain/usecases/get_special_plan_products_use_case.dart'
    as _i973;
import '../features/special_plan/domain/usecases/update_special_plan_use_case.dart'
    as _i1001;
import '../features/special_plan/presentation/cubit/special_plan_form_cubit.dart'
    as _i162;
import '../features/special_plan/presentation/cubit/special_plan_list_cubit.dart'
    as _i304;
import '../features/special_plan/presentation/cubit/special_plan_report_cubit.dart'
    as _i1055;
import '../features/vehicle_info/data/data_sources/vehicle_info_data_source.dart'
    as _i247;
import '../features/vehicle_info/data/data_sources/vehicle_info_data_source_impl.dart'
    as _i862;
import '../features/vehicle_info/data/repositories/vehicle_info_repository_impl.dart'
    as _i764;
import '../features/vehicle_info/data/services/vehicle_info_service.dart'
    as _i810;
import '../features/vehicle_info/domain/repositories/vehicle_info_repository.dart'
    as _i1027;
import '../features/vehicle_info/domain/use_cases/vehicle_info_use_cases.dart'
    as _i579;
import '../features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart'
    as _i772;
import '../features/vehicle_model/data/data_source/vehicle_model_data_source.dart'
    as _i802;
import '../features/vehicle_model/data/data_source/vehicle_model_data_source_impl.dart'
    as _i602;
import '../features/vehicle_model/data/repository/vehicle_model_repository_impl.dart'
    as _i13;
import '../features/vehicle_model/data/service/vehicle_model_service.dart'
    as _i386;
import '../features/vehicle_model/domain/repository/vehicle_model_repository.dart'
    as _i913;
import '../features/vehicle_model/domain/usecases/add_vehicle_model_use_case.dart'
    as _i1038;
import '../features/vehicle_model/domain/usecases/delete_vehicle_model_use_case.dart'
    as _i325;
import '../features/vehicle_model/domain/usecases/get_vehicle_defects_use_case.dart'
    as _i820;
import '../features/vehicle_model/domain/usecases/get_vehicle_model_list_use_case.dart'
    as _i961;
import '../features/vehicle_model/domain/usecases/get_vehicle_navgan_list_use_case.dart'
    as _i8;
import '../features/vehicle_model/domain/usecases/get_vehicle_service_groups_use_case.dart'
    as _i487;
import '../features/vehicle_model/domain/usecases/submit_vehicle_defects_use_case.dart'
    as _i603;
import '../features/vehicle_model/domain/usecases/submit_vehicle_service_categories_use_case.dart'
    as _i518;
import '../features/vehicle_model/domain/usecases/update_vehicle_model_use_case.dart'
    as _i562;
import '../features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart'
    as _i360;
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
import '../shared/excel_export/data/repository/excel_export_repository_impl.dart'
    as _i931;
import '../shared/excel_export/data/service/excel_export_service.dart' as _i384;
import '../shared/excel_export/data/service/excel_workbook_builder.dart'
    as _i255;
import '../shared/excel_export/data/service/excel_workbook_builder_module.dart'
    as _i166;
import '../shared/excel_export/domain/repository/excel_export_repository.dart'
    as _i925;
import '../shared/excel_export/domain/usecase/export_excel_use_case.dart'
    as _i470;
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
import '../shared/features/map/data/service/map_lookup_service.dart' as _i275;
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
import '../shared/features/map/domain/usecase/get_discountable_areas_use_case.dart'
    as _i981;
import '../shared/features/map/domain/usecase/get_location_data_use_case.dart'
    as _i850;
import '../shared/features/map/domain/usecase/get_province_lookup_list_use_case.dart'
    as _i1015;
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
import '../shared/features/session/domain/manager/current_session_manager.dart'
    as _i1058;
import '../shared/features/session/domain/manager/current_session_memory_manager.dart'
    as _i950;
import '../shared/features/session/domain/use_cases/sync_current_session_use_case.dart'
    as _i695;
import '../shared/features/upload_file/data/data_sources/upload_file_data_source.dart'
    as _i445;
import '../shared/features/upload_file/data/data_sources/upload_file_data_source_impl.dart'
    as _i563;
import '../shared/features/upload_file/data/repositories/upload_file_repository_impl.dart'
    as _i988;
import '../shared/features/upload_file/domain/repositories/upload_file_repository.dart'
    as _i436;
import '../shared/features/upload_file/domain/use_cases/pick_upload_file_use_case.dart'
    as _i515;
import '../shared/features/upload_file/presentation/cubit/upload_file_cubit.dart'
    as _i683;
import '../shared/features/user/data/data_source/user_data_source.dart'
    as _i1039;
import '../shared/features/user/data/data_source/user_data_source_impl.dart'
    as _i793;
import '../shared/features/user/data/repository/user_repository_impl.dart'
    as _i880;
import '../shared/features/user/data/service/user_service.dart' as _i313;
import '../shared/features/user/domain/repository/user_repository.dart' as _i74;
import '../shared/features/user/domain/use_case/logout_use_case.dart' as _i138;
import '../shared/theme/cubit/theme_cubit.dart' as _i190;
import '../shared/usecase/user_use_case/get_theme_usecase.dart' as _i274;
import '../shared/usecase/user_use_case/set_theme_usecase.dart' as _i776;
import '../shared/usecase/user_use_case/update_user_usecase.dart' as _i994;
import 'app_module.dart' as _i460;
import 'sliding_panel_module.dart' as _i997;

const String _mobile = 'mobile';
const String _web = 'web';

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
  final excelWorkbookBuilderModule = _$ExcelWorkbookBuilderModule();
  gh.factory<_i336.BottomNavigationBarCubit>(
    () => _i336.BottomNavigationBarCubit(),
  );
  gh.factory<_i1071.EmdadVehicleCubit>(() => _i1071.EmdadVehicleCubit());
  gh.factory<_i79.RepresentationCubit>(() => _i79.RepresentationCubit());
  gh.factory<_i866.EvaluationHomeServiceRequestCubit>(
    () => _i866.EvaluationHomeServiceRequestCubit(),
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
  gh.lazySingleton<_i928.ValidateGradePatternUseCase>(
    () => _i928.ValidateGradePatternUseCase(),
  );
  gh.lazySingleton<_i823.EvaluationDraftStore>(
    () => _i823.EvaluationDraftStore(),
  );
  gh.lazySingleton<_i325.ValidateShiftUseCase>(
    () => _i325.ValidateShiftUseCase(),
  );
  gh.lazySingleton<_i384.ExcelExportService>(() => _i384.ExcelExportService());
  gh.lazySingleton<_i255.ExcelWorkbookBuilder>(
    () => excelWorkbookBuilderModule.builder,
  );
  gh.lazySingleton<_i838.RequestRepositoryShareData>(
    () => _i318.RequestRepositoryShareDataImpl(),
  );
  gh.lazySingleton<_i445.UploadFileDataSource>(
    () => _i563.UploadFileDataSourceImpl(),
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
  gh.lazySingleton<_i1058.CurrentSessionManager>(
    () => _i950.CurrentSessionMemoryManager(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i988.ILocationDeviceService>(
    () => _i988.LocationDeviceService(),
  );
  gh.lazySingleton<_i925.ExcelExportRepository>(
    () => _i931.ExcelExportRepositoryImpl(gh<_i255.ExcelWorkbookBuilder>()),
  );
  gh.lazySingleton<_i308.SessionStorage>(
    () => _i577.SessionStorageMobileImpl(),
    registerFor: {_mobile},
  );
  gh.lazySingleton<_i988.IPermissionDeviceService>(
    () => _i988.PermissionDeviceService(),
  );
  gh.lazySingleton<_i436.UploadFileRepository>(
    () => _i988.UploadFileRepositoryImpl(gh<_i445.UploadFileDataSource>()),
  );
  gh.lazySingleton<_i221.LocationPermissionDataSource>(
    () => _i1040.LocationPermissionDataSourceImpl(
      gh<_i988.ILocationDeviceService>(),
      gh<_i988.IPermissionDeviceService>(),
    ),
  );
  gh.lazySingleton<_i470.ExportExcelUseCase>(
    () => _i470.ExportExcelUseCase(gh<_i925.ExcelExportRepository>()),
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
  gh.lazySingleton<_i1027.CartableService>(
    () => _i1027.CartableService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i953.DashboardService>(
    () => _i953.DashboardService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i2.EmdadVehicleService>(
    () => _i2.EmdadVehicleService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i606.EvaluationService>(
    () => _i606.EvaluationService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i204.HomeServiceEvaluationService>(
    () => _i204.HomeServiceEvaluationService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i140.IndicatorReportService>(
    () => _i140.IndicatorReportService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i233.LeaveService>(
    () => _i233.LeaveService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i854.RepresentationService>(
    () => _i854.RepresentationService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i483.RequestService>(
    () => _i483.RequestService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i401.ShiftService>(
    () => _i401.ShiftService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i654.SkillsCertificatesService>(
    () => _i654.SkillsCertificatesService(gh<_i361.Dio>()),
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
  gh.lazySingleton<_i427.AgencyInfoService>(
    () => _i427.AgencyInfoService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i1053.ProfileService>(
    () => _i1053.ProfileService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i86.DeploymentLocationService>(
    () => _i86.DeploymentLocationService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i54.EmdadUnitService>(
    () => _i54.EmdadUnitService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i881.GeneralContentService>(
    () => _i881.GeneralContentService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i300.GradePatternService>(
    () => _i300.GradePatternService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i587.ImeiService>(() => _i587.ImeiService(gh<_i361.Dio>()));
  gh.lazySingleton<_i640.InvoiceAgencyObjectionService>(
    () => _i640.InvoiceAgencyObjectionService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i854.InvoiceCommonService>(
    () => _i854.InvoiceCommonService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i1058.CustomerInvoiceService>(
    () => _i1058.CustomerInvoiceService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i503.EmdadgarInvoiceService>(
    () => _i503.EmdadgarInvoiceService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i584.NavganService>(
    () => _i584.NavganService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i131.PlanInfoService>(
    () => _i131.PlanInfoService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i298.RescuerService>(
    () => _i298.RescuerService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i626.SpecialPlanService>(
    () => _i626.SpecialPlanService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i810.VehicleInfoService>(
    () => _i810.VehicleInfoService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i386.VehicleModelService>(
    () => _i386.VehicleModelService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i275.MapLookupService>(
    () => _i275.MapLookupService(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i515.PickUploadFileUseCase>(
    () => _i515.PickUploadFileUseCase(gh<_i436.UploadFileRepository>()),
  );
  gh.lazySingleton<_i403.EmdadgarInvoiceDataSource>(
    () =>
        _i218.EmdadgarInvoiceDataSourceImpl(gh<_i503.EmdadgarInvoiceService>()),
  );
  gh.lazySingleton<_i691.IndicatorReportDataSource>(
    () =>
        _i87.IndicatorReportDataSourceImpl(gh<_i140.IndicatorReportService>()),
  );
  gh.lazySingleton<_i930.EmdadUnitDataSource>(
    () => _i539.EmdadUnitDataSourceImpl(gh<_i54.EmdadUnitService>()),
  );
  gh.lazySingleton<_i320.DashboardDataSource>(
    () => _i822.DashboardDataSourceImpl(gh<_i953.DashboardService>()),
  );
  gh.lazySingleton<_i227.IndicatorReportRepository>(
    () => _i282.IndicatorReportRepositoryImpl(
      gh<_i691.IndicatorReportDataSource>(),
    ),
  );
  gh.lazySingleton<_i557.GeneralContentDataSource>(
    () => _i825.GeneralContentDataSourceImpl(gh<_i881.GeneralContentService>()),
  );
  gh.lazySingleton<_i940.RescuerDataSource>(
    () => _i100.RescuerDataSourceImpl(gh<_i298.RescuerService>()),
  );
  gh.lazySingleton<_i475.MainRemoteDataSource>(
    () => _i203.MainRemoteDataSourceImpl(gh<_i438.MainService>()),
  );
  gh.lazySingleton<_i971.MapDataSource>(
    () => _i583.MapDataSourceImpl(
      gh<_i929.MapService>(),
      gh<_i1036.AddressService>(),
      gh<_i275.MapLookupService>(),
    ),
  );
  gh.lazySingleton<_i854.MainRepository>(
    () => _i320.MainRepositoryImpl(gh<_i475.MainRemoteDataSource>()),
  );
  gh.lazySingleton<_i480.GradePatternDataSource>(
    () => _i88.GradePatternDataSourceImpl(gh<_i300.GradePatternService>()),
  );
  gh.lazySingleton<_i247.VehicleInfoDataSource>(
    () => _i862.VehicleInfoDataSourceImpl(gh<_i810.VehicleInfoService>()),
  );
  gh.lazySingleton<_i602.DashboardRepository>(
    () => _i650.DashboardRepositoryImpl(gh<_i320.DashboardDataSource>()),
  );
  gh.lazySingleton<_i249.CartableDataSource>(
    () => _i18.CartableDataSourceImpl(gh<_i1027.CartableService>()),
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
  gh.lazySingleton<_i802.VehicleModelDataSource>(
    () => _i602.VehicleModelDataSourceImpl(gh<_i386.VehicleModelService>()),
  );
  gh.lazySingleton<_i59.RepresentationDataSource>(
    () => _i423.RepresentationDataSourceImpl(gh<_i854.RepresentationService>()),
  );
  gh.lazySingleton<_i49.PlanInfoDataSource>(
    () => _i722.PlanInfoDataSourceImpl(gh<_i131.PlanInfoService>()),
  );
  gh.lazySingleton<_i532.ProfileRemoteDataSource>(
    () => _i224.ProfileRemoteDataSourceImpl(gh<_i1053.ProfileService>()),
  );
  gh.lazySingleton<_i670.DateTimeInfoDataSource>(
    () => _i940.DateTimeInfoDataSourceImpl(gh<_i99.DateTimeService>()),
  );
  gh.lazySingleton<_i407.SpecialPlanDataSource>(
    () => _i206.SpecialPlanDataSourceImpl(gh<_i626.SpecialPlanService>()),
  );
  gh.lazySingleton<_i82.SkillsCertificatesDataSource>(
    () => _i518.SkillsCertificatesDataSourceImpl(
      gh<_i654.SkillsCertificatesService>(),
    ),
  );
  gh.lazySingleton<_i123.AgencyInfoDataSource>(
    () => _i392.AgencyInfoDataSourceImpl(gh<_i427.AgencyInfoService>()),
  );
  gh.lazySingleton<_i49.CustomerInvoiceDataSource>(
    () => _i499.CustomerInvoiceDataSourceImpl(
      gh<_i1058.CustomerInvoiceService>(),
    ),
  );
  gh.lazySingleton<_i375.FetchIndicatorReportUseCase>(
    () => _i375.FetchIndicatorReportUseCase(
      gh<_i227.IndicatorReportRepository>(),
    ),
  );
  gh.lazySingleton<_i557.DeploymentLocationDataSource>(
    () => _i584.DeploymentLocationDataSourceImpl(
      gh<_i86.DeploymentLocationService>(),
    ),
  );
  gh.lazySingleton<_i999.HomeServiceEvaluationDataSource>(
    () => _i983.HomeServiceEvaluationDataSourceImpl(
      gh<_i204.HomeServiceEvaluationService>(),
    ),
  );
  gh.lazySingleton<_i133.CartableRepository>(
    () => _i304.CartableRepositoryImpl(gh<_i249.CartableDataSource>()),
  );
  gh.lazySingleton<_i449.RescuerRepository>(
    () => _i61.RescuerRepositoryImpl(gh<_i940.RescuerDataSource>()),
  );
  gh.lazySingleton<_i92.MapRepository>(
    () => _i810.MapRepositoryImpl(gh<_i971.MapDataSource>()),
  );
  gh.lazySingleton<_i577.GradePatternRepository>(
    () => _i864.GradePatternRepositoryImpl(gh<_i480.GradePatternDataSource>()),
  );
  gh.lazySingleton<_i373.ProfileRepository>(
    () => _i1015.ProfileRepositoryImpl(gh<_i532.ProfileRemoteDataSource>()),
  );
  gh.lazySingleton<_i565.UrgentRequestUseCase>(
    () => _i565.UrgentRequestUseCase(gh<_i854.MainRepository>()),
  );
  gh.factory<_i683.UploadFileCubit>(
    () => _i683.UploadFileCubit(gh<_i515.PickUploadFileUseCase>()),
  );
  gh.lazySingleton<_i970.ShiftDataSource>(
    () => _i5.ShiftDataSourceImpl(gh<_i401.ShiftService>()),
  );
  gh.lazySingleton<_i233.AgencyInfoRepository>(
    () => _i29.AgencyInfoRepositoryImpl(gh<_i123.AgencyInfoDataSource>()),
  );
  gh.lazySingleton<_i1016.RequestDataSource>(
    () => _i576.RequestDataSourceImpl(gh<_i483.RequestService>()),
  );
  gh.lazySingleton<_i1023.EvaluationRemoteDataSource>(
    () => _i832.FinalizeInvoiceRemoteDataSourceImpl(
      gh<_i606.EvaluationService>(),
    ),
  );
  gh.lazySingleton<_i639.EmdadVehicleDataSource>(
    () => _i808.EmdadVehicleDataSourceImpl(gh<_i2.EmdadVehicleService>()),
  );
  gh.lazySingleton<_i479.AuthRemoteDataSource>(
    () => _i51.AuthRemoteDataSourceImpl(gh<_i626.AuthService>()),
  );
  gh.lazySingleton<_i829.InvoiceRepository>(
    () => _i161.InvoiceRepositoryImpl(gh<_i935.InvoiceDataSource>()),
  );
  gh.lazySingleton<_i14.EmdadUnitRepository>(
    () => _i79.EmdadUnitRepositoryImpl(gh<_i930.EmdadUnitDataSource>()),
  );
  gh.lazySingleton<_i579.PlanInfoRepository>(
    () => _i185.PlanInfoRepositoryImpl(gh<_i49.PlanInfoDataSource>()),
  );
  gh.lazySingleton<_i1039.UserDataSource>(
    () => _i793.UserDataSourceImpl(gh<_i313.UserService>()),
  );
  gh.lazySingleton<_i1065.ImeiDataSource>(
    () => _i572.ImeiDataSourceImpl(gh<_i587.ImeiService>()),
  );
  gh.lazySingleton<_i913.VehicleModelRepository>(
    () => _i13.VehicleModelRepositoryImpl(gh<_i802.VehicleModelDataSource>()),
  );
  gh.lazySingleton<_i603.RequestRepository>(
    () => _i794.RequestRepositoryImpl(gh<_i1016.RequestDataSource>()),
  );
  gh.lazySingleton<_i424.InvoiceCommonDataSource>(
    () => _i623.InvoiceCommonDataSourceImpl(gh<_i854.InvoiceCommonService>()),
  );
  gh.lazySingleton<_i1017.LeaveDataSource>(
    () => _i336.LeaveDataSourceImpl(gh<_i233.LeaveService>()),
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
  gh.lazySingleton<_i840.EmdadgarInvoiceRepository>(
    () => _i1019.EmdadgarInvoiceRepositoryImpl(
      gh<_i403.EmdadgarInvoiceDataSource>(),
    ),
  );
  gh.lazySingleton<_i6.DeploymentLocationRepository>(
    () => _i879.DeploymentLocationRepositoryImpl(
      gh<_i557.DeploymentLocationDataSource>(),
    ),
  );
  gh.lazySingleton<_i399.ShiftRepository>(
    () => _i520.ShiftRepositoryImpl(gh<_i970.ShiftDataSource>()),
  );
  gh.lazySingleton<_i783.GeneralContentRepository>(
    () => _i226.GeneralContentRepositoryImpl(
      gh<_i557.GeneralContentDataSource>(),
    ),
  );
  gh.lazySingleton<_i87.NavganDataSource>(
    () => _i209.NavganDataSourceImpl(gh<_i584.NavganService>()),
  );
  gh.lazySingleton<_i347.HomeServiceEvaluationRepository>(
    () => _i1063.HomeServiceEvaluationRepositoryImpl(
      gh<_i999.HomeServiceEvaluationDataSource>(),
    ),
  );
  gh.lazySingleton<_i1001.InvoiceAgencyObjectionDataSource>(
    () => _i268.InvoiceAgencyObjectionDataSourceImpl(
      gh<_i640.InvoiceAgencyObjectionService>(),
    ),
  );
  gh.factory<_i110.AddRescuerUseCase>(
    () => _i110.AddRescuerUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.factory<_i708.DeleteRescuerUseCase>(
    () => _i708.DeleteRescuerUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.factory<_i14.GetRescuerByIdUseCase>(
    () => _i14.GetRescuerByIdUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.factory<_i339.GetRescuerHistoryUseCase>(
    () => _i339.GetRescuerHistoryUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.factory<_i118.GetRescuerReportUseCase>(
    () => _i118.GetRescuerReportUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.factory<_i833.GetRescuerSkillCertificatesUseCase>(
    () =>
        _i833.GetRescuerSkillCertificatesUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.factory<_i557.GetRescuersUseCase>(
    () => _i557.GetRescuersUseCase(gh<_i449.RescuerRepository>()),
  );
  gh.lazySingleton<_i392.AddGeneralContentTargetUseCase>(
    () => _i392.AddGeneralContentTargetUseCase(
      gh<_i783.GeneralContentRepository>(),
    ),
  );
  gh.lazySingleton<_i180.AddGeneralContentUseCase>(
    () => _i180.AddGeneralContentUseCase(gh<_i783.GeneralContentRepository>()),
  );
  gh.lazySingleton<_i311.DeleteGeneralContentUseCase>(
    () =>
        _i311.DeleteGeneralContentUseCase(gh<_i783.GeneralContentRepository>()),
  );
  gh.lazySingleton<_i564.GetGeneralContentListUseCase>(
    () => _i564.GetGeneralContentListUseCase(
      gh<_i783.GeneralContentRepository>(),
    ),
  );
  gh.lazySingleton<_i233.GetGeneralContentTargetsUseCase>(
    () => _i233.GetGeneralContentTargetsUseCase(
      gh<_i783.GeneralContentRepository>(),
    ),
  );
  gh.lazySingleton<_i266.UpdateGeneralContentUseCase>(
    () =>
        _i266.UpdateGeneralContentUseCase(gh<_i783.GeneralContentRepository>()),
  );
  gh.lazySingleton<_i904.CreateShiftUseCase>(
    () => _i904.CreateShiftUseCase(gh<_i399.ShiftRepository>()),
  );
  gh.lazySingleton<_i585.DeleteShiftUseCase>(
    () => _i585.DeleteShiftUseCase(gh<_i399.ShiftRepository>()),
  );
  gh.lazySingleton<_i76.GetShiftByIdUseCase>(
    () => _i76.GetShiftByIdUseCase(gh<_i399.ShiftRepository>()),
  );
  gh.lazySingleton<_i113.GetShiftListUseCase>(
    () => _i113.GetShiftListUseCase(gh<_i399.ShiftRepository>()),
  );
  gh.lazySingleton<_i25.UpdateShiftUseCase>(
    () => _i25.UpdateShiftUseCase(gh<_i399.ShiftRepository>()),
  );
  gh.lazySingleton<_i615.SkillsCertificatesRepository>(
    () => _i526.SkillsCertificatesRepositoryImpl(
      gh<_i82.SkillsCertificatesDataSource>(),
    ),
  );
  gh.lazySingleton<_i550.CreateDeploymentLocationUseCase>(
    () => _i550.CreateDeploymentLocationUseCase(
      gh<_i6.DeploymentLocationRepository>(),
    ),
  );
  gh.lazySingleton<_i950.DeleteDeploymentLocationUseCase>(
    () => _i950.DeleteDeploymentLocationUseCase(
      gh<_i6.DeploymentLocationRepository>(),
    ),
  );
  gh.lazySingleton<_i510.GetDeploymentLocationByIdUseCase>(
    () => _i510.GetDeploymentLocationByIdUseCase(
      gh<_i6.DeploymentLocationRepository>(),
    ),
  );
  gh.lazySingleton<_i916.GetDeploymentLocationListUseCase>(
    () => _i916.GetDeploymentLocationListUseCase(
      gh<_i6.DeploymentLocationRepository>(),
    ),
  );
  gh.lazySingleton<_i676.UpdateDeploymentLocationUseCase>(
    () => _i676.UpdateDeploymentLocationUseCase(
      gh<_i6.DeploymentLocationRepository>(),
    ),
  );
  gh.factory<_i125.AssignEmdadUnitPersonUseCase>(
    () => _i125.AssignEmdadUnitPersonUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i343.ChangeEmdadUnitLocationUseCase>(
    () => _i343.ChangeEmdadUnitLocationUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i930.CreateEmdadUnitUseCase>(
    () => _i930.CreateEmdadUnitUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i132.DeleteEmdadUnitPersonUseCase>(
    () => _i132.DeleteEmdadUnitPersonUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i831.DeleteEmdadUnitUseCase>(
    () => _i831.DeleteEmdadUnitUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i928.GetEmdadUnitByIdUseCase>(
    () => _i928.GetEmdadUnitByIdUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i262.GetEmdadUnitListUseCase>(
    () => _i262.GetEmdadUnitListUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i690.GetEmdadUnitLookupsUseCase>(
    () => _i690.GetEmdadUnitLookupsUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i301.GetEmdadUnitPersonsUseCase>(
    () => _i301.GetEmdadUnitPersonsUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.factory<_i76.UpdateEmdadUnitImageUseCase>(
    () => _i76.UpdateEmdadUnitImageUseCase(gh<_i14.EmdadUnitRepository>()),
  );
  gh.lazySingleton<_i471.GetCurrentNetworkStatusUseCase>(
    () => _i471.GetCurrentNetworkStatusUseCase(
      gh<_i422.ObserveNetworkRepository>(),
    ),
  );
  gh.lazySingleton<_i1061.ObserveNetworkUseCase>(
    () => _i1061.ObserveNetworkUseCase(gh<_i422.ObserveNetworkRepository>()),
  );
  gh.factory<_i228.GeneralContentCubit>(
    () => _i228.GeneralContentCubit(
      gh<_i564.GetGeneralContentListUseCase>(),
      gh<_i233.GetGeneralContentTargetsUseCase>(),
      gh<_i180.AddGeneralContentUseCase>(),
      gh<_i266.UpdateGeneralContentUseCase>(),
      gh<_i392.AddGeneralContentTargetUseCase>(),
      gh<_i311.DeleteGeneralContentUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.lazySingleton<_i332.CustomerInvoiceRepository>(
    () => _i604.CustomerInvoiceRepositoryImpl(
      gh<_i49.CustomerInvoiceDataSource>(),
    ),
  );
  gh.lazySingleton<_i815.RepresentationRepository>(
    () =>
        _i386.RepresentationRepositoryImpl(gh<_i59.RepresentationDataSource>()),
  );
  gh.lazySingleton<_i74.UserRepository>(
    () => _i880.UserRepositoryImpl(gh<_i1039.UserDataSource>()),
  );
  gh.lazySingleton<_i489.DateTimeInfoRepository>(
    () => _i258.DateTimeRepositoryImpl(gh<_i670.DateTimeInfoDataSource>()),
  );
  gh.lazySingleton<_i203.GetPlanListUseCase>(
    () => _i203.GetPlanListUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.GetPlanByIdUseCase>(
    () => _i203.GetPlanByIdUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.CreatePlanUseCase>(
    () => _i203.CreatePlanUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.EditPlanUseCase>(
    () => _i203.EditPlanUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.DeletePlanUseCase>(
    () => _i203.DeletePlanUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.GetPlanStatusReasonsUseCase>(
    () => _i203.GetPlanStatusReasonsUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.ChangePlanStatusUseCase>(
    () => _i203.ChangePlanStatusUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.GetPlanReportUseCase>(
    () => _i203.GetPlanReportUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.GetPlanHistoriesUseCase>(
    () => _i203.GetPlanHistoriesUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.CancelPlanRequestsUseCase>(
    () => _i203.CancelPlanRequestsUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.GetPlanLookupsUseCase>(
    () => _i203.GetPlanLookupsUseCase(gh<_i579.PlanInfoRepository>()),
  );
  gh.lazySingleton<_i203.ChangeLocationUseCase>(
    () => _i203.ChangeLocationUseCase(gh<_i579.PlanInfoRepository>()),
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
  gh.lazySingleton<_i981.GetDiscountableAreasUseCase>(
    () => _i981.GetDiscountableAreasUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i850.GetLocationDataUseCase>(
    () => _i850.GetLocationDataUseCase(gh<_i92.MapRepository>()),
  );
  gh.lazySingleton<_i1015.GetProvinceLookupListUseCase>(
    () => _i1015.GetProvinceLookupListUseCase(gh<_i92.MapRepository>()),
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
  gh.lazySingleton<_i385.GetRequestOperationAccessUseCase>(
    () => _i385.GetRequestOperationAccessUseCase(gh<_i603.RequestRepository>()),
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
  gh.lazySingleton<_i1047.InvoiceAgencyObjectionRepository>(
    () => _i720.InvoiceAgencyObjectionRepositoryImpl(
      gh<_i1001.InvoiceAgencyObjectionDataSource>(),
    ),
  );
  gh.lazySingleton<_i845.LogOffUseCase>(
    () => _i845.LogOffUseCase(
      gh<_i373.ProfileRepository>(),
      gh<_i308.SessionStorage>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.lazySingleton<_i630.SpecialPlanRepository>(
    () => _i922.SpecialPlanRepositoryImpl(gh<_i407.SpecialPlanDataSource>()),
  );
  gh.factory<_i63.RescuerDetailCubit>(
    () => _i63.RescuerDetailCubit(
      gh<_i14.GetRescuerByIdUseCase>(),
      gh<_i708.DeleteRescuerUseCase>(),
    ),
  );
  gh.lazySingleton<_i958.ChangePasswordUseCase>(
    () => _i958.ChangePasswordUseCase(gh<_i373.ProfileRepository>()),
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
  gh.factory<_i471.EmdadUnitCubit>(
    () => _i471.EmdadUnitCubit(
      gh<_i262.GetEmdadUnitListUseCase>(),
      gh<_i928.GetEmdadUnitByIdUseCase>(),
      gh<_i930.CreateEmdadUnitUseCase>(),
      gh<_i76.UpdateEmdadUnitImageUseCase>(),
      gh<_i831.DeleteEmdadUnitUseCase>(),
      gh<_i301.GetEmdadUnitPersonsUseCase>(),
      gh<_i125.AssignEmdadUnitPersonUseCase>(),
      gh<_i132.DeleteEmdadUnitPersonUseCase>(),
      gh<_i343.ChangeEmdadUnitLocationUseCase>(),
      gh<_i690.GetEmdadUnitLookupsUseCase>(),
    ),
  );
  gh.lazySingleton<_i208.GetDashboardDataUseCase>(
    () => _i208.GetDashboardDataUseCase(gh<_i602.DashboardRepository>()),
  );
  gh.lazySingleton<_i974.GetSkillsCertificatesUseCase>(
    () => _i974.GetSkillsCertificatesUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.GetSkillCertificateByIdUseCase>(
    () => _i974.GetSkillCertificateByIdUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.CreateSkillCertificateUseCase>(
    () => _i974.CreateSkillCertificateUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.EditSkillCertificateUseCase>(
    () => _i974.EditSkillCertificateUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.DeleteSkillCertificateUseCase>(
    () => _i974.DeleteSkillCertificateUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.GetSkillCertificateServicesUseCase>(
    () => _i974.GetSkillCertificateServicesUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.SubmitSkillCertificateServicesUseCase>(
    () => _i974.SubmitSkillCertificateServicesUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i974.GetSkillCertificatesReportUseCase>(
    () => _i974.GetSkillCertificatesReportUseCase(
      gh<_i615.SkillsCertificatesRepository>(),
    ),
  );
  gh.lazySingleton<_i138.LogoutUseCase>(
    () => _i138.LogoutUseCase(
      gh<_i74.UserRepository>(),
      gh<_i308.SessionStorage>(),
    ),
  );
  gh.lazySingleton<_i1027.VehicleInfoRepository>(
    () => _i764.VehicleInfoRepositoryImpl(gh<_i247.VehicleInfoDataSource>()),
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
  gh.factory<_i579.GetVehicleInfoListUseCase>(
    () => _i579.GetVehicleInfoListUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.factory<_i579.GetVehicleInfoByIdUseCase>(
    () => _i579.GetVehicleInfoByIdUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.factory<_i579.SaveVehicleInfoUseCase>(
    () => _i579.SaveVehicleInfoUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.factory<_i579.DeleteVehicleInfoUseCase>(
    () => _i579.DeleteVehicleInfoUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.factory<_i579.GetVehicleInfoLookupsUseCase>(
    () =>
        _i579.GetVehicleInfoLookupsUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.factory<_i579.VehicleInfoToolsUseCase>(
    () => _i579.VehicleInfoToolsUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.factory<_i579.VehicleInfoServiceCategoriesUseCase>(
    () => _i579.VehicleInfoServiceCategoriesUseCase(
      gh<_i1027.VehicleInfoRepository>(),
    ),
  );
  gh.factory<_i579.VehicleInfoHistoryUseCase>(
    () => _i579.VehicleInfoHistoryUseCase(gh<_i1027.VehicleInfoRepository>()),
  );
  gh.lazySingleton<_i825.AssignGradePatternReferenceUseCase>(
    () => _i825.AssignGradePatternReferenceUseCase(
      gh<_i577.GradePatternRepository>(),
    ),
  );
  gh.lazySingleton<_i833.CreateGradePatternUseCase>(
    () => _i833.CreateGradePatternUseCase(gh<_i577.GradePatternRepository>()),
  );
  gh.lazySingleton<_i33.DeleteGradePatternReferenceUseCase>(
    () => _i33.DeleteGradePatternReferenceUseCase(
      gh<_i577.GradePatternRepository>(),
    ),
  );
  gh.lazySingleton<_i512.DeleteGradePatternUseCase>(
    () => _i512.DeleteGradePatternUseCase(gh<_i577.GradePatternRepository>()),
  );
  gh.lazySingleton<_i33.GetGradePatternByIdUseCase>(
    () => _i33.GetGradePatternByIdUseCase(gh<_i577.GradePatternRepository>()),
  );
  gh.lazySingleton<_i614.GetGradePatternListUseCase>(
    () => _i614.GetGradePatternListUseCase(gh<_i577.GradePatternRepository>()),
  );
  gh.lazySingleton<_i102.GetGradePatternReferencesUseCase>(
    () => _i102.GetGradePatternReferencesUseCase(
      gh<_i577.GradePatternRepository>(),
    ),
  );
  gh.lazySingleton<_i244.UpdateGradePatternUseCase>(
    () => _i244.UpdateGradePatternUseCase(gh<_i577.GradePatternRepository>()),
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
  gh.factory<_i853.AddAgencyContractUseCase>(
    () => _i853.AddAgencyContractUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i574.AddAgencyInfoUseCase>(
    () => _i574.AddAgencyInfoUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i427.AddAgencyPersonUseCase>(
    () => _i427.AddAgencyPersonUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i657.AddAgencyVehicleUseCase>(
    () => _i657.AddAgencyVehicleUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i147.ChangeAgencyStatusUseCase>(
    () => _i147.ChangeAgencyStatusUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i449.DeleteAgencyUseCase>(
    () => _i449.DeleteAgencyUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i600.GetAgencyAdditionalInformationUseCase>(
    () => _i600.GetAgencyAdditionalInformationUseCase(
      gh<_i233.AgencyInfoRepository>(),
    ),
  );
  gh.factory<_i201.GetAgencyContractsUseCase>(
    () => _i201.GetAgencyContractsUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i879.GetAgencyHistoryUseCase>(
    () => _i879.GetAgencyHistoryUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i632.GetAgencyInfoByIdUseCase>(
    () => _i632.GetAgencyInfoByIdUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i553.GetAgencyInfoListUseCase>(
    () => _i553.GetAgencyInfoListUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i881.GetAgencyInfoReportUseCase>(
    () => _i881.GetAgencyInfoReportUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i898.GetAgencyServiceTypesUseCase>(
    () => _i898.GetAgencyServiceTypesUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i282.GetCurrentAgencyPersonsUseCase>(
    () =>
        _i282.GetCurrentAgencyPersonsUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i807.GetCurrentAgencyVehiclesUseCase>(
    () =>
        _i807.GetCurrentAgencyVehiclesUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i516.SearchAgencyInfoUseCase>(
    () => _i516.SearchAgencyInfoUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i699.SearchPersonInfoUseCase>(
    () => _i699.SearchPersonInfoUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i645.SearchVehicleInfoUseCase>(
    () => _i645.SearchVehicleInfoUseCase(gh<_i233.AgencyInfoRepository>()),
  );
  gh.factory<_i791.GradePatternCubit>(
    () => _i791.GradePatternCubit(
      gh<_i614.GetGradePatternListUseCase>(),
      gh<_i33.GetGradePatternByIdUseCase>(),
      gh<_i833.CreateGradePatternUseCase>(),
      gh<_i244.UpdateGradePatternUseCase>(),
      gh<_i512.DeleteGradePatternUseCase>(),
      gh<_i102.GetGradePatternReferencesUseCase>(),
      gh<_i825.AssignGradePatternReferenceUseCase>(),
      gh<_i33.DeleteGradePatternReferenceUseCase>(),
      gh<_i928.ValidateGradePatternUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
      gh<_i470.ExportExcelUseCase>(),
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
  gh.factory<_i735.AddAgencyPersonCubit>(
    () => _i735.AddAgencyPersonCubit(
      gh<_i699.SearchPersonInfoUseCase>(),
      gh<_i427.AddAgencyPersonUseCase>(),
    ),
  );
  gh.lazySingleton<_i150.CreateSpecialPlanUseCase>(
    () => _i150.CreateSpecialPlanUseCase(gh<_i630.SpecialPlanRepository>()),
  );
  gh.lazySingleton<_i723.DeleteSpecialPlanUseCase>(
    () => _i723.DeleteSpecialPlanUseCase(gh<_i630.SpecialPlanRepository>()),
  );
  gh.lazySingleton<_i944.GetSpecialPlanListUseCase>(
    () => _i944.GetSpecialPlanListUseCase(gh<_i630.SpecialPlanRepository>()),
  );
  gh.lazySingleton<_i973.GetSpecialPlanProductsUseCase>(
    () =>
        _i973.GetSpecialPlanProductsUseCase(gh<_i630.SpecialPlanRepository>()),
  );
  gh.lazySingleton<_i1001.UpdateSpecialPlanUseCase>(
    () => _i1001.UpdateSpecialPlanUseCase(gh<_i630.SpecialPlanRepository>()),
  );
  gh.factory<_i951.IndicatorReportCubit>(
    () => _i951.IndicatorReportCubit(gh<_i375.FetchIndicatorReportUseCase>()),
  );
  gh.lazySingleton<_i14.ImeiRepository>(
    () => _i311.ImeiRepositoryImpl(gh<_i1065.ImeiDataSource>()),
  );
  gh.lazySingleton<_i716.AuthRepository>(
    () => _i781.AuthRepositoryImpl(
      gh<_i479.AuthRemoteDataSource>(),
      gh<_i308.SessionStorage>(),
    ),
  );
  gh.factory<_i943.PlanInfoCubit>(
    () => _i943.PlanInfoCubit(
      gh<_i203.GetPlanListUseCase>(),
      gh<_i203.GetPlanByIdUseCase>(),
      gh<_i203.CreatePlanUseCase>(),
      gh<_i203.EditPlanUseCase>(),
      gh<_i203.DeletePlanUseCase>(),
      gh<_i203.GetPlanStatusReasonsUseCase>(),
      gh<_i203.ChangePlanStatusUseCase>(),
      gh<_i203.GetPlanReportUseCase>(),
      gh<_i203.CancelPlanRequestsUseCase>(),
      gh<_i203.GetPlanLookupsUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
      gh<_i203.ChangeLocationUseCase>(),
      gh<_i203.GetPlanHistoriesUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.factory<_i842.GetEmdadgarByServiceRequestUseCase>(
    () => _i842.GetEmdadgarByServiceRequestUseCase(
      gh<_i1047.InvoiceAgencyObjectionRepository>(),
    ),
  );
  gh.factory<_i138.GetInvoiceAgencyObjectionUseCase>(
    () => _i138.GetInvoiceAgencyObjectionUseCase(
      gh<_i1047.InvoiceAgencyObjectionRepository>(),
    ),
  );
  gh.factory<_i548.GetInvoiceAgencyObjectionsUseCase>(
    () => _i548.GetInvoiceAgencyObjectionsUseCase(
      gh<_i1047.InvoiceAgencyObjectionRepository>(),
    ),
  );
  gh.factory<_i278.GetServiceRequestCompactUseCase>(
    () => _i278.GetServiceRequestCompactUseCase(
      gh<_i1047.InvoiceAgencyObjectionRepository>(),
    ),
  );
  gh.factory<_i1009.GetServiceRequestOperationAccessUseCase>(
    () => _i1009.GetServiceRequestOperationAccessUseCase(
      gh<_i1047.InvoiceAgencyObjectionRepository>(),
    ),
  );
  gh.factory<_i751.SkillsCertificatesCubit>(
    () => _i751.SkillsCertificatesCubit(
      gh<_i974.GetSkillsCertificatesUseCase>(),
      gh<_i974.GetSkillCertificateByIdUseCase>(),
      gh<_i974.CreateSkillCertificateUseCase>(),
      gh<_i974.EditSkillCertificateUseCase>(),
      gh<_i974.DeleteSkillCertificateUseCase>(),
      gh<_i974.GetSkillCertificateServicesUseCase>(),
      gh<_i974.SubmitSkillCertificateServicesUseCase>(),
      gh<_i974.GetSkillCertificatesReportUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.lazySingleton<_i1042.FetchKilometerFromImageUseCase>(
    () => _i1042.FetchKilometerFromImageUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i931.FetchOcrConfigurationUseCase>(
    () => _i931.FetchOcrConfigurationUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i226.GetActiveServiceRequestUseCase>(
    () => _i226.GetActiveServiceRequestUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i1026.GetDistanceToCustomerHomeServiceUseCase>(
    () => _i1026.GetDistanceToCustomerHomeServiceUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i1059.GetLastEvaluationHomeServiceUseCase>(
    () => _i1059.GetLastEvaluationHomeServiceUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i535.GetLastEvaluationUseCase>(
    () => _i535.GetLastEvaluationUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i664.GetPartMarkHomeServiceUseCase>(
    () => _i664.GetPartMarkHomeServiceUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i983.GetPartPriceHomeServiceUseCase>(
    () => _i983.GetPartPriceHomeServiceUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i91.GetReusablePriceUseCase>(
    () => _i91.GetReusablePriceUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i497.SetActiveServiceRequestUseCase>(
    () => _i497.SetActiveServiceRequestUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i570.SetLastEvaluationUseCase>(
    () => _i570.SetLastEvaluationUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i424.GetCurrentSessionUseCase>(
    () => _i424.GetCurrentSessionUseCase(gh<_i716.AuthRepository>()),
  );
  gh.lazySingleton<_i139.LoginUseCase>(
    () => _i139.LoginUseCase(gh<_i716.AuthRepository>()),
  );
  gh.factory<_i860.AssignAndCancelEmdadgarCubit>(
    () => _i860.AssignAndCancelEmdadgarCubit(
      gh<_i955.GetEmdadgarListUseCase>(),
      gh<_i595.ServiceAssignUseCase>(),
      gh<_i990.GetCheckDepotUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i678.GetRouteUseCase>(),
      gh<_i159.GetAreaBaseInfoUseCase>(),
      gh<_i433.GetCancelReasonRequestUseCase>(),
      gh<_i707.GetNonCooperationListUseCase>(),
    ),
  );
  gh.lazySingleton<_i657.ArchiveCartableMessageUseCase>(
    () => _i657.ArchiveCartableMessageUseCase(gh<_i133.CartableRepository>()),
  );
  gh.lazySingleton<_i301.DelegateCartableMessageUseCase>(
    () => _i301.DelegateCartableMessageUseCase(gh<_i133.CartableRepository>()),
  );
  gh.lazySingleton<_i862.GetCartableItemListUseCase>(
    () => _i862.GetCartableItemListUseCase(gh<_i133.CartableRepository>()),
  );
  gh.lazySingleton<_i45.GetSubordinatedUsersUseCase>(
    () => _i45.GetSubordinatedUsersUseCase(gh<_i133.CartableRepository>()),
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
  gh.factory<_i1048.ReliefRequestListCubit>(
    () => _i1048.ReliefRequestListCubit(
      gh<_i192.GetReliefRequestListUseCase>(),
      gh<_i385.GetRequestOperationAccessUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.factory<_i729.AcceptEmdadgarInvoicesUseCase>(
    () => _i729.AcceptEmdadgarInvoicesUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.factory<_i952.AcceptInitialEmdadgarInvoicesUseCase>(
    () => _i952.AcceptInitialEmdadgarInvoicesUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.factory<_i322.GetDefiniteEmdadgarInvoicesUseCase>(
    () => _i322.GetDefiniteEmdadgarInvoicesUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.factory<_i694.GetEmdadgarInvoicesUseCase>(
    () =>
        _i694.GetEmdadgarInvoicesUseCase(gh<_i840.EmdadgarInvoiceRepository>()),
  );
  gh.factory<_i762.GetFinalApprovalEmdadgarInvoicesUseCase>(
    () => _i762.GetFinalApprovalEmdadgarInvoicesUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.factory<_i631.GetFinalCorrectionEmdadgarInvoicesUseCase>(
    () => _i631.GetFinalCorrectionEmdadgarInvoicesUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.factory<_i1017.GetInitialEmdadgarInvoiceDetailsUseCase>(
    () => _i1017.GetInitialEmdadgarInvoiceDetailsUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.factory<_i476.GetInitialEmdadgarInvoicesUseCase>(
    () => _i476.GetInitialEmdadgarInvoicesUseCase(
      gh<_i840.EmdadgarInvoiceRepository>(),
    ),
  );
  gh.lazySingleton<_i1025.NavganRepository>(
    () => _i475.NavganRepositoryImpl(gh<_i87.NavganDataSource>()),
  );
  gh.lazySingleton<_i1038.AddVehicleModelUseCase>(
    () => _i1038.AddVehicleModelUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.lazySingleton<_i325.DeleteVehicleModelUseCase>(
    () => _i325.DeleteVehicleModelUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.lazySingleton<_i820.GetVehicleDefectsUseCase>(
    () => _i820.GetVehicleDefectsUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.lazySingleton<_i961.GetVehicleModelListUseCase>(
    () => _i961.GetVehicleModelListUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.lazySingleton<_i8.GetVehicleNavganListUseCase>(
    () => _i8.GetVehicleNavganListUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.lazySingleton<_i487.GetVehicleServiceGroupsUseCase>(
    () => _i487.GetVehicleServiceGroupsUseCase(
      gh<_i913.VehicleModelRepository>(),
    ),
  );
  gh.lazySingleton<_i603.SubmitVehicleDefectsUseCase>(
    () => _i603.SubmitVehicleDefectsUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.lazySingleton<_i518.SubmitVehicleServiceCategoriesUseCase>(
    () => _i518.SubmitVehicleServiceCategoriesUseCase(
      gh<_i913.VehicleModelRepository>(),
    ),
  );
  gh.lazySingleton<_i562.UpdateVehicleModelUseCase>(
    () => _i562.UpdateVehicleModelUseCase(gh<_i913.VehicleModelRepository>()),
  );
  gh.factory<_i566.LoginCubit>(
    () => _i566.LoginCubit(
      gh<_i139.LoginUseCase>(),
      gh<_i424.GetCurrentSessionUseCase>(),
      gh<_i845.LogOffUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.factory<_i317.HomeServiceEvaluationFirstStepCubit>(
    () => _i317.HomeServiceEvaluationFirstStepCubit(
      gh<_i1059.GetLastEvaluationHomeServiceUseCase>(),
      gh<_i1026.GetDistanceToCustomerHomeServiceUseCase>(),
      gh<_i570.SetLastEvaluationUseCase>(),
      gh<_i823.EvaluationDraftStore>(),
      gh<_i497.SetActiveServiceRequestUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
    ),
  );
  gh.lazySingleton<_i139.EmdadVehicleRepository>(
    () => _i77.EmdadVehicleRepositoryImpl(gh<_i639.EmdadVehicleDataSource>()),
  );
  gh.factory<_i404.RescuerListCubit>(
    () => _i404.RescuerListCubit(
      gh<_i557.GetRescuersUseCase>(),
      gh<_i708.DeleteRescuerUseCase>(),
      gh<_i118.GetRescuerReportUseCase>(),
      gh<_i833.GetRescuerSkillCertificatesUseCase>(),
      gh<_i339.GetRescuerHistoryUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.factory<_i727.ShiftListCubit>(
    () => _i727.ShiftListCubit(
      gh<_i113.GetShiftListUseCase>(),
      gh<_i585.DeleteShiftUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
      gh<_i470.ExportExcelUseCase>(),
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
  gh.lazySingleton<_i217.LeaveRepository>(
    () => _i691.LeaveRepositoryImpl(gh<_i1017.LeaveDataSource>()),
  );
  gh.factory<_i75.DeploymentLocationCubit>(
    () => _i75.DeploymentLocationCubit(
      gh<_i916.GetDeploymentLocationListUseCase>(),
      gh<_i510.GetDeploymentLocationByIdUseCase>(),
      gh<_i550.CreateDeploymentLocationUseCase>(),
      gh<_i676.UpdateDeploymentLocationUseCase>(),
      gh<_i950.DeleteDeploymentLocationUseCase>(),
      gh<_i265.GetProvinceWithCityListUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.lazySingleton<_i357.AddImeiInfoUseCase>(
    () => _i357.AddImeiInfoUseCase(gh<_i14.ImeiRepository>()),
  );
  gh.lazySingleton<_i911.DeleteImeiInfoUseCase>(
    () => _i911.DeleteImeiInfoUseCase(gh<_i14.ImeiRepository>()),
  );
  gh.lazySingleton<_i277.GetDeviceInfoListUseCase>(
    () => _i277.GetDeviceInfoListUseCase(gh<_i14.ImeiRepository>()),
  );
  gh.lazySingleton<_i1055.GetImeiInfoByIdUseCase>(
    () => _i1055.GetImeiInfoByIdUseCase(gh<_i14.ImeiRepository>()),
  );
  gh.lazySingleton<_i518.GetImeiInfoListUseCase>(
    () => _i518.GetImeiInfoListUseCase(gh<_i14.ImeiRepository>()),
  );
  gh.lazySingleton<_i859.UpdateImeiInfoUseCase>(
    () => _i859.UpdateImeiInfoUseCase(gh<_i14.ImeiRepository>()),
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
  gh.lazySingleton<_i178.FetchInsertHomeServiceCategoryUseCase>(
    () => _i178.FetchInsertHomeServiceCategoryUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i1004.FetchInsertHomeServicePackageUseCase>(
    () => _i1004.FetchInsertHomeServicePackageUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i780.FetchInsertHomeServiceServiceUseCase>(
    () => _i780.FetchInsertHomeServiceServiceUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i1015.GetInsertHomeServicePackageUseCase>(
    () => _i1015.GetInsertHomeServicePackageUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i902.GetLaborUseCase>(
    () => _i902.GetLaborUseCase(gh<_i347.HomeServiceEvaluationRepository>()),
  );
  gh.lazySingleton<_i990.GetPartUseCase>(
    () => _i990.GetPartUseCase(gh<_i347.HomeServiceEvaluationRepository>()),
  );
  gh.lazySingleton<_i915.GetServiceCategoriesUseCase>(
    () => _i915.GetServiceCategoriesUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i978.GetServicesUseCase>(
    () => _i978.GetServicesUseCase(gh<_i347.HomeServiceEvaluationRepository>()),
  );
  gh.lazySingleton<_i626.PostEvaluationAcceptUseCase>(
    () => _i626.PostEvaluationAcceptUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i684.PostEvaluationUseCase>(
    () => _i684.PostEvaluationUseCase(
      gh<_i347.HomeServiceEvaluationRepository>(),
    ),
  );
  gh.factory<_i74.FinalizeCustomerInvoiceUseCase>(
    () => _i74.FinalizeCustomerInvoiceUseCase(
      gh<_i332.CustomerInvoiceRepository>(),
    ),
  );
  gh.factory<_i245.GetCustomerInvoiceDetailsUseCase>(
    () => _i245.GetCustomerInvoiceDetailsUseCase(
      gh<_i332.CustomerInvoiceRepository>(),
    ),
  );
  gh.factory<_i61.GetCustomerInvoicesUseCase>(
    () =>
        _i61.GetCustomerInvoicesUseCase(gh<_i332.CustomerInvoiceRepository>()),
  );
  gh.factory<_i138.GetCustomerPreInvoicesUseCase>(
    () => _i138.GetCustomerPreInvoicesUseCase(
      gh<_i332.CustomerInvoiceRepository>(),
    ),
  );
  gh.lazySingleton<_i1012.InvoiceCommonRepository>(
    () =>
        _i377.InvoiceCommonRepositoryImpl(gh<_i424.InvoiceCommonDataSource>()),
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
  gh.lazySingleton<_i283.ChangeLeaveStatusUseCase>(
    () => _i283.ChangeLeaveStatusUseCase(gh<_i217.LeaveRepository>()),
  );
  gh.lazySingleton<_i680.DeleteLeaveRequestUseCase>(
    () => _i680.DeleteLeaveRequestUseCase(gh<_i217.LeaveRepository>()),
  );
  gh.lazySingleton<_i70.GetLeaveDetailsUseCase>(
    () => _i70.GetLeaveDetailsUseCase(gh<_i217.LeaveRepository>()),
  );
  gh.lazySingleton<_i706.GetLeaveReasonsUseCase>(
    () => _i706.GetLeaveReasonsUseCase(gh<_i217.LeaveRepository>()),
  );
  gh.lazySingleton<_i75.GetLeaveReportsUseCase>(
    () => _i75.GetLeaveReportsUseCase(gh<_i217.LeaveRepository>()),
  );
  gh.lazySingleton<_i918.RollbackLeaveRequestUseCase>(
    () => _i918.RollbackLeaveRequestUseCase(gh<_i217.LeaveRepository>()),
  );
  gh.factory<_i1013.HomeServiceRequestListCubit>(
    () => _i1013.HomeServiceRequestListCubit(
      gh<_i809.GetHomeServiceRequestListUseCase>(),
      gh<_i385.GetRequestOperationAccessUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.factory<_i705.AddAgencyContractCubit>(
    () => _i705.AddAgencyContractCubit(gh<_i853.AddAgencyContractUseCase>()),
  );
  gh.factory<_i129.GetCustomerInvoiceDocumentUrlsUseCase>(
    () => _i129.GetCustomerInvoiceDocumentUrlsUseCase(
      gh<_i1012.InvoiceCommonRepository>(),
    ),
  );
  gh.factory<_i700.GetEmdadCategoriesUseCase>(
    () => _i700.GetEmdadCategoriesUseCase(gh<_i1012.InvoiceCommonRepository>()),
  );
  gh.factory<_i865.GetEmdadgarInvoiceDocumentUrlsUseCase>(
    () => _i865.GetEmdadgarInvoiceDocumentUrlsUseCase(
      gh<_i1012.InvoiceCommonRepository>(),
    ),
  );
  gh.factory<_i866.GetInvoiceOperationAccessUseCase>(
    () => _i866.GetInvoiceOperationAccessUseCase(
      gh<_i1012.InvoiceCommonRepository>(),
    ),
  );
  gh.factory<_i440.ProfileCubit>(
    () => _i440.ProfileCubit(
      gh<_i958.ChangePasswordUseCase>(),
      gh<_i845.LogOffUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
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
  gh.factory<_i309.ShiftFormCubit>(
    () => _i309.ShiftFormCubit(
      gh<_i76.GetShiftByIdUseCase>(),
      gh<_i904.CreateShiftUseCase>(),
      gh<_i25.UpdateShiftUseCase>(),
      gh<_i325.ValidateShiftUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.factory<_i162.SpecialPlanFormCubit>(
    () => _i162.SpecialPlanFormCubit(
      gh<_i973.GetSpecialPlanProductsUseCase>(),
      gh<_i981.GetDiscountableAreasUseCase>(),
      gh<_i150.CreateSpecialPlanUseCase>(),
      gh<_i1001.UpdateSpecialPlanUseCase>(),
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
  gh.factory<_i1055.SpecialPlanReportCubit>(
    () => _i1055.SpecialPlanReportCubit(
      gh<_i944.GetSpecialPlanListUseCase>(),
      gh<_i973.GetSpecialPlanProductsUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.factory<_i598.AgencyInfoCubit>(
    () => _i598.AgencyInfoCubit(
      gh<_i553.GetAgencyInfoListUseCase>(),
      gh<_i632.GetAgencyInfoByIdUseCase>(),
      gh<_i516.SearchAgencyInfoUseCase>(),
      gh<_i881.GetAgencyInfoReportUseCase>(),
      gh<_i201.GetAgencyContractsUseCase>(),
      gh<_i282.GetCurrentAgencyPersonsUseCase>(),
      gh<_i807.GetCurrentAgencyVehiclesUseCase>(),
      gh<_i147.ChangeAgencyStatusUseCase>(),
      gh<_i449.DeleteAgencyUseCase>(),
      gh<_i898.GetAgencyServiceTypesUseCase>(),
      gh<_i600.GetAgencyAdditionalInformationUseCase>(),
      gh<_i879.GetAgencyHistoryUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
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
  gh.factory<_i70.ImeiCubit>(
    () => _i70.ImeiCubit(
      gh<_i518.GetImeiInfoListUseCase>(),
      gh<_i277.GetDeviceInfoListUseCase>(),
      gh<_i1055.GetImeiInfoByIdUseCase>(),
      gh<_i357.AddImeiInfoUseCase>(),
      gh<_i859.UpdateImeiInfoUseCase>(),
      gh<_i911.DeleteImeiInfoUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
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
  gh.factory<_i21.AddRescuerCubit>(
    () => _i21.AddRescuerCubit(
      gh<_i110.AddRescuerUseCase>(),
      gh<_i265.GetProvinceWithCityListUseCase>(),
    ),
  );
  gh.factory<_i360.VehicleModelCubit>(
    () => _i360.VehicleModelCubit(
      gh<_i961.GetVehicleModelListUseCase>(),
      gh<_i8.GetVehicleNavganListUseCase>(),
      gh<_i487.GetVehicleServiceGroupsUseCase>(),
      gh<_i820.GetVehicleDefectsUseCase>(),
      gh<_i603.SubmitVehicleDefectsUseCase>(),
      gh<_i518.SubmitVehicleServiceCategoriesUseCase>(),
      gh<_i325.DeleteVehicleModelUseCase>(),
      gh<_i1038.AddVehicleModelUseCase>(),
      gh<_i562.UpdateVehicleModelUseCase>(),
    ),
  );
  gh.factory<_i379.ServiceListCubit>(
    () => _i379.ServiceListCubit(
      gh<_i978.GetServicesUseCase>(),
      gh<_i226.GetActiveServiceRequestUseCase>(),
      gh<_i535.GetLastEvaluationUseCase>(),
    ),
  );
  gh.factory<_i337.HomeServiceEvaluationPackagesCubit>(
    () => _i337.HomeServiceEvaluationPackagesCubit(
      gh<_i1004.FetchInsertHomeServicePackageUseCase>(),
      gh<_i780.FetchInsertHomeServiceServiceUseCase>(),
      gh<_i178.FetchInsertHomeServiceCategoryUseCase>(),
      gh<_i226.GetActiveServiceRequestUseCase>(),
      gh<_i535.GetLastEvaluationUseCase>(),
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
  gh.factory<_i772.VehicleInfoCubit>(
    () => _i772.VehicleInfoCubit(
      gh<_i579.GetVehicleInfoListUseCase>(),
      gh<_i579.GetVehicleInfoByIdUseCase>(),
      gh<_i579.SaveVehicleInfoUseCase>(),
      gh<_i579.DeleteVehicleInfoUseCase>(),
      gh<_i579.GetVehicleInfoLookupsUseCase>(),
      gh<_i579.VehicleInfoToolsUseCase>(),
      gh<_i579.VehicleInfoServiceCategoriesUseCase>(),
      gh<_i579.VehicleInfoHistoryUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.lazySingleton<_i147.CreateEmdadVehicleUseCase>(
    () => _i147.CreateEmdadVehicleUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i996.DeleteEmdadVehicleUseCase>(
    () => _i996.DeleteEmdadVehicleUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i1054.GetActiveVehicleModelsUseCase>(
    () => _i1054.GetActiveVehicleModelsUseCase(
      gh<_i139.EmdadVehicleRepository>(),
    ),
  );
  gh.lazySingleton<_i263.GetEmdadVehicleByIdUseCase>(
    () => _i263.GetEmdadVehicleByIdUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i943.GetEmdadVehicleListUseCase>(
    () => _i943.GetEmdadVehicleListUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i341.GetImeiListUseCase>(
    () => _i341.GetImeiListUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i438.GetVehicleDefectsUseCase>(
    () => _i438.GetVehicleDefectsUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i871.GetVehicleHistoryUseCase>(
    () => _i871.GetVehicleHistoryUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i657.GetVehicleServicesUseCase>(
    () => _i657.GetVehicleServicesUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i1019.GetVehicleToolsUseCase>(
    () => _i1019.GetVehicleToolsUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i1026.SubmitVehicleDefectLimitationUseCase>(
    () => _i1026.SubmitVehicleDefectLimitationUseCase(
      gh<_i139.EmdadVehicleRepository>(),
    ),
  );
  gh.lazySingleton<_i516.SubmitVehicleServicesUseCase>(
    () =>
        _i516.SubmitVehicleServicesUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i336.SubmitVehicleToolsUseCase>(
    () => _i336.SubmitVehicleToolsUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.lazySingleton<_i558.UpdateEmdadVehicleUseCase>(
    () => _i558.UpdateEmdadVehicleUseCase(gh<_i139.EmdadVehicleRepository>()),
  );
  gh.factory<_i304.SpecialPlanListCubit>(
    () => _i304.SpecialPlanListCubit(
      gh<_i944.GetSpecialPlanListUseCase>(),
      gh<_i973.GetSpecialPlanProductsUseCase>(),
      gh<_i723.DeleteSpecialPlanUseCase>(),
      gh<_i1015.GetProvinceLookupListUseCase>(),
    ),
  );
  gh.lazySingleton<_i695.SyncCurrentSessionUseCase>(
    () => _i695.SyncCurrentSessionUseCase(
      gh<_i424.GetCurrentSessionUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
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
  gh.factory<_i330.CartableCubit>(
    () => _i330.CartableCubit(
      gh<_i45.GetSubordinatedUsersUseCase>(),
      gh<_i862.GetCartableItemListUseCase>(),
      gh<_i301.DelegateCartableMessageUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
      gh<_i657.ArchiveCartableMessageUseCase>(),
    ),
  );
  gh.factory<_i710.LeaveCubit>(
    () => _i710.LeaveCubit(
      gh<_i75.GetLeaveReportsUseCase>(),
      gh<_i70.GetLeaveDetailsUseCase>(),
      gh<_i706.GetLeaveReasonsUseCase>(),
      gh<_i283.ChangeLeaveStatusUseCase>(),
      gh<_i918.RollbackLeaveRequestUseCase>(),
      gh<_i680.DeleteLeaveRequestUseCase>(),
    ),
  );
  gh.factory<_i551.HomeServicePartCubit>(
    () => _i551.HomeServicePartCubit(
      gh<_i902.GetLaborUseCase>(),
      gh<_i990.GetPartUseCase>(),
      gh<_i664.GetPartMarkHomeServiceUseCase>(),
      gh<_i535.GetLastEvaluationUseCase>(),
      gh<_i226.GetActiveServiceRequestUseCase>(),
      gh<_i983.GetPartPriceHomeServiceUseCase>(),
      gh<_i91.GetReusablePriceUseCase>(),
    ),
  );
  gh.factory<_i664.LaborsAndPartsCubit>(
    () => _i664.LaborsAndPartsCubit(
      gh<_i902.GetLaborUseCase>(),
      gh<_i990.GetPartUseCase>(),
      gh<_i664.GetPartMarkHomeServiceUseCase>(),
      gh<_i535.GetLastEvaluationUseCase>(),
      gh<_i226.GetActiveServiceRequestUseCase>(),
      gh<_i983.GetPartPriceHomeServiceUseCase>(),
      gh<_i91.GetReusablePriceUseCase>(),
    ),
  );
  gh.factory<_i105.CustomerInvoiceCubit>(
    () => _i105.CustomerInvoiceCubit(
      gh<_i61.GetCustomerInvoicesUseCase>(),
      gh<_i700.GetEmdadCategoriesUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
    ),
  );
  gh.factory<_i757.AppCubit>(
    () => _i757.AppCubit(
      gh<_i695.SyncCurrentSessionUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
    ),
  );
  gh.lazySingleton<_i529.AddNavganGradeReferenceUseCase>(
    () => _i529.AddNavganGradeReferenceUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i467.DeleteNavganGradeReferenceUseCase>(
    () =>
        _i467.DeleteNavganGradeReferenceUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i1031.GetGradePatternDetailUseCase>(
    () => _i1031.GetGradePatternDetailUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i745.GetGradePatternListUseCase>(
    () => _i745.GetGradePatternListUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i958.GetGradePatternReferencesUseCase>(
    () => _i958.GetGradePatternReferencesUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i193.GetNavganDefectsUseCase>(
    () => _i193.GetNavganDefectsUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i570.GetNavganListUseCase>(
    () => _i570.GetNavganListUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i85.GetNavganServiceGroupsUseCase>(
    () => _i85.GetNavganServiceGroupsUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i71.SubmitNavganDefectsUseCase>(
    () => _i71.SubmitNavganDefectsUseCase(gh<_i1025.NavganRepository>()),
  );
  gh.lazySingleton<_i940.SubmitNavganServiceCategoriesUseCase>(
    () => _i940.SubmitNavganServiceCategoriesUseCase(
      gh<_i1025.NavganRepository>(),
    ),
  );
  gh.factory<_i47.CustomerPreInvoiceCubit>(
    () => _i47.CustomerPreInvoiceCubit(
      gh<_i138.GetCustomerPreInvoicesUseCase>(),
      gh<_i245.GetCustomerInvoiceDetailsUseCase>(),
      gh<_i74.FinalizeCustomerInvoiceUseCase>(),
      gh<_i129.GetCustomerInvoiceDocumentUrlsUseCase>(),
      gh<_i700.GetEmdadCategoriesUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
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
  gh.lazySingleton<_i392.GetHomeServicePackageListUseCase>(
    () => _i392.GetHomeServicePackageListUseCase(
      gh<_i122.EvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i915.GetLaborListUseCase>(
    () => _i915.GetLaborListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i476.GetLastEvaluationUseCase>(
    () => _i476.GetLastEvaluationUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i361.GetPartListUseCase>(
    () => _i361.GetPartListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i655.GetPartMarkListUseCase>(
    () => _i655.GetPartMarkListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i923.GetPartPriceUseCase>(
    () => _i923.GetPartPriceUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i229.GetRepresentationListUseCase>(
    () => _i229.GetRepresentationListUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i16.GetServiceDetailEvaluationUseCase>(
    () => _i16.GetServiceDetailEvaluationUseCase(
      gh<_i122.EvaluationRepository>(),
    ),
  );
  gh.lazySingleton<_i296.PostEvaluationUseCase>(
    () => _i296.PostEvaluationUseCase(gh<_i122.EvaluationRepository>()),
  );
  gh.lazySingleton<_i571.SubmitEvaluationForAidServiceUseCase>(
    () => _i571.SubmitEvaluationForAidServiceUseCase(
      gh<_i122.EvaluationRepository>(),
    ),
  );
  gh.factory<_i648.HomeServiceEvaluationSecondStepCubit>(
    () => _i648.HomeServiceEvaluationSecondStepCubit(
      gh<_i226.GetActiveServiceRequestUseCase>(),
      gh<_i535.GetLastEvaluationUseCase>(),
      gh<_i684.PostEvaluationUseCase>(),
    ),
  );
  gh.factory<_i680.AddAgencyVehicleCubit>(
    () => _i680.AddAgencyVehicleCubit(
      gh<_i645.SearchVehicleInfoUseCase>(),
      gh<_i657.AddAgencyVehicleUseCase>(),
      gh<_i1058.CurrentSessionManager>(),
      gh<_i695.SyncCurrentSessionUseCase>(),
    ),
  );
  gh.factory<_i487.EmdadgarInvoiceCubit>(
    () => _i487.EmdadgarInvoiceCubit(
      gh<_i476.GetInitialEmdadgarInvoicesUseCase>(),
      gh<_i694.GetEmdadgarInvoicesUseCase>(),
      gh<_i762.GetFinalApprovalEmdadgarInvoicesUseCase>(),
      gh<_i631.GetFinalCorrectionEmdadgarInvoicesUseCase>(),
      gh<_i322.GetDefiniteEmdadgarInvoicesUseCase>(),
      gh<_i952.AcceptInitialEmdadgarInvoicesUseCase>(),
      gh<_i729.AcceptEmdadgarInvoicesUseCase>(),
      gh<_i700.GetEmdadCategoriesUseCase>(),
      gh<_i369.SetSelectedRequestItemUseCase>(),
      gh<_i470.ExportExcelUseCase>(),
    ),
  );
  gh.factory<_i93.NavganCubit>(
    () => _i93.NavganCubit(
      gh<_i570.GetNavganListUseCase>(),
      gh<_i745.GetGradePatternListUseCase>(),
      gh<_i958.GetGradePatternReferencesUseCase>(),
      gh<_i1031.GetGradePatternDetailUseCase>(),
      gh<_i529.AddNavganGradeReferenceUseCase>(),
      gh<_i467.DeleteNavganGradeReferenceUseCase>(),
      gh<_i85.GetNavganServiceGroupsUseCase>(),
      gh<_i193.GetNavganDefectsUseCase>(),
      gh<_i940.SubmitNavganServiceCategoriesUseCase>(),
      gh<_i71.SubmitNavganDefectsUseCase>(),
    ),
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
  gh.factory<_i510.EvaluationInvoiceCubit>(
    () => _i510.EvaluationInvoiceCubit(
      gh<_i335.CustomerPreInvoiceOnTheFlyUseCase>(),
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i63.GetHomeServiceRequestByIdUseCase>(),
      gh<_i531.AcceptEvaluationUseCase>(),
    ),
  );
  gh.factory<_i319.EvaluationAidServiceRequestCubit>(
    () => _i319.EvaluationAidServiceRequestCubit(
      gh<_i376.FetchSelectedRequestItemUseCase>(),
      gh<_i672.GetReliefRequestByIdUseCase>(),
      gh<_i786.GetEmdadgarInfoUseCase>(),
      gh<_i1016.GetCategoriesListUseCase>(),
      gh<_i361.GetPartListUseCase>(),
      gh<_i655.GetPartMarkListUseCase>(),
      gh<_i923.GetPartPriceUseCase>(),
      gh<_i163.GetDefectsListUseCase>(),
      gh<_i16.GetServiceDetailEvaluationUseCase>(),
      gh<_i476.GetLastEvaluationUseCase>(),
      gh<_i915.GetLaborListUseCase>(),
      gh<_i571.SubmitEvaluationForAidServiceUseCase>(),
      gh<_i229.GetRepresentationListUseCase>(),
    ),
  );
  return getIt;
}

class _$SlidingPanelControllerModule
    extends _i997.SlidingPanelControllerModule {}

class _$NetworkModule extends _i453.NetworkModule {}

class _$AppModule extends _i460.AppModule {}

class _$ExcelWorkbookBuilderModule extends _i166.ExcelWorkbookBuilderModule {}
