import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showServiceActionBottomSheet<C extends Cubit<Object?>>({
  required BuildContext context,
  required String title,
  required WidgetBuilder contentBuilder,
  required WidgetBuilder actionsBuilder,
  bool showDivider = false,
  WidgetBuilder? topContentBuilder,
  required C cubit,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    builder: (bottomSheetContext) {
      final bottomInset = MediaQuery.of(bottomSheetContext).viewInsets.bottom;

      return BlocProvider<C>.value(
        value: cubit,
        child: Builder(
          builder: (providerContext) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: bottomInset),
              child: SizedBox(
                height: MediaQuery.of(providerContext).size.height,
                child: SafeArea(
                  child: Column(
                    children: [
                      BottomSheetHeader(title: title),

                      if (topContentBuilder != null)
                        topContentBuilder(providerContext),

                      if (showDivider) const Divider(height: 1),

                      Expanded(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: contentBuilder(providerContext),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: actionsBuilder(providerContext),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}