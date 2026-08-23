import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_form_cubit.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_form_state.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_date_formatter.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_area_product_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_general_info_section.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_priority_section.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/discountable_area_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SpecialPlanFormPageArgs {
  const SpecialPlanFormPageArgs({this.plan});

  final SpecialPlanEntity? plan;
}

class SpecialPlanFormPage extends StatelessWidget {
  static const path = '/special-plan-form-page';
  static const name = 'special-plan-form-page';

  const SpecialPlanFormPage({
    super.key,
    this.initialPlan,
  });

  final SpecialPlanEntity? initialPlan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SpecialPlanFormCubit>()..initialize(),
      child: _SpecialPlanFormView(initialPlan: initialPlan),
    );
  }
}

class _SpecialPlanFormView extends StatefulWidget {
  const _SpecialPlanFormView({this.initialPlan});

  final SpecialPlanEntity? initialPlan;

  @override
  State<_SpecialPlanFormView> createState() => _SpecialPlanFormViewState();
}

class _SpecialPlanFormViewState extends State<_SpecialPlanFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final TextEditingController _orderController;
  SpecialPlanProductEntity? _selectedProduct;
  DiscountableAreaEntity? _selectedArea;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isActive = true;
  bool _hasHighPriority = false;
  bool _onlySaipaCars = true;
  bool _didSyncSelections = false;

  bool get _isEdit => widget.initialPlan?.id != null;

  @override
  void initState() {
    super.initState();
    final item = widget.initialPlan;
    _titleController = TextEditingController(text: item?.title ?? '');
    _startDateController = TextEditingController(
      text: item?.startDate == null
          ? ''
          : SpecialPlanDateFormatter.jalaliDate(item?.startDate),
    );
    _endDateController = TextEditingController(
      text: item?.endDate == null
          ? ''
          : SpecialPlanDateFormatter.jalaliDate(item?.endDate),
    );
    _orderController = TextEditingController(
      text: item?.orderNo?.toString() ?? '',
    );
    _startDate = item?.startDate?.toLocal();
    _endDate = item?.endDate?.toLocal();
    _isActive = item?.isActive ?? true;
    _hasHighPriority = item?.hasHighPriority ?? false;
    _onlySaipaCars = item?.onlySaipaCars ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<SpecialPlanFormCubit, SpecialPlanFormState>(
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
            context.read<SpecialPlanFormCubit>().clearErrorMessage();
          }
        },
        builder: (context, state) {
          _syncSelections(state);
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: SimpleAppBar(
              title: _isEdit ? 'ویرایش طرح ویژه' : 'افزودن طرح ویژه جدید',
              onBack: () {
                if (state.isSubmitting) return;
                context.pop(false);
              },
            ),
            body: _buildBody(context, state),
            bottomNavigationBar: state.isLoading || state.loadFailed
                ? null
                : StickyFormActionBar(
                    submitTitle: _isEdit ? 'ویرایش' : 'افزودن',
                    cancelTitle: 'انصراف',
                    isSubmitting: state.isSubmitting,
                    onCancel: () {
                      if (state.isSubmitting) return;
                      context.pop(false);
                    },
                    onSubmit: () {
                      if (state.isSubmitting) return;
                      _submit(context);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SpecialPlanFormState state) {
    if (state.isLoading) {
      return const Center(child: LoadingWidget());
    }
    if (state.loadFailed) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyListWidget(),
            Space.h12,
            SizedBox(
              width: AppSize.s150,
              child: InkwellButtonWidget(
                title: 'تلاش مجدد',
                onTap: () {
                  if (state.isLoading) return;
                  context.read<SpecialPlanFormCubit>().initialize();
                },
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      top: false,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.stylus,
          },
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                SpecialPlanGeneralInfoSection(
                  titleController: _titleController,
                  startDateController: _startDateController,
                  endDateController: _endDateController,
                  startDate: _startDate,
                  endDate: _endDate,
                  isActive: _isActive,
                  requiredValidator: _required,
                  onStartDateChanged: (value) =>
                      setState(() => _startDate = value),
                  onEndDateChanged: (value) =>
                      setState(() => _endDate = value),
                  onStatusChanged: (value) =>
                      setState(() => _isActive = value),
                ),
                SpecialPlanAreaProductSection(
                  areas: state.discountableAreas,
                  products: state.products,
                  selectedArea: _selectedArea,
                  selectedProduct: _selectedProduct,
                  onAreaChanged: (value) =>
                      setState(() => _selectedArea = value),
                  onProductChanged: (value) =>
                      setState(() => _selectedProduct = value),
                ),
                SpecialPlanPrioritySection(
                  orderController: _orderController,
                  hasHighPriority: _hasHighPriority,
                  onlySaipaCars: _onlySaipaCars,
                  onHighPriorityChanged: (value) =>
                      setState(() => _hasHighPriority = value),
                  onOnlySaipaCarsChanged: (value) =>
                      setState(() => _onlySaipaCars = value),
                ),
                Space.h80,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _syncSelections(SpecialPlanFormState state) {
    if (_didSyncSelections || state.isLoading) return;
    final item = widget.initialPlan;
    if (item != null) {
      _selectedProduct = _findProduct(state, item);
      _selectedArea = _findArea(state, item);
    }
    _didSyncSelections = true;
  }

  SpecialPlanProductEntity? _findProduct(
    SpecialPlanFormState state,
    SpecialPlanEntity item,
  ) {
    final id = item.productId;
    if (id == null) return null;
    for (final product in state.products) {
      if (product.id == id) return product;
    }
    return SpecialPlanProductEntity(
      id: id,
      title: item.productTitle?.trim().isNotEmpty == true
          ? item.productTitle!.trim()
          : 'محصول شماره $id',
    );
  }

  DiscountableAreaEntity? _findArea(
    SpecialPlanFormState state,
    SpecialPlanEntity item,
  ) {
    final id = item.areaBaseInfoId;
    if (id == null || id <= 0) return null;
    for (final area in state.discountableAreas) {
      if (area.id == id) return area;
    }
    return DiscountableAreaEntity(
      id: id,
      areaTitle: item.displayAreaTitle,
    );
  }

  String? _required(String? value) =>
      value?.trim().isEmpty ?? true ? 'این فیلد الزامی است.' : null;

  Future<void> _submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_startDate == null || _endDate == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'تاریخ شروع و پایان را انتخاب کنید.',
      );
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      SnakeBarWidget.showError(
        context: context,
        message: 'تاریخ پایان نمی‌تواند قبل از تاریخ شروع باشد.',
      );
      return;
    }
    final areaId = _selectedArea?.id;
    if (areaId == null || areaId <= 0) {
      SnakeBarWidget.showError(
        context: context,
        message: 'محدوده جغرافیایی را انتخاب کنید.',
      );
      return;
    }

    final success = await context.read<SpecialPlanFormCubit>().submit(
          SpecialPlanFormParamEntity(
            id: widget.initialPlan?.id,
            title: _titleController.text.trim(),
            productId: _selectedProduct?.id,
            startDate: _startDate!,
            endDate: _endDate!,
            areaBaseInfoId: areaId,
            hasHighPriority: _hasHighPriority,
            orderNo: int.tryParse(_orderController.text.trim()) ?? 0,
            isActive: _isActive,
            onlySaipaCars: _onlySaipaCars,
          ),
        );
    if (context.mounted && success) context.pop(true);
  }
}
