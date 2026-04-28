
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

import 'request_card.dart';

class RequestListViewer extends StatefulWidget {
  final List<BaseRequestEntity> items;
  final Function(BaseRequestEntity) onSelected;
  final VoidCallback onLoadMore;
  final bool hasMore;
  final int totalCount;

  const RequestListViewer({
    super.key,
    required this.items,
    required this.onSelected,
    required this.onLoadMore,
    required this.hasMore,
    required this.totalCount,
  });

  @override
  State<RequestListViewer> createState() => _RequestListViewerState();
}

class _RequestListViewerState extends State<RequestListViewer> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.hasMore) return;
    if (!_controller.hasClients) return;

    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.hasMore ? widget.items.length + 1 : widget.items.length;
    if (itemCount < 1) {
      return const EmptyListWidget();
    }
    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0 && widget.totalCount > 0) {
          return BodyMediumText(text: '${widget.totalCount} درخواست');
        }

        final adjustedIndex = index - 1;

        if (adjustedIndex >= widget.items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
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
    return "";
  }
}
