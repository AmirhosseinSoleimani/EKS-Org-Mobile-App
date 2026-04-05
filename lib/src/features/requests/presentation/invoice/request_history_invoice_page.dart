/*
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/requests/subscription_history/invoice/cubit/request_history_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/subscription_history/invoice/cubit/request_history_invoice_state.dart';
import 'package:eks_sana_plus_org/src/features/requests/subscription_history/invoice/page/request_history_invoice_shimmer_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/details_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/golden_card_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/labor_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/other_cost_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/part_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/sum_all_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/subscription_history/invoice_widget/details_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/subscription_history/invoice_widget/labor_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/subscription_history/invoice_widget/other_cost_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/subscription_history/invoice_widget/part_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/subscription_history/invoice_widget/sum_all_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_theme_data.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/dialog_widget/dialog_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/shimmer_widget/shimmer_or_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestHistoryInvoicePage extends StatelessWidget {
  final InvoiceRequestEntity? entity;
  final ServiceType _type;

  const RequestHistoryInvoicePage._(this._type, {super.key, this.entity});

  const RequestHistoryInvoicePage.aidService({Key? key, InvoiceRequestEntity? entity,}) :
        this._(ServiceType.aidService, entity: entity, key: key);

  const RequestHistoryInvoicePage.homeService({Key? key, InvoiceRequestEntity? entity,
  }) : this._(ServiceType.homeService, entity: entity, key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LightThemeData().materialThemeData,
      child: Scaffold(
        appBar: AppBarWidget(
            title: 'فاکتور',
          ),
        body: BlocProvider(
          create: (_) => getIt<RequestHistoryInvoiceCubit>()..init(entity: entity),
          child: _RequestHistoryInvoicePageView(serviceType: _type,),
        ),
      ),
    );
  }
}

class _RequestHistoryInvoicePageView extends StatelessWidget {
  final ServiceType? serviceType;
  const _RequestHistoryInvoicePageView({this.serviceType});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestHistoryInvoiceCubit, RequestHistoryInvoiceState>(
      listener: (BuildContext context, state) {
        state.whenOrNull(
          error: (dialogDataModel) => DialogMessage.showError(context: context, dialog: dialogDataModel),
        );
      },
      builder: (BuildContext context, state) {
        final cubit = context.read<RequestHistoryInvoiceCubit>();
        final widgetFactory = _InvoiceWidgetFactory(serviceType);
        return state.maybeWhen(
            loading: () => ShimmerOrLoading(shimmer: widgetFactory.requestHistoryInvoiceShimmerWidget()),
            orElse: () => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p16, horizontal: AppPadding.p12),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  widgetFactory.sumAllInvoiceWidget(cubit.invoiceEntity?.sumAllInvoice),
                  Space.h16,
                  widgetFactory.detailsInvoiceWidget(cubit.invoiceEntity?.detailsInvoice),
                  Space.h16,
                  if (cubit.invoiceEntity?.otherCosts?.otherCostReceptions?.isNotEmpty ?? false)
                    widgetFactory.otherCostInvoiceWidget(cubit.invoiceEntity?.otherCosts),
                  Space.h16,
                  if (cubit.invoiceEntity?.laborInvoice?.laborReception?.isNotEmpty ?? false)
                    widgetFactory.laborInvoiceWidget(cubit.invoiceEntity?.laborInvoice),
                  Space.h16,
                  if (cubit.invoiceEntity?.partInvoice?.partReception?.isNotEmpty ?? false)
                    widgetFactory.partInvoiceWidget(cubit.invoiceEntity?.partInvoice),
                  Space.h16,
                  _buildCustomerPriceText(context, cubit.invoiceEntity?.sumAllInvoice?.totalAllItemsCustomer.toString()),
                  Space.h32,
                ],
              ),
            ));
      },
    );
  }
  Widget _buildCustomerPriceText(BuildContext context, String? price) {
    return Row(
      children: [
        Text(
          'هزینه قابل پرداخت مشتری: ',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: AppSize.s16,
          ),
        ),
        Space.w4,
        Expanded(
          child: Text('${price ?? '0'} ریال'.splitPriceByComma(),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: AppSize.s18,

            ),
          ),
        ),
      ],
    );
  }
}


class _InvoiceWidgetFactory {
  final ServiceType? type;

  const _InvoiceWidgetFactory(this.type);

  Widget requestHistoryInvoiceShimmerWidget() {
    return type == ServiceType.aidService
        ? RequestHistoryInvoiceShimmerWidget.aidService()
        : RequestHistoryInvoiceShimmerWidget.homeService();
  }

  Widget sumAllInvoiceWidget(SumAllInvoiceEntity? entity) {
    return type == ServiceType.aidService
        ? SumAllInvoiceWidget.aidService(entity: entity)
        : SumAllInvoiceWidget.homeService(entity: entity);
  }

  Widget detailsInvoiceWidget(DetailsInvoiceEntity? entity) {
    return type == ServiceType.aidService
        ? DetailsInvoiceWidget.aidService(entity: entity)
        : DetailsInvoiceWidget.homeService(entity: entity);
  }

  Widget otherCostInvoiceWidget(OtherCostInvoiceEntity? entity) {
    return type == ServiceType.aidService
        ? OtherCostInvoiceWidget.aidService(entity: entity)
        : OtherCostInvoiceWidget.homeService(entity: entity);
  }

  Widget laborInvoiceWidget(LaborInvoiceEntity? entity) {
    return type == ServiceType.aidService
        ? LaborInvoiceWidget.aidService(entity: entity)
        : LaborInvoiceWidget.homeService(entity: entity);
  }

  Widget partInvoiceWidget(PartInvoiceEntity? entity) {
    return type == ServiceType.aidService
        ? PartInvoiceWidget.aidService(entity: entity)
        : PartInvoiceWidget.homeService(entity: entity);
  }
}*/
