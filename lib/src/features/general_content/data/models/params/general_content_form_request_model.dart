import 'dart:typed_data';

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

  bool get hasFile {
    final hasBytes = fileBytes?.isNotEmpty == true;
    final hasPath = filePath?.trim().isNotEmpty == true;
    return hasBytes || hasPath;
  }

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

    if (includeFile) {
      final bytes = fileBytes;
      final path = filePath;

      if (bytes?.isNotEmpty == true) {
        map['file'] = MultipartFile.fromBytes(
          bytes!,
          filename: fileName ?? 'general-content-file',
        );
      } else if (path?.trim().isNotEmpty == true) {
        map['file'] = await MultipartFile.fromFile(
          path!,
          filename: fileName,
        );
      }
    }

    return FormData.fromMap(map);
  }
}
