import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_pre_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'pre_invoice_cubit.freezed.dart';

part 'pre_invoice_state.dart';

@injectable
class PreInvoiceCubit extends Cubit<PreInvoiceState> {
  final GetPreInvoiceUseCase _getPreInvoiceUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;

  PreInvoiceCubit(
    this._getPreInvoiceUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
  ) : super(const PreInvoiceState.idle());

  BaseRequestEntity? selectedRequest = HomeServiceRequestEntity(serviceType: ServiceType.homeService, id: 1000, requestStatus: 1);
  InvoiceEntity? invoiceEntity;

  Future<void> init() async {
    _safeEmit(const PreInvoiceState.loading());

    /*selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const PreInvoiceState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    await _refreshRequestData();
    await _loadPreInvoiceInfo();*/

    //await _refreshRequestData();
    await Future.delayed(const Duration(milliseconds: 800));
    _loadFakeInvoice();
  }

  void _loadFakeInvoice() {
    final fakeJson = {
      "invoiceTitle": "اولیه مشتری",
      "invoiceGuid": "a323d7cd-9dee-4f15-9028-acc30b09264c",
      "sumAllInvoice": {
        "title": "هزینه ها",
        "detailEmdadInvoiceTotalCompany": 0,
        "detailEmdadInvoiceTotalCustomer": 1050,
        "customerPaymentPrice": 120000000,
        "discountTotalPrice": 0,
        "totalReusableCustomerPrice": 0,
        "totalReusableCompanyPrice": 0,
        "laborTotal": 11052369,
        "laborCustomerTotal": 11052369,
        "laborCompanyTotal": 0,
        "partTotal": 17500000,
        "partCustomerTotal": 17500000,
        "partCompanyTotal": 0,
        "valueAddedTax": 10,
        "taxTotalCustomerText": "مالیات بر ارزش افزوده (10%)",
        "taxTotalCustomer": 2945236,
        "taxTotalCompany": 0,
        "totalAllItems": 0,
        "totalOtherCostCustomerPrice": 0,
        "totalOtherCostCompanyPrice": 0,
        "totalAllItemsCompany": 0,
        "totalAllItemsCustomer": 32397605,
        "isSubscription": true,
        "isGuaranty": true,
        "isCancelInvoice": false,
        "isEvaluationChanged": false,
        "emdadServiceCategoryTitle": "تعمیرات در محل",
        "detailEmdadgarInvoiceBase": 0,
        "detailEmdadInvoiceTotalCustomerTax": 0,
        "emdadgarInvoiceBaseAndTaxCustomer": 0
      },
      "detailInvoice": {
        "title": "جزئیات هزینه های امدادی",
        "invoiceItems": [
          {
            "id": 0,
            "invoiceId": 0,
            "aidItemType": 1,
            "aidItemTypeStr": "حق الزحمه ورودی",
            "customerPrice": 900000,
            "customerBasePrice": 900000,
            "customerDiscountPrice": 0,
            "companyPrice": 0
          },
          {
            "id": 0,
            "invoiceId": 0,
            "aidItemType": 3,
            "aidItemTypeStr": "هزینه مراجعه امدادگر 0 کیلومتر",
            "customerPrice": 0,
            "customerBasePrice": 0,
            "customerDiscountPrice": 0,
            "companyPrice": 0
          }
        ],
        "companyTotal": 0,
        "customerTotal": 900000,
        "total": 0
      },
      "serviceInvoice": {
        "title": "سرویس ها",
        "serviceReception": [
          {
            "invoiceId": 1535064,
            "serviceId": 1026,
            "serviceTitle": "تعویض مجموعه کامل تسمه تایم",
            "serviceCategoryId": 61,
            "serviceCategoryTitle": "تعمیرات در محل",
            "serviceCategoryCode": "HOME_SERVICE_UNURGENT_SERVICE",
            "serviceCode": "2002",
            "serviceType": 2,
            "serviceTypeTitle": "خدمات در محل"
          }
        ]
      },
      "laborInvoice": {
        "title": "اجرت ها",
        "laborReception": [
          {
            "id": 1732532,
            "invoiceId": 1535064,
            "laborGroupId": 37,
            "laborGroupDesc": "تعویض تسمه‌ تايمينگ",
            "laborId": 213067,
            "laborCode": "A3521H00",
            "laborDescription": "پیاده و سوار کردن تسمه‌  تایمینگ‌ (A3521H00) ",
            "standardTime": 1.95,
            "nahveMohasebeId": 0,
            "nahveMohasebeCode": "Customer",
            "nahveMohasebeDescription": "مشتری",
            "price": 11052369,
            "basePrice": 11052369,
            "discountPrice": 0,
            "laborTotalPriceRial": 11052369,
            "overLapCode": "11,284,310,345,444,517,528,529,541,542",
            "isCausing": false,
            "isActive": true
          }
        ],
        "total": 11052369
      },
      "partInvoice": {
        "title": "قطعات",
        "partReception": [
          {
            "id": 446440,
            "invoiceId": 1535064,
            "partGroupId": 536,
            "partGroupName": "کیت تسمه تایم",
            "laborId": 213067,
            "laborCode": "A3521H00",
            "laborDescription": "پیاده و سوار کردن تسمه‌  تایمینگ‌ (A3521H00)",
            "nahveMohasebeId": 0,
            "nahveMohasebeCode": "Customer",
            "nahveMohasebeDescription": "مشتری",
            "afterSaleServiceDescription": "مشتری",
            "commodityCode": "109260",
            "replaceCount": 1,
            "commodityDescription": "کیت تسمه تایم  - تجاری-109260 ",
            "mark": "P0C",
            "partPriceRial": 13000000,
            "basePrice": 13000000,
            "discountPrice": 0,
            "description": "کیت تسمه تایم  - تجاری-109260",
            "hasReusable": false,
            "reusablePrice": 0,
            "isCausing": false,
            "isActive": true
          },
          {
            "id": 446441,
            "invoiceId": 1535064,
            "partGroupId": 59,
            "partGroupName": "بلبرینگ تسمه سفت کن",
            "laborId": 213067,
            "laborCode": "A3521H00",
            "laborDescription": "پیاده و سوار کردن تسمه‌  تایمینگ‌ (A3521H00)",
            "nahveMohasebeId": 0,
            "nahveMohasebeCode": "Customer",
            "nahveMohasebeDescription": "مشتری",
            "afterSaleServiceDescription": "مشتری",
            "commodityCode": "502243",
            "replaceCount": 1,
            "commodityDescription": " بلبرینگ تسمه سفت کن (جدید)-502243 ",
            "mark": "P2J",
            "partPriceRial": 4500000,
            "basePrice": 4500000,
            "discountPrice": 0,
            "description": " بلبرینگ تسمه سفت کن (جدید)-502243",
            "hasReusable": false,
            "reusablePrice": 0,
            "isCausing": false,
            "isActive": true
          }
        ],
        "total": 17500000
      },
      "otherCostInvoice": {
        "title": "سایر هزینه ها",
        "otherCostReception": [],
        "customerTotalPrice": 0,
        "companyTotalPrice": 0
      },
      "optionServiceInvoice": {
        "title": "خدمات جانبی",
        "optionServiceReception": []
      },
      "otherCosts": {
        "title": "سایر هزینه ها",
        "otherCostReception": [],
        "customerTotalPrice": 0,
        "companyTotalPrice": 0
      },
      "options": [],
      "services": [
        {
          "invoiceId": 1535064,
          "serviceId": 1026,
          "serviceTitle": "تعویض مجموعه کامل تسمه تایم",
          "serviceCategoryId": 61,
          "serviceCategoryTitle": "تعمیرات در محل",
          "serviceCategoryCode": "HOME_SERVICE_UNURGENT_SERVICE",
          "serviceCode": "2002",
          "serviceType": 2,
          "serviceTypeTitle": "خدمات در محل"
        }
      ]
    };

    final model = InvoiceModel.fromJson(fakeJson);

    invoiceEntity = model;

   _safeEmit(const PreInvoiceState.loaded());
  }


  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, __) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _loadPreInvoiceInfo() async {
    final param = ServiceInvoiceParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );
    final result = await _getPreInvoiceUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        invoiceEntity = data;
        _safeEmit(const PreInvoiceState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          PreInvoiceState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () => _safeEmit(const PreInvoiceState.connectionError()),
    );
  }

  void _safeEmit(PreInvoiceState state) {
    if (!isClosed) emit(state);
  }

  get isSubscription => selectedRequest?.isSubscription ?? false;
  get isGuaranty => selectedRequest?.isGuaranty ?? false;
}
