enum EmdadgarInvoiceStage {
  initial(
    title: 'اولیه',
    sectionTitle: 'صورت وضعیت های اولیه',
    supportsBulkAccept: true,
  ),
  current(
    title: 'صورت وضعیت',
    sectionTitle: 'صورت وضعیت ها',
    supportsBulkAccept: true,
  ),
  finalApproval(
    title: 'تایید نهایی',
    sectionTitle: 'صورت وضعیت های تایید نهایی',
  ),
  finalCorrection(
    title: 'تایید و اصلاح',
    sectionTitle: 'صورت وضعیت های نهایی (تایید و اصلاح)',
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
