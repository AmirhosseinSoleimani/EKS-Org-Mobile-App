import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/use_cases/get_emdadgar_invoice_document_urls_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_initial_emdadgar_invoice_details_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/cubit/emdadgar_invoice_details_state.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/models/emdadgar_invoice_details_args.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_emdadgar_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmdadgarInvoiceDetailsCubit extends Cubit<EmdadgarInvoiceDetailsState> {
  EmdadgarInvoiceDetailsCubit(
    this._getInitialInvoiceDetailsUseCase,
    this._getEmdadgarInvoiceUseCase,
    this._getEmdadgarInvoiceDocumentUrlsUseCase,
  ) : super(const EmdadgarInvoiceDetailsState());

  final GetInitialEmdadgarInvoiceDetailsUseCase
      _getInitialInvoiceDetailsUseCase;
  final GetEmdadgarInvoiceUseCase _getEmdadgarInvoiceUseCase;
  final GetEmdadgarInvoiceDocumentUrlsUseCase
      _getEmdadgarInvoiceDocumentUrlsUseCase;

  EmdadgarInvoiceDetailsArgs? _args;

  Future<void> load(EmdadgarInvoiceDetailsArgs args) async {
    _args = args;
    await _fetch(args);
  }

  Future<void> retry() async {
    final args = _args;
    if (args == null) return;
    await _fetch(args);
  }

  Future<void> _fetch(EmdadgarInvoiceDetailsArgs args) async {
    final validationMessage = _validate(args);
    if (validationMessage != null) {
      _emitError(validationMessage);
      return;
    }

    _safeEmit(const EmdadgarInvoiceDetailsState(
      status: EmdadgarInvoiceDetailsStatus.loading,
    ));

    final result = await _getInvoice(args);
    result.when(
      success: (invoice, _, __) {
        _safeEmit(EmdadgarInvoiceDetailsState(
          status: EmdadgarInvoiceDetailsStatus.loaded,
          invoice: invoice,
        ));
      },
      failure: (error, message) {
        _emitError(message ?? error.toString());
      },
      expireToken: () {},
      connectionError: () {
        _safeEmit(const EmdadgarInvoiceDetailsState(
          status: EmdadgarInvoiceDetailsStatus.connectionError,
        ));
      },
    );
  }

  Future<ApiResult<InvoiceEntity?>> _getInvoice(
    EmdadgarInvoiceDetailsArgs args,
  ) {
    final serviceType = args.serviceType!;

    return switch (args.stage) {
      EmdadgarInvoiceStage.initial => _getInitialInvoiceDetailsUseCase(
          InvoiceDetailsParamEntity(
            emdadgarEvaluationId: args.evaluationId,
            serviceType: serviceType,
          ),
        ),
      _ => _getEmdadgarInvoiceUseCase(
          ServiceInvoiceParamEntity(
            emdadgarEvaluationId: args.evaluationId,
            serviceType: serviceType.value,
            invoiceStatus: switch (args.stage) {
              EmdadgarInvoiceStage.current => 2,
              EmdadgarInvoiceStage.finalCorrection => 1,
              _ => null,
            },
          ),
        ),
    };
  }

  Future<ApiResult<InvoiceDocumentUrlsEntity>> getDocumentUrls(
    String invoiceGuid,
  ) {
    return _getEmdadgarInvoiceDocumentUrlsUseCase(invoiceGuid);
  }

  String? _validate(EmdadgarInvoiceDetailsArgs args) {
    if (args.serviceType == null) {
      return 'نوع سرویس برای دریافت صورت وضعیت مشخص نیست.';
    }

    final evaluationId = args.evaluationId;
    if (evaluationId == null || evaluationId <= 0) {
      return args.stage == EmdadgarInvoiceStage.initial
          ? 'شناسه ارزیابی برای دریافت صورت وضعیت اولیه موجود نیست.'
          : 'شناسه ارزیابی برای دریافت صورت وضعیت موجود نیست.';
    }

    return null;
  }

  void _emitError(String message) {
    _safeEmit(EmdadgarInvoiceDetailsState(
      status: EmdadgarInvoiceDetailsStatus.error,
      message: BottomSheetMessageModel(
        title: 'خطا',
        message: message.trim().isEmpty
            ? 'در دریافت صورت وضعیت مشکلی رخ داد.'
            : message,
      ),
    ));
  }

  void _safeEmit(EmdadgarInvoiceDetailsState value) {
    if (!isClosed) emit(value);
  }
}
