import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';

class InvoiceDocumentUrlsEntity {
  const InvoiceDocumentUrlsEntity({
    this.htmlViewUrl,
    this.htmlDownloadUrl,
    this.pdfViewUrl,
    this.pdfDownloadUrl,
  });

  final String? htmlViewUrl;
  final String? htmlDownloadUrl;
  final String? pdfViewUrl;
  final String? pdfDownloadUrl;

  bool get hasAnyUrl =>
      htmlViewUrl != null ||
      htmlDownloadUrl != null ||
      pdfViewUrl != null ||
      pdfDownloadUrl != null;

  InvoiceDocumentUrlsModel toModel() {
    return InvoiceDocumentUrlsModel(
      htmlViewUrl: htmlViewUrl,
      htmlDownloadUrl: htmlDownloadUrl,
      pdfViewUrl: pdfViewUrl,
      pdfDownloadUrl: pdfDownloadUrl,
    );
  }
}
