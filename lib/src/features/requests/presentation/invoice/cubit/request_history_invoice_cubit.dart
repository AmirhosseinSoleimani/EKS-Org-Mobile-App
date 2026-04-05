import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/invoice/cubit/request_history_invoice_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/fetch_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/dialog_widget/dialog_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class RequestHistoryInvoiceCubit extends Cubit<RequestHistoryInvoiceState> {
  final FetchInvoiceUseCase _fetchInvoiceUseCase;
  RequestHistoryInvoiceCubit(this._fetchInvoiceUseCase,) : super(const RequestHistoryInvoiceState.idle());


  InvoiceResponseEntity? invoiceEntity = const InvoiceResponseEntity();

  init({ServiceInvoiceRequestEntity? entity}) async{
    _fetchInvoice(entity: entity);
  }


  Future<void> _fetchInvoice({ServiceInvoiceRequestEntity? entity}) async{
    emit(const RequestHistoryInvoiceState.loading());
    final result = await _fetchInvoiceUseCase.call(entity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          invoiceEntity = data;
          emit(const RequestHistoryInvoiceState.success());
        } else {
          emit(RequestHistoryInvoiceState.error(dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? 'خطای غیرمنتظره')));
        }
      },
      failure: (error, msg) {
        emit(RequestHistoryInvoiceState.error(
            dialogDataModel: DialogDataModel(title: 'خطا', description: msg ?? 'خطای غیرمنتظره')));
      },
      connectionError: () {
        emit(const RequestHistoryInvoiceState.connectionError());
      },
    );
  }
}
