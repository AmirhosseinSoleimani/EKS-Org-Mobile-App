import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class RescuerActionsBottomSheet extends StatelessWidget {
  final Future<bool> Function() onSkillCertificates;
  final Future<bool> Function() onHistory;
  final Future<bool> Function() onDelete;

  const RescuerActionsBottomSheet({
    super.key,
    required this.onSkillCertificates,
    required this.onHistory,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return _RescuerActionsContent(
      onSkillCertificates: onSkillCertificates,
      onHistory: onHistory,
      onDelete: onDelete,
    );
  }
}

enum _RescuerActionType { certificates, history, delete }

class _RescuerActionsContent extends StatefulWidget {
  final Future<bool> Function() onSkillCertificates;
  final Future<bool> Function() onHistory;
  final Future<bool> Function() onDelete;

  const _RescuerActionsContent({
    required this.onSkillCertificates,
    required this.onHistory,
    required this.onDelete,
  });

  @override
  State<_RescuerActionsContent> createState() => _RescuerActionsContentState();
}

class _RescuerActionsContentState extends State<_RescuerActionsContent> {
  _RescuerActionType? _loadingAction;

  bool get _isLoading => _loadingAction != null;

  Future<void> _runAction(
    _RescuerActionType action,
    Future<bool> Function() callback,
  ) async {
    if (_isLoading) return;

    setState(() => _loadingAction = action);
    await callback();

    if (!mounted) return;
    setState(() => _loadingAction = null);
  }

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).dividerColor,
    );

    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            title: 'گواهینامه مهارت‌ها',
            icon: Icons.card_membership_outlined,
            isLoading: _loadingAction == _RescuerActionType.certificates,
            onTap: () => _runAction(
              _RescuerActionType.certificates,
              widget.onSkillCertificates,
            ),
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            title: 'تاریخچه',
            icon: Icons.history,
            isLoading: _loadingAction == _RescuerActionType.history,
            onTap: () =>
                _runAction(_RescuerActionType.history, widget.onHistory),
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            title: 'حذف',
            icon: Icons.delete_outline,
            isDestructive: true,
            isLoading: _loadingAction == _RescuerActionType.delete,
            onTap: () =>
                _runAction(_RescuerActionType.delete, widget.onDelete),
          ),
        ),
      ],
    );
  }
}
