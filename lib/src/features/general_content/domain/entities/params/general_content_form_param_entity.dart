import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_form_request_model.dart';

class GeneralContentFormParamEntity {
  const GeneralContentFormParamEntity({
    this.id,
    required this.title,
    required this.startDate,
    required this.applyDate,
    required this.description,
    required this.contentType,
    required this.receiverType,
    required this.isActive,
    this.filePath,
    this.fileBytes,
    this.fileName,
  });

  final int? id;
  final String title;
  final String startDate;
  final String applyDate;
  final String description;
  final int contentType;
  final int receiverType;
  final bool isActive;
  final String? filePath;
  final Uint8List? fileBytes;
  final String? fileName;

  GeneralContentFormRequestModel toModel() {
    return GeneralContentFormRequestModel(
      id: id,
      title: title,
      startDate: startDate,
      applyDate: applyDate,
      description: description,
      contentType: contentType,
      receiverType: receiverType,
      isActive: isActive,
      filePath: filePath,
      fileBytes: fileBytes,
      fileName: fileName,
    );
  }
}
