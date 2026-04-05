enum InvoiceType {
  preInvoice,
  invoice,
}

extension InvoiceTypeTitle on InvoiceType {
  String get title {
    switch (this) {
      case InvoiceType.preInvoice:
        return 'پیش فاکتور';
      case InvoiceType.invoice:
        return 'فاکتور';
    }
  }
}
