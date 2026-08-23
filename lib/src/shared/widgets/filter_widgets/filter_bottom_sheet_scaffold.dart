import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetScaffold extends StatelessWidget {
  static const double fieldSpacing = AppSize.s22;
  static const Widget fieldGap = SizedBox(height: fieldSpacing);

  const FilterBottomSheetScaffold({
    super.key,
    required this.title,
    required this.child,
    required this.onApply,
    required this.onClear,
    this.applyTitle = 'اعمال فیلتر',
    this.clearTitle = 'پاک کردن',
    this.applyButtonColor,
    this.heightFactor = 0.78,
    this.shrinkWrapContent = false,
  });

  final String title;
  final Widget child;
  final VoidCallback onApply;
  final VoidCallback onClear;
  final String applyTitle;
  final String clearTitle;
  final Color? applyButtonColor;
  final double heightFactor;
  final bool shrinkWrapContent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final sheet = Column(
      mainAxisSize:
          shrinkWrapContent ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(theme),
        if (shrinkWrapContent)
          Flexible(
            fit: FlexFit.loose,
            child: _buildScrollableContent(),
          )
        else
          Expanded(child: _buildScrollableContent()),
        _buildActions(theme),
      ],
    );

    return SafeArea(
      top: false,
      child: shrinkWrapContent
          ? ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * heightFactor,
              ),
              child: sheet,
            )
          : SizedBox(
              height: MediaQuery.sizeOf(context).height * heightFactor,
              child: sheet,
            ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p16,
      ),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: child,
    );
  }

  Widget _buildActions(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p12,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkwellButtonWidget(
              title: applyTitle,
              backgroundColor: applyButtonColor,
              onTap: onApply,
            ),
          ),
          Space.w12,
          Expanded(
            child: InkwellButtonWidget(
              title: clearTitle,
              backgroundColor: theme.colorScheme.onPrimary,
              borderColor: theme.colorScheme.outline.withAlpha(153),
              titleColor: theme.colorScheme.onSurface,
              onTap: onClear,
            ),
          ),
        ],
      ),
    );
  }
}

Future<T?> showFilterBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool showDragHandle = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    showDragHandle: showDragHandle,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSize.s20),
      ),
    ),
    builder: builder,
  );
}
