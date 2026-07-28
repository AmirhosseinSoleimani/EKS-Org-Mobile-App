import 'package:dio/dio.dart';

class GeneralContentFormRequestModel {
  const GeneralContentFormRequestModel({
    this.id,
    required this.title,
    required this.startDate,
    required this.applyDate,
    required this.description,
    required this.contentType,
    required this.receiverType,
    required this.isActive,
    this.filePath,
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

  Future<FormData> toFormData({bool includeFile = false}) async {
    final map = <String, dynamic>{
      if (id != null) 'id': id,
      'title': title,
      'startDate': startDate,
      'applyDate': applyDate,
      'description': description,
      'contentType': contentType,
      'receiverType': receiverType,
      'isActive': isActive,
    };

    final path = filePath;
    if (includeFile && path != null && path.trim().isNotEmpty) {
      map['file'] = await MultipartFile.fromFile(path);
    }

    return FormData.fromMap(map);
  }
}
