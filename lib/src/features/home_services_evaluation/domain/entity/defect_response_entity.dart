import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/defect_response_model.dart';

class DefectResponseEntity {
  DefectResponseEntity({
    this.id,
    this.title,
    this.code,
    this.parentId,
    this.parentCode,
    this.saipaYadakEzharCode,
    this.isActive,
  });

  int? id;
  String? title;
  int? parentId;
  int? code;
  String? saipaYadakEzharCode;
  int? parentCode;
  bool? isActive;

  DefectResponseEntity copyWith({
    int? id,
    String? title,
    int? parentId,
    int? code,
    String? saipaYadakEzharCode,
    int? parentCode,
    bool? isActive,
  }) {
    return DefectResponseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      parentId: parentId ?? this.parentId,
      code: code ?? this.code,
      saipaYadakEzharCode: saipaYadakEzharCode ?? this.saipaYadakEzharCode,
      parentCode: parentCode ?? this.parentCode,
      isActive: isActive ?? this.isActive,
    );
  }

  DefectResponseModel toModel() {
    return DefectResponseModel(
      id: id,
      title: title,
      code: code,
      parentId: parentId,
      saipaYadakEzharCode: saipaYadakEzharCode,
      parentCode: parentCode,
      isActive: isActive,
    );
  }
}
