import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';

import 'request_card.dart';

class RequestListViewer extends StatefulWidget {
  final List<BaseRequestEntity> items;
  final Function(BaseRequestEntity) onSelected;
  final VoidCallback onLoadMore;
  final bool hasMore;
  final int totalCount;
  final FutureOr<void> Function()? onRefreshAfterReturn;

  const RequestListViewer({
    super.key,
    required this.items,
    required this.onSelected,
    required this.onLoadMore,
    required this.hasMore,
    required this.totalCount,
    required this.onRefreshAfterReturn,
  });

  @override
  State<RequestListViewer> createState() => _RequestListViewerState();
}

class _RequestListViewerState extends State<RequestListViewer> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.hasMore || !_controller.hasClients) return;

    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.hasMore
        ? widget.items.length + 1
        : widget.items.length;

    if (itemCount < 1) {
      return const EmptyListWidget();
    }

    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: itemCount + 1,
      separatorBuilder: (context, index) =>
          SizedBox(height: index == 0 ? 0 : 16),
      itemBuilder: (context, index) {
        if (index == 0 && widget.totalCount > 0) {
          return const SizedBox();
        }

        final adjustedIndex = index - 1;
        if (adjustedIndex >= widget.items.length) {
          return Center(
            child: CircularProgressIndicator(
              color: widget.items.first.serviceType?.serviceColor,
            ),
          );
        }

        final item = widget.items[adjustedIndex];
        return RequestCard(
          request: item,
          serviceTitle: _resolveServiceTitle(item),
          serviceColor: item.serviceType?.serviceColor ??
              ServiceType.reliefService.serviceColor,
          serviceIcon: Icons.build,
          onSelected: widget.onSelected,
          onRefreshAfterReturn: widget.onRefreshAfterReturn,
        );
      },
    );
  }

  String _resolveServiceTitle(BaseRequestEntity entity) {
    if (entity is ReliefRequestEntity) {
      return entity.defectTitle ?? '';
    }
    if (entity is HomeServiceRequestEntity) {
      return entity.emdadServiceCategoryTitle ?? '';
    }
    return '';
  }
}
