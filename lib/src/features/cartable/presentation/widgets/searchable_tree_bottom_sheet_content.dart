import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'cartable_tree/cartable_selection_confirm_button.dart';
import 'cartable_tree/cartable_selection_header.dart';
import 'cartable_tree/cartable_tree_callbacks.dart';
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
  final Set<String> _expandedNodeKeys = {};
  Map<String, _TreeNodeSelection> _selectionByNodeKey = {};

  SubordinatedUserEntity? _selectedItem;
  List<SubordinatedUserEntity>? _selectedPath;
  String? _selectedNodeKey;

  bool get _hasSelectedItem {
    return _selectedItem != null &&
        _selectedPath != null &&
        _selectedPath!.isNotEmpty;
  }

  bool get _isSearching {
    return widget.searchController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();

    _expandRootNodes(widget.users);
    _buildSelectionIndex();
  }

  @override
  void didUpdateWidget(
      covariant SearchableTreeBottomSheetContent oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (!identical(oldWidget.users, widget.users)) {
      _expandRootNodes(widget.users);
      _buildSelectionIndex();
    }
  }

  void _expandRootNodes(
      List<SubordinatedUserEntity> users,
      ) {
    for (final user in users) {
      if (user.isRoot == true &&
          user.subordinateds.isNotEmpty) {
        _expandedNodeKeys.add(
          createCartableTreePathKey([user]),
        );
      }
    }
  }

  void _toggleNode(String nodeKey) {
    setState(() {
      if (_expandedNodeKeys.contains(nodeKey)) {
        _expandedNodeKeys.remove(nodeKey);
      } else {
        _expandedNodeKeys.add(nodeKey);
      }
    });
  }

  void _selectNode({
    required SubordinatedUserEntity item,
    required List<SubordinatedUserEntity> path,
    required String nodeKey,
  }) {
    setState(() {
      _selectedItem = item;
      _selectedPath = List.unmodifiable(path);
      _selectedNodeKey = nodeKey;
    });
  }

  Future<void> _confirmSelection() async {
    final selectedItem = _selectedItem;
    final selectedPath = _selectedPath;

    if (selectedItem == null ||
        selectedPath == null ||
        selectedPath.isEmpty) {
      return;
    }

    await widget.onConfirm(
      selectedItem,
      selectedPath,
    );
  }

  void _closeBottomSheet() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(
          AppPadding.p16,
        ),
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
              child: RadioGroup<String>(
                groupValue: _selectedNodeKey,
                onChanged: _onRadioChanged,
                child: CartableTreeView(
                  users: widget.users,
                  expandedNodeKeys: _expandedNodeKeys,
                  selectedNodeKey: _selectedNodeKey,
                  forceExpanded: _isSearching,
                  onToggle: _toggleNode,
                  onSelect: _selectNode,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            CartableSelectionConfirmButton(
              enabled: _hasSelectedItem,
              onPressed: _confirmSelection,
            ),
          ],
        ),
      ),
    );
  }
  void _buildSelectionIndex() {
    final result = <String, _TreeNodeSelection>{};

    void visit({
      required List<SubordinatedUserEntity> items,
      required List<SubordinatedUserEntity> parentPath,
    }) {
      for (final item in items) {
        final currentPath = [
          ...parentPath,
          item,
        ];

        final nodeKey = createCartableTreePathKey(
          currentPath,
        );

        result[nodeKey] = _TreeNodeSelection(
          item: item,
          path: List.unmodifiable(currentPath),
        );

        if (item.subordinateds.isNotEmpty) {
          visit(
            items: item.subordinateds,
            parentPath: currentPath,
          );
        }
      }
    }

    visit(
      items: widget.users,
      parentPath: const [],
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

    _selectNode(
      item: selection.item,
      path: selection.path,
      nodeKey: nodeKey,
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