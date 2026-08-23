import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ActionRow(
          title: 'گواهینامه مهارت‌ها',
          icon: Icons.card_membership_outlined,
          isLoading: _loadingAction == _RescuerActionType.certificates,
          onTap: () => _runAction(
            _RescuerActionType.certificates,
            widget.onSkillCertificates,
          ),
        ),
        Divider(height: 1, color: Theme.of(context).dividerColor),
        _ActionRow(
          title: 'تاریخچه',
          icon: Icons.history,
          isLoading: _loadingAction == _RescuerActionType.history,
          onTap: () => _runAction(_RescuerActionType.history, widget.onHistory),
        ),
        Divider(height: 1, color: Theme.of(context).dividerColor),
        _ActionRow(
          title: 'حذف',
          icon: Icons.delete_outline,
          color: colorScheme.error,
          isLoading: _loadingAction == _RescuerActionType.delete,
          onTap: () => _runAction(_RescuerActionType.delete, widget.onDelete),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? color;

  const _ActionRow({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isLoading,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onTertiaryFixed;

    return InkWell(
      onTap: () {
        if (isLoading) return;
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            if (isLoading)
              SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: effectiveColor,
                ),
              )
            else
              Icon(icon, color: effectiveColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: BodyMediumText(
                text: title,
                color: effectiveColor,
                textAlign: TextAlign.right,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
