part of 'emdadgar_initial_invoice_cubit.dart';

@freezed
class EmdadgarInitialInvoiceState with _$EmdadgarInitialInvoiceState {
  const factory EmdadgarInitialInvoiceState.idle() = _Idle;

  const factory EmdadgarInitialInvoiceState.loading() = _Loading;

  const factory EmdadgarInitialInvoiceState.loaded() = _Loaded;

  const factory EmdadgarInitialInvoiceState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory EmdadgarInitialInvoiceState.connectionError() =
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
