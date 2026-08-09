enum InvoiceType {
  preInvoice(title: 'پیش فاکتور'),
  invoice(title: 'فاکتور');

  final String title;

  const InvoiceType({required this.title});

  String get detailsTitle => 'مشاهده جزئیات $title';
}
