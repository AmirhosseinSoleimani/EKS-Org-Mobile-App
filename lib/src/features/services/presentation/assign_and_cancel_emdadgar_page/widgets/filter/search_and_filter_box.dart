import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SearchAndFilterBox extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onOpenFilter;
  final VoidCallback onRefresh;

  const SearchAndFilterBox({
    super.key,
    required this.isLoading,
    required this.onOpenFilter,
    required this.onRefresh,
  });

  static const double _controlHeight = AppSize.s40;
  static const double _borderRadius = AppSize.s6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final foregroundColor = colorScheme.onPrimaryFixed;
    final borderColor = colorScheme.secondaryContainer;
    final backgroundColor = colorScheme.onPrimary;

    final decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(_borderRadius),
      border: Border.all(color: borderColor, width: AppSize.s1),
      boxShadow: [
        BoxShadow(
          color: colorScheme.shadow.withOpacity(0.08),
          blurRadius: AppSize.s8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: _controlHeight,
              child: DecoratedBox(
                decoration: decoration,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    onTap: onOpenFilter,
                    child: AbsorbPointer(
                      child: TextField(
                        readOnly: true,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: foregroundColor,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'جستجو و فیلتر',
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: foregroundColor,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: AppSize.s22,
                            color: foregroundColor,
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: AppSize.s40,
                            minHeight: _controlHeight,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsetsDirectional.only(
                            start: AppPadding.p2,
                            end: AppPadding.p10,
                            top: AppPadding.p10,
                            bottom: AppPadding.p10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Space.w8,
          _AnimatedRefreshButton(
            isLoading: isLoading,
            onTap: onRefresh,
            decoration: decoration,
            iconColor: foregroundColor,
          ),
        ],
      ),
    );
  }
}

class _AnimatedRefreshButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final BoxDecoration decoration;
  final Color iconColor;

  const _AnimatedRefreshButton({
    required this.isLoading,
    required this.onTap,
    required this.decoration,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: SearchAndFilterBox._controlHeight,
      child: DecoratedBox(
        decoration: decoration,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(SearchAndFilterBox._borderRadius),
          child: InkWell(
            borderRadius:
                BorderRadius.circular(SearchAndFilterBox._borderRadius),
            onTap: isLoading ? null : onTap,
            child: Center(
              child: AnimatedRotation(
                turns: isLoading ? 1 : 0,
                duration: DurationConstant.d1000,
                child: Icon(
                  Icons.sync,
                  size: AppSize.s22,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
