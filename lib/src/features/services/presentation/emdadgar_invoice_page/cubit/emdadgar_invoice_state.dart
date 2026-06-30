part of 'emdadgar_invoice_cubit.dart';

@freezed
class EmdadgarInvoiceState with _$EmdadgarInvoiceState {
  const factory EmdadgarInvoiceState.idle() = _Idle;

  const factory EmdadgarInvoiceState.loading() = _Loading;

  const factory EmdadgarInvoiceState.loaded() = _Loaded;

  const factory EmdadgarInvoiceState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory EmdadgarInvoiceState.connectionError() = _ConnectionError;
}
