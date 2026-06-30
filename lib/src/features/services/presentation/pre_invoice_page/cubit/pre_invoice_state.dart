part of 'pre_invoice_cubit.dart';

@freezed
class PreInvoiceState with _$PreInvoiceState {
  const factory PreInvoiceState.idle() = _Idle;

  const factory PreInvoiceState.loading() = _Loading;

  const factory PreInvoiceState.loaded() = _Loaded;

  const factory PreInvoiceState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory PreInvoiceState.connectionError() = _ConnectionError;
}
