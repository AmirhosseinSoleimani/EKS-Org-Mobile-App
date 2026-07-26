import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/cubit/shift_form_cubit.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_form.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShiftFormPage extends StatelessWidget {
  static const path = '/shift-form-page';
  static const name = 'shift-form-page';

  const ShiftFormPage({super.key, this.id});

  final int? id;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<ShiftFormCubit>();
        if (id == null) {
          cubit.createNewForm();
        } else {
          Future<void>.microtask(() => cubit.loadForm(id: id));
        }

        return cubit;
      },
      child: const _ShiftFormView(),
    );
  }
}

class _ShiftFormView extends StatefulWidget {
  const _ShiftFormView();

  @override
  State<_ShiftFormView> createState() => _ShiftFormViewState();
}

class _ShiftFormViewState extends State<_ShiftFormView> {
  ShiftEntity? _item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShiftFormCubit>();

    return BlocListener<ShiftFormCubit, ShiftFormState>(
      listener: (context, state) {
        state.whenOrNull(
          ready: (item, shiftTypes) => _setInitialValue(item),
          validationFailure: (message, item, shiftTypes) {
            _setInitialValue(item);
            SnakeBarWidget.showError(context: context, message: message);
          },
          failure: (message, item, shiftTypes) {
            if (item != null) _setInitialValue(item);
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message) {
            SnakeBarWidget.showSuccess(context: context, message: message);
            context.pop(true);
          },
        );
      },
      child: BlocBuilder<ShiftFormCubit, ShiftFormState>(
        builder: (context, state) {
          state.whenOrNull(
            ready: (item, shiftTypes) => _setInitialValue(
              item,
              shouldNotify: false,
            ),
            submitting: (item, shiftTypes) => _setInitialValue(
              item,
              shouldNotify: false,
            ),
            validationFailure: (message, item, shiftTypes) => _setInitialValue(
              item,
              shouldNotify: false,
            ),
          );

          final isSubmitting = state.maybeWhen(
            submitting: (_, __) => true,
            orElse: () => false,
          );
          final shiftTypes = state.maybeWhen(
            loading: (shiftTypes) => shiftTypes,
            ready: (_, shiftTypes) => shiftTypes,
            submitting: (_, shiftTypes) => shiftTypes,
            validationFailure: (_, __, shiftTypes) => shiftTypes,
            failure: (_, __, shiftTypes) => shiftTypes,
            connectionError: (_, shiftTypes) => shiftTypes,
            orElse: () => cubit.shiftTypes,
          );

          final item = _item;
          final isLoading = state.maybeWhen(
            loading: (_) => true,
            orElse: () => false,
          );

          return state.maybeWhen(
            connectionError: (item, shiftTypes) => _FormMessageScaffold(
              title: _pageTitle(item),
              child: const Text('اتصال به اینترنت برقرار نیست'),
            ),
            orElse: () {
              if (isLoading || item == null) {
                return _FormMessageScaffold(
                  title: _pageTitle(item),
                  child: const CircularProgressIndicator(),
                );
              }

              return ShiftForm(
                item: item,
                shiftTypes: shiftTypes,
                isSubmitting: isSubmitting,
                onSubmit: cubit.submit,
                onCancel: () => context.pop(false),
              );
            },
          );
        },
      ),
    );
  }

  void _setInitialValue(ShiftEntity item, {bool shouldNotify = true}) {
    final current = _item;

    if (current != null &&
        current.id == item.id &&
        current.title == item.title &&
        current.type == item.type &&
        current.startTime == item.startTime &&
        current.endTime == item.endTime &&
        current.isActive == item.isActive) {
      return;
    }

    _item = item;

    if (shouldNotify && mounted) {
      setState(() {});
    }
  }

  String _pageTitle(ShiftEntity? item) {
    return item == null || item.id == null || item.id == 0
        ? 'ثبت شیفت جدید'
        : 'ویرایش شیفت';
  }
}

class _FormMessageScaffold extends StatelessWidget {
  const _FormMessageScaffold({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      appBar: SimpleAppBar(title: title),
      body: Center(child: child),
    );
  }
}
