enum EmdadgarInvoiceStage {
  initial(
    title: 'اولیه',
    sectionTitle: 'صورت وضعیت های اولیه',
    supportsBulkAccept: true,
  ),
  current(
    title: 'صورت وضعیت ها',
    sectionTitle: 'صورت وضعیت ها',
    supportsBulkAccept: true,
  ),
  finalApproval(
    title: 'تایید نهایی',
    sectionTitle: 'صورت وضعیت های تایید نهایی',
    supportsBulkAccept: true,
  ),
  finalCorrection(
    title: 'تایید و اصلاح',
    sectionTitle: 'صورت وضعیت های نهایی (تایید و اصلاح)',
    supportsBulkAccept: true,
  ),
  taxpayerFinal(
    title: 'قطعی مودیان',
    sectionTitle: 'صورت وضعیت های قطعی مودیان',
  );

  const EmdadgarInvoiceStage({
    required this.title,
    required this.sectionTitle,
    this.supportsBulkAccept = false,
  });

  final String title;
  final String sectionTitle;
  final bool supportsBulkAccept;
}
