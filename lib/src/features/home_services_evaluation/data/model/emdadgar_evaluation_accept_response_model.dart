import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/emdadgar_evaluation_accept_response_entity.dart';

class EmdadgarEvaluationAcceptResponseModel
    extends EmdadgarEvaluationAcceptResponseEntity {
  EmdadgarEvaluationAcceptResponseModel({super.exportUrls, super.invoiceGuid});

  EmdadgarEvaluationAcceptResponseModel copyWith(
    ExportUrls? exportUrls,
    String? invoiceGuid,
  ) {
    return EmdadgarEvaluationAcceptResponseModel(
      exportUrls: exportUrls ?? this.exportUrls,
      invoiceGuid: invoiceGuid ?? this.invoiceGuid,
    );
  }

  factory EmdadgarEvaluationAcceptResponseModel.fromJson(dynamic json) {
    return EmdadgarEvaluationAcceptResponseModel(
      exportUrls: json['exportUrls'] != null
          ? ExportUrls.fromJson(json["exportUrls"])
          : null,
      invoiceGuid: json['invoiceGuid'] = json["invoiceGuid"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (exportUrls != null) {
      data['exportUrls'] = exportUrls!.toJson();
    }
    if (invoiceGuid != null) {
      data['invoiceGuid'] = invoiceGuid;
    }

    return data;
  }
}

class ExportUrls {
  String? htmlViewUrl;
  String? pdfViewUrl;
  String? pdfDownloadUrl;

  ExportUrls({this.htmlViewUrl, this.pdfViewUrl, this.pdfDownloadUrl});

  ExportUrls.fromJson(Map<String, dynamic> json) {
    htmlViewUrl = json['htmlViewUrl'];
    pdfViewUrl = json['pdfViewUrl'];
    pdfDownloadUrl = json['pdfDownloadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['htmlViewUrl'] = htmlViewUrl;
    data['pdfViewUrl'] = pdfViewUrl;
    data['pdfDownloadUrl'] = pdfDownloadUrl;
    return data;
  }
}
