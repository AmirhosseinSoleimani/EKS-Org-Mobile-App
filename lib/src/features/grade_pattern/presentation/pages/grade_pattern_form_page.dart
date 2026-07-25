import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_form.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GradePatternFormPage extends StatelessWidget {
  static const path = '/grade-pattern-form-page';
  static const name = 'grade-pattern-form-page';

  const GradePatternFormPage({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<GradePatternCubit>();
        Future<void>.microtask(() => cubit.loadForm(id: id));
        return cubit;
      },
      child: const _GradePatternFormView(),
    );
  }
}

class _GradePatternFormView extends StatefulWidget {
  const _GradePatternFormView();

  @override
  State<_GradePatternFormView> createState() => _GradePatternFormViewState();
}

class _GradePatternFormViewState extends State<_GradePatternFormView> {
  GradePatternEntity? _item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GradePatternCubit>();

    return BlocListener<GradePatternCubit, GradePatternState>(
      listener: (context, state) {
        state.whenOrNull(
          formReady: _setInitialValue,
          failure: (message, items) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message, items) {
            SnakeBarWidget.showSuccess(context: context, message: message);
            context.pop(true);
          },
        );
      },
      child: BlocBuilder<GradePatternCubit, GradePatternState>(
        builder: (context, state) {
          state.whenOrNull(
            formReady: (item) => _setInitialValue(item, shouldNotify: false),
          );

          final isSubmitting = state.maybeWhen(
            submitting: (_, __) => true,
            orElse: () => false,
          );
          final item = _item;
          final isDetailLoading = state.maybeWhen(
            detailLoading: (_) => true,
            orElse: () => false,
          );

          return state.maybeWhen(
            connectionError: (_, __) => _FormMessageScaffold(
              title: _pageTitle,
              child: const Text('اتصال به اینترنت برقرار نیست'),
            ),
            orElse: () {
              if (isDetailLoading || item == null) {
                return _FormMessageScaffold(
                  title: _pageTitle,
                  child: const CircularProgressIndicator(),
                );
              }

              return GradePatternForm(
                item: item,
                isSubmitting: isSubmitting,
                onSubmit: (value) {
                  cubit.submit(value);
                },
                onCancel: () => context.pop(false),
              );
            },
          );
        },
      ),
    );
  }

  void _setInitialValue(
    GradePatternEntity item, {
    bool shouldNotify = true,
  }) {
    if (_item?.id == item.id && _item?.details.length == item.details.length) {
      return;
    }
    _item = item;
    if (shouldNotify) {
      setState(() {});
    }
  }

  String get _pageTitle {
    final item = _item;
    return item == null || item.id == null || item.id == 0
        ? 'افزودن الگوی گرید'
        : 'ویرایش الگوی گرید';
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
