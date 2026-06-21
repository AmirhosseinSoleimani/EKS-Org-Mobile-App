import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_mark_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class PartMarkResponseEntity implements DropdownItem<String?> {
  final String? mark;

  PartMarkResponseModel toModel() {
    return PartMarkResponseModel(mark: mark);
  }

  PartMarkResponseModel copyWith({String? mark}) {
    return PartMarkResponseModel(mark: mark ?? this.mark);
  }

  const PartMarkResponseEntity({this.mark});

  @override
  String get label => mark ?? '';

  @override
  String? get value => mark;

  @override
  Widget? leading(BuildContext context) => null;
}
