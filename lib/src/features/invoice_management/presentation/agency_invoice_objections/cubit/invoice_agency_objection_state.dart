part of 'invoice_agency_objection_cubit.dart';

@freezed
sealed class InvoiceAgencyObjectionState with _$InvoiceAgencyObjectionState {
  const factory InvoiceAgencyObjectionState.idle() = _Idle;

  const factory InvoiceAgencyObjectionState.loading() = _Loading;

  const factory InvoiceAgencyObjectionState.loaded() = _Loaded;

  const factory InvoiceAgencyObjectionState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory InvoiceAgencyObjectionState.connectionError() =
  _ConnectionError;
}