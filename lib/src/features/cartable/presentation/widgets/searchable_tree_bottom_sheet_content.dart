import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'cartable_tree/cartable_selection_confirm_button.dart';
import 'cartable_tree/cartable_selection_header.dart';
import 'cartable_tree/cartable_tree_callbacks.dart';
import 'cartable_tree/cartable_tree_selection_controller.dart';
import 'cartable_tree/cartable_tree_utils.dart';
import 'cartable_tree/cartable_tree_view.dart';
import 'search_input_field.dart';

class SearchableTreeBottomSheetContent extends StatefulWidget {
  final TextEditingController searchController;
  final String hintText;
  final List<SubordinatedUserEntity> users;
  final ValueChanged<String>? onSearchChanged;
  final CartableSelectionCallback onConfirm;

  const SearchableTreeBottomSheetContent({
    super.key,
    required this.searchController,
    required this.hintText,
    required this.users,
    required this.onConfirm,
    this.onSearchChanged,
  });

  @override
  State<SearchableTreeBottomSheetContent> createState() =>
      _SearchableTreeBottomSheetContentState();
}

class _SearchableTreeBottomSheetContentState
    extends State<SearchableTreeBottomSheetContent> {
  final CartableTreeSelectionController _selectionController =
      CartableTreeSelectionController();

  Map<String, _TreeNodeSelection> _selectionByNodeKey = {};

  bool get _isSearching {
    return widget.searchController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _buildSelectionIndex();
  }

  @override
  void didUpdateWidget(
    covariant SearchableTreeBottomSheetContent oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (!identical(oldWidget.users, widget.users)) {
      _buildSelectionIndex();
    }
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  void _selectNode({
    required SubordinatedUserEntity item,
    required List<SubordinatedUserEntity> path,
    required String nodeKey,
  }) {
    _selectionController.select(
      nodeKey: nodeKey,
      item: item,
      path: path,
    );
  }

  Future<void> _confirmSelection() async {
    final selection = _selectionController.selectedSelection.value;

    if (selection == null) {
      return;
    }

    await widget.onConfirm(
      selection.item,
      selection.path,
    );
  }

  void _closeBottomSheet() {
    Navigator.of(context).pop();
  }

  void _buildSelectionIndex() {
    final result = <String, _TreeNodeSelection>{};

    void visit({
      required List<SubordinatedUserEntity> items,
      required List<SubordinatedUserEntity> parentPath,
      required String parentNodeKey,
    }) {
      for (final item in items) {
        final currentPath = <SubordinatedUserEntity>[...parentPath, item];
        final currentSegment = createCartableTreeNodeSegment(item);
        final nodeKey = parentNodeKey.isEmpty
            ? currentSegment
            : '$parentNodeKey>$currentSegment';

        result[nodeKey] = _TreeNodeSelection(
          item: item,
          path: List<SubordinatedUserEntity>.unmodifiable(currentPath),
        );

        if (item.subordinateds.isNotEmpty) {
          visit(
            items: item.subordinateds,
            parentPath: currentPath,
            parentNodeKey: nodeKey,
          );
        }
      }
    }

    visit(
      items: widget.users,
      parentPath: const <SubordinatedUserEntity>[],
      parentNodeKey: '',
    );

    _selectionByNodeKey = result;
  }

  void _onRadioChanged(String? nodeKey) {
    if (nodeKey == null) {
      return;
    }

    final selection = _selectionByNodeKey[nodeKey];

    if (selection == null) {
      return;
    }

    _selectionController.select(
      nodeKey: nodeKey,
      item: selection.item,
      path: selection.path,
    );
  }

  @override
  Widget build(BuildContext context) {
    final treeView = CartableTreeView(
      users: widget.users,
      forceExpanded: _isSearching,
      selectionController: _selectionController,
      onSelect: _selectNode,
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CartableSelectionHeader(
              onClose: _closeBottomSheet,
            ),
            const SizedBox(height: AppSize.s16),
            SearchInputField(
              controller: widget.searchController,
              hintText: widget.hintText,
              onChanged: widget.onSearchChanged,
            ),
            const SizedBox(height: AppSize.s16),
            Expanded(
              child: ValueListenableBuilder<String?>(
                valueListenable: _selectionController.selectedNodeKey,
                child: treeView,
                builder: (context, selectedNodeKey, child) {
                  return RadioGroup<String>(
                    groupValue: selectedNodeKey,
                    onChanged: _onRadioChanged,
                    child: child!,
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s16),
            ValueListenableBuilder<CartableTreeSelection?>(
              valueListenable: _selectionController.selectedSelection,
              builder: (context, selection, _) {
                return CartableSelectionConfirmButton(
                  enabled: selection != null,
                  onPressed: _confirmSelection,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TreeNodeSelection {
  final SubordinatedUserEntity item;
  final List<SubordinatedUserEntity> path;

  const _TreeNodeSelection({
    required this.item,
    required this.path,
  });
}
