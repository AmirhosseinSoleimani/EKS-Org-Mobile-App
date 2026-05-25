import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showServiceActionBottomSheet({
  required BuildContext context,
  required String title,
  required WidgetBuilder contentBuilder,
  required WidgetBuilder actionsBuilder,
  bool showDivider = false,
  WidgetBuilder? topContentBuilder,
}) async {
  final cubit = context.read<AssignAndCancelEmdadgarCubit>();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    builder: (bottomSheetContext) {
      final bottomInset = MediaQuery.of(bottomSheetContext).viewInsets.bottom;

      return BlocProvider.value(
        value: cubit,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SizedBox(
            height: MediaQuery.of(bottomSheetContext).size.height,
            child: SafeArea(
              child: Column(
                children: [
                  BottomSheetHeader(title: title),
                  if (topContentBuilder != null)
                    topContentBuilder(bottomSheetContext),

                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: contentBuilder(bottomSheetContext),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: actionsBuilder(bottomSheetContext),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
