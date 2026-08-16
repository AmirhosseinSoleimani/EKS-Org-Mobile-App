import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';

class InvoiceDocumentUrlsModel extends InvoiceDocumentUrlsEntity {
  const InvoiceDocumentUrlsModel({
    super.htmlViewUrl,
    super.htmlDownloadUrl,
    super.pdfViewUrl,
    super.pdfDownloadUrl,
  });

  factory InvoiceDocumentUrlsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDocumentUrlsModel(
      htmlViewUrl: JsonValueReader.stringValue(json['htmlViewUrl']),
      htmlDownloadUrl: JsonValueReader.stringValue(json['htmlDownloadUrl']),
      pdfViewUrl: JsonValueReader.stringValue(json['pdfViewUrl']),
      pdfDownloadUrl: JsonValueReader.stringValue(json['pdfDownloadUrl']),
    );
  }
}
