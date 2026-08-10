part of 'emdadgar_invoice_cubit.dart';

@freezed
class EmdadgarInvoiceState with _$EmdadgaInvoiceState {
  const factory EmdadgarInvoiceState.idle() = _Idle;

  const factory EmdadgarInvoiceState.loading() = _Loading;

  const factory EmdadgarInvoiceState.loaded() = _Loaded;

  const factory EmdadgarInvoiceState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory EmdadgarInvoiceState.connectionError() =
      _ConnectionError;

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringDeep({String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow({String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }
}
