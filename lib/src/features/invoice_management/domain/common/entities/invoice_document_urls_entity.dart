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
}
