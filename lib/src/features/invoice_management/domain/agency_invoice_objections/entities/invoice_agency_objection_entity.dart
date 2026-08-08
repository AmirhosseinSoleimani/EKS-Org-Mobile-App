class InvoiceAgencyObjectionEntity {
  const InvoiceAgencyObjectionEntity({required this.id});

  final int id;

  bool get exists => id > 0;
}
