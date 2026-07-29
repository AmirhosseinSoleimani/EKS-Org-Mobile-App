import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';

import '../constants/current_session_authorization_keys.dart';
import '../constants/current_session_menu_keys.dart';
import '../constants/current_session_role_keys.dart';

class CurrentSessionAccessPolicy {
  const CurrentSessionAccessPolicy(this._session);

  final CurrentSessionEntity? _session;

  bool get isAuthenticated => _session != null;

  bool get isSystemAdmin => hasRole(CurrentSessionRoleKeys.systemAdmin);

  bool hasAuthorization(String code) {
    if (code.trim().isEmpty) return false;
    return _session?.hasAuthorization(code) ?? false;
  }

  bool hasAnyAuthorization(Iterable<String> codes) {
    final validCodes = codes.where((code) => code.trim().isNotEmpty);
    return _session?.hasAnyAuthorization(validCodes) ?? false;
  }

  bool hasAllAuthorizations(Iterable<String> codes) {
    final validCodes = codes.where((code) => code.trim().isNotEmpty);
    return _session?.hasAllAuthorizations(validCodes) ?? false;
  }

  bool hasRole(String roleCode) {
    if (roleCode.trim().isEmpty) return false;
    return _session?.hasRole(roleCode) ?? false;
  }

  bool hasAnyRole(Iterable<String> roleCodes) {
    final validRoleCodes = roleCodes.where((code) => code.trim().isNotEmpty);
    return _session?.hasAnyRole(validRoleCodes) ?? false;
  }

  bool hasMenu(String menuCode) {
    if (menuCode.trim().isEmpty) return false;
    return _session?.hasMenu(menuCode) ?? false;
  }

  bool canShowByAuthorization(String authorizationCode) {
    return hasAuthorization(authorizationCode);
  }

  bool canShowByAnyAuthorization(Iterable<String> authorizationCodes) {
    return hasAnyAuthorization(authorizationCodes);
  }

  bool canShowByAllAuthorizations(Iterable<String> authorizationCodes) {
    return hasAllAuthorizations(authorizationCodes);
  }

  bool canShowMenu(String menuCode) {
    return hasMenu(menuCode) || hasAuthorization(menuCode);
  }

  bool canShowAnyMenu(Iterable<String> menuCodes) {
    return menuCodes.any(canShowMenu);
  }

  bool canManageCrud({
    required String view,
    required String insert,
    required String update,
    required String delete,
  }) {
    return hasAnyAuthorization([view, insert, update, delete]);
  }

  bool canViewCrudPage({
    required String root,
    required String view,
  }) {
    return hasAnyAuthorization([root, view]);
  }

  bool canShowDashboardMenu() {
    return canShowMenu(CurrentSessionMenuKeys.dashboard);
  }

  bool canShowCartableMenu() {
    return canShowMenu(CurrentSessionMenuKeys.cartable);
  }

  bool canShowCustomerInfoMenu() {
    return canShowMenu(CurrentSessionMenuKeys.customerInfo);
  }

  bool canShowServiceRequestSearchMenu() {
    return canShowMenu(CurrentSessionMenuKeys.followUp);
  }

  bool canShowHomeServiceRequestsMenu() {
    return canShowMenu(CurrentSessionMenuKeys.homeServiceRequests);
  }

  bool canShowSaleProductServiceRequestMenu() {
    return canShowMenu(CurrentSessionMenuKeys.saleProductServiceRequest);
  }

  bool canShowBlackListMenu() {
    return canShowMenu(CurrentSessionMenuKeys.blackList);
  }

  bool canShowSoftwareProblemsMenu() {
    return canShowMenu(CurrentSessionMenuKeys.softwareProblems);
  }

  bool canShowSanRescuerInfoMenu() {
    return canShowMenu(
      CurrentSessionMenuKeys.sanRescuerInfo,
    );
  }

  bool canShowSkillsCertificateButton() {
    return isAuthenticated &&
        canShowMenu(CurrentSessionMenuKeys.sanSkillsCertificate);
  }

  bool canShowNavganButton() {
    return isAuthenticated &&
        canShowMenu(CurrentSessionMenuKeys.sanNavganServices);
  }

  bool canShowNavganTypeButton() {
    return isAuthenticated &&
        canShowMenu(CurrentSessionMenuKeys.sanVehicleModel);
  }
  bool canShowDeploymentLocationButton() {
    return isAuthenticated &&
        canShowMenu(CurrentSessionMenuKeys.sanLocation);
  }

  bool canShowSanGeneralContent() {
    return isAuthenticated &&
        canShowMenu(CurrentSessionMenuKeys.sanGeneralContent);
  }


  bool canShowInvoicesMenu() {
    return canShowAnyMenu([
      CurrentSessionMenuKeys.invoices,
      CurrentSessionMenuKeys.customerPreInvoice,
      CurrentSessionMenuKeys.customerInvoice,
      CurrentSessionMenuKeys.emdadgarPreInvoice,
      CurrentSessionMenuKeys.emdadgarInvoice,
      CurrentSessionMenuKeys.emdadgarAmaliatFinalInvoice,
      CurrentSessionMenuKeys.emdadgarFinalInvoice,
      CurrentSessionMenuKeys.emdadgarDefiniteInvoice,
      CurrentSessionMenuKeys.emdadgarInvoiceObjection,
    ]);
  }

  bool canShowSanMenus() {
    return canShowAnyMenu([
      CurrentSessionMenuKeys.sanMenus,
      CurrentSessionMenuKeys.sanAgencyInfo,
      CurrentSessionMenuKeys.sanVehicleInfo,
      CurrentSessionMenuKeys.sanRescuerInfo,
      CurrentSessionMenuKeys.sanEmdadUnit,
      CurrentSessionMenuKeys.sanPlan,
      CurrentSessionMenuKeys.sanShift,
      CurrentSessionMenuKeys.sanSpecialPlan,
      CurrentSessionMenuKeys.sanFence,
      CurrentSessionMenuKeys.sanLocation,
      CurrentSessionMenuKeys.sanImei,
      CurrentSessionMenuKeys.sanGradePattern,
      CurrentSessionMenuKeys.sanNavganServices,
      CurrentSessionMenuKeys.sanGeneralContent,
      CurrentSessionMenuKeys.sanVehicleModel,
      CurrentSessionMenuKeys.sanSkillsCertificate,
      CurrentSessionMenuKeys.sanLeave,
      CurrentSessionMenuKeys.sanAgencyRequest,
    ]);
  }

  bool canShowReportsMenu() {
    return canShowAnyMenu([
      CurrentSessionMenuKeys.saipaReports,
      CurrentSessionMenuKeys.saipaReportsServiceRequest,
      CurrentSessionMenuKeys.saipaReportsServiceRequestEzhar,
      CurrentSessionMenuKeys.saipaReportsServiceRequestDefects,
      CurrentSessionMenuKeys.saipaReportsServiceRequestLaborReception,
      CurrentSessionMenuKeys.saipaReportsServiceRequestParts,
      CurrentSessionMenuKeys.saipaReportsServiceRequestDefectsDetails,
      CurrentSessionMenuKeys.reportsIndicator,
    ]);
  }

  bool canShowBaseInfoMenu() {
    return canShowAnyMenu([
      CurrentSessionMenuKeys.factor,
      CurrentSessionMenuKeys.aidInvoiceBase,
      CurrentSessionMenuKeys.productCategoryType,
      CurrentSessionMenuKeys.areaBaseInfo,
      CurrentSessionMenuKeys.timePeriods,
      CurrentSessionMenuKeys.holidays,
      CurrentSessionMenuKeys.defects,
      CurrentSessionMenuKeys.otherCost,
      CurrentSessionMenuKeys.basket,
      CurrentSessionMenuKeys.products,
      CurrentSessionMenuKeys.carModel,
      CurrentSessionMenuKeys.vehicleUsage,
      CurrentSessionMenuKeys.emdadgarsManagement,
      CurrentSessionMenuKeys.legalCustomer,
      CurrentSessionMenuKeys.emdadTools,
      CurrentSessionMenuKeys.discounts,
      CurrentSessionMenuKeys.job,
      CurrentSessionMenuKeys.provinces,
    ]);
  }

  bool canShowSecurityMenu() {
    return canShowAnyMenu([
      CurrentSessionMenuKeys.infrastructure,
      CurrentSessionMenuKeys.users,
      CurrentSessionMenuKeys.roles,
      CurrentSessionMenuKeys.operations,
      CurrentSessionMenuKeys.userGroups,
      CurrentSessionMenuKeys.shiftsHolidays,
      CurrentSessionMenuKeys.exceptions,
    ]);
  }

  bool canShowAdminSettingsMenu() {
    return canShowMenu(CurrentSessionMenuKeys.adminSettings) ||
        hasAnyAuthorization([
          CurrentSessionAuthorizationKeys.adminSettings,
          CurrentSessionAuthorizationKeys.adminSettingsView,
        ]);
  }

  bool canViewServiceRequest() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.serviceRequest,
      CurrentSessionAuthorizationKeys.serviceRequestView,
    ]);
  }

  bool canInsertServiceRequest() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestInsert,
    );
  }

  bool canUpdateServiceRequest() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestUpdate,
    );
  }

  bool canDeleteServiceRequest() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestDelete,
    );
  }

  bool canShowServiceRequestActions() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.serviceRequestActions,
      CurrentSessionAuthorizationKeys.serviceRequestAssign,
      CurrentSessionAuthorizationKeys.serviceRequestAssignCancel,
      CurrentSessionAuthorizationKeys.serviceRequestCancel,
      CurrentSessionAuthorizationKeys.serviceRequestCancelBeforeAssign,
      CurrentSessionAuthorizationKeys.serviceRequestCancelAfterAssign,
      CurrentSessionAuthorizationKeys.serviceRequestFollowUp,
      CurrentSessionAuthorizationKeys.serviceRequestCartableCycle,
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceRegistration,
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceShow,
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceCancel,
      CurrentSessionAuthorizationKeys.serviceRequestLackOfCooperation,
      CurrentSessionAuthorizationKeys.serviceRequestCopy,
      CurrentSessionAuthorizationKeys.serviceRequestEditAddress,
    ]);
  }

  bool canShowServiceRequestAssignButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestAssign,
    );
  }

  bool canShowServiceRequestAssignCancelButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestAssignCancel,
    );
  }

  bool canShowServiceRequestCancelButton() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.serviceRequestCancel,
      CurrentSessionAuthorizationKeys.serviceRequestCancelBeforeAssign,
      CurrentSessionAuthorizationKeys.serviceRequestCancelAfterAssign,
    ]);
  }

  bool canShowServiceRequestCancelBeforeAssignButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestCancelBeforeAssign,
    );
  }

  bool canShowServiceRequestCancelAfterAssignButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestCancelAfterAssign,
    );
  }

  bool canShowServiceRequestEditAddressButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestEditAddress,
    );
  }

  bool canShowServiceRequestFollowUpButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestFollowUp,
    );
  }

  bool canShowServiceRequestCartableCycleButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestCartableCycle,
    );
  }

  bool canShowServiceRequestLackOfCooperationButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestLackOfCooperation,
    );
  }

  bool canShowServiceRequestInvoiceRegistrationButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceRegistration,
    );
  }

  bool canShowServiceRequestInvoiceShowButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceShow,
    );
  }

  bool canShowServiceRequestInvoiceCancelButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceCancel,
    );
  }

  bool canShowServiceRequestCopyButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestCopy,
    );
  }

  bool canShowServiceRequestExternalEmdadNavganButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestExternalEmdadNavgan,
    );
  }

  bool canShowServiceRequestCancelExternalEmdadNavganButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestCancelExternalEmdadNavgan,
    );
  }

  bool canShowServiceRequestCustomerInvoiceButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestCustomerInvoice,
    );
  }

  bool canShowServiceRequestEmdadgarInvoiceButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestEmdadgarInvoice,
    );
  }

  bool canShowServiceRequestInvoiceModificationButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestInvoiceModification,
    );
  }

  bool canShowServiceRequestEvaluationHistoryButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.serviceRequestEvaluationHistory,
    );
  }

  bool canShowUrgentServiceRequestButton() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.urgentServiceRequest,
      CurrentSessionAuthorizationKeys.urgentServiceRequestInsert,
      CurrentSessionAuthorizationKeys.urgentServiceRequestCompleted,
    ]);
  }

  bool canViewHomeServiceRequest() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.homeServiceRequest,
      CurrentSessionAuthorizationKeys.homeServiceRequestView,
    ]);
  }

  bool canInsertHomeServiceRequest() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestInsert,
    );
  }

  bool canUpdateHomeServiceRequest() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestUpdate,
    );
  }

  bool canShowHomeServiceRequestActions() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.homeServiceRequestActions,
      CurrentSessionAuthorizationKeys.homeServiceRequestAssign,
      CurrentSessionAuthorizationKeys.homeServiceRequestAssignCancel,
      CurrentSessionAuthorizationKeys.homeServiceRequestCancel,
      CurrentSessionAuthorizationKeys.homeServiceRequestFollowUp,
      CurrentSessionAuthorizationKeys.homeServiceRequestCartableCycle,
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceRegistration,
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceShow,
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceCancel,
      CurrentSessionAuthorizationKeys.homeServiceRequestLackOfCooperation,
      CurrentSessionAuthorizationKeys.homeServiceRequestCopy,
    ]);
  }

  bool canShowHomeServiceRequestAssignButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestAssign,
    );
  }

  bool canShowHomeServiceRequestAssignCancelButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestAssignCancel,
    );
  }

  bool canShowHomeServiceRequestCancelButton() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.homeServiceRequestCancel,
      CurrentSessionAuthorizationKeys.homeServiceRequestCancelBeforeAssign,
      CurrentSessionAuthorizationKeys.homeServiceRequestCancelAfterAssign,
    ]);
  }

  bool canShowHomeServiceRequestInvoiceRegistrationButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceRegistration,
    );
  }

  bool canShowHomeServiceRequestInvoiceShowButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceShow,
    );
  }

  bool canShowHomeServiceRequestInvoiceCancelButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceCancel,
    );
  }

  bool canShowHomeServiceRequestFollowUpButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestFollowUp,
    );
  }

  bool canShowHomeServiceRequestCartableCycleButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestCartableCycle,
    );
  }

  bool canShowHomeServiceRequestLackOfCooperationButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestLackOfCooperation,
    );
  }

  bool canShowHomeServiceRequestCopyButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestCopy,
    );
  }

  bool canShowHomeServiceRequestCustomerInvoiceButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestCustomerInvoice,
    );
  }

  bool canShowHomeServiceRequestEmdadgarInvoiceButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestEmdadgarInvoice,
    );
  }

  bool canShowHomeServiceRequestInvoiceModificationButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestInvoiceModification,
    );
  }

  bool canShowHomeServiceRequestEvaluationHistoryButton() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.homeServiceRequestEvaluationHistory,
    );
  }

  bool canViewCustomerInfo() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.customerInfo,
      CurrentSessionAuthorizationKeys.customerInfoView,
    ]);
  }

  bool canInsertCustomerInfo() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.customerInfoInsert);
  }

  bool canUpdateCustomerInfo() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.customerInfoUpdate);
  }

  bool canDeleteCustomerInfo() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.customerInfoDelete);
  }

  bool canBlockCustomer() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.customerInfoBlock);
  }

  bool canUnblockCustomer() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.blockedCustomerUnblock,
    );
  }

  bool canModifyReliableCustomerInfo() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.customerInfoReliableInfoModification,
    );
  }

  bool canViewRoles() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.role,
      CurrentSessionAuthorizationKeys.roleView,
    ]);
  }

  bool canInsertRole() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.roleInsert);
  }

  bool canUpdateRole() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.roleUpdate);
  }

  bool canDeleteRole() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.roleDelete);
  }

  bool canViewOperations() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.operation,
      CurrentSessionAuthorizationKeys.operationView,
      CurrentSessionAuthorizationKeys.operationAccessRoot,
    ]);
  }

  bool canViewUsers() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.userInfo,
      CurrentSessionAuthorizationKeys.userInfoView,
    ]);
  }

  bool canInsertUser() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.userInfoInsert);
  }

  bool canUpdateUser() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.userInfoUpdate);
  }

  bool canDeleteUser() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.userInfoDelete);
  }

  bool canChangeUserPassword() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.changeUserPassword,
    );
  }

  bool canSaveUserOperation() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.userOperationSave,
    );
  }

  bool canViewExceptionLogs() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.exceptionLog,
      CurrentSessionAuthorizationKeys.exceptionLogView,
    ]);
  }

  bool canViewInvoices() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.invoice,
      CurrentSessionAuthorizationKeys.invoiceView,
      CurrentSessionAuthorizationKeys.invoiceCustomerInvoiceList,
      CurrentSessionAuthorizationKeys.invoiceEmdadgarInvoiceList,
      CurrentSessionAuthorizationKeys.invoiceEmdadgarEvaluationList,
      CurrentSessionAuthorizationKeys.invoiceEmdadgarView,
    ]);
  }

  bool canCancelInvoice() {
    return hasAuthorization(CurrentSessionAuthorizationKeys.invoiceCancel);
  }

  bool canBatchConfirmInvoice() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.invoiceBatchConfirmation,
    );
  }

  bool canViewInvoiceAgencyObjection() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.invoiceAgencyObjection,
      CurrentSessionAuthorizationKeys.invoiceAgencyObjectionView,
    ]);
  }

  bool canUpdateInvoiceAgencyObjection() {
    return hasAuthorization(
      CurrentSessionAuthorizationKeys.invoiceAgencyObjectionUpdate,
    );
  }

  bool canShowIMEI() {
    return canShowMenu(CurrentSessionMenuKeys.sanImei);
  }
  bool canShowShift() {
    return canShowMenu(CurrentSessionMenuKeys.sanShift);
  }

  bool canViewReports() {
    return hasAnyAuthorization([
      CurrentSessionAuthorizationKeys.reports,
      CurrentSessionAuthorizationKeys.reportApp,
      CurrentSessionAuthorizationKeys.reportsIndicatorView,
    ]);
  }
}

extension CurrentSessionAccessExtension on CurrentSessionEntity? {
  CurrentSessionAccessPolicy get access => CurrentSessionAccessPolicy(this);
}
