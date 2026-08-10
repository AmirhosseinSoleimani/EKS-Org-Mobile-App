enum EvaluationAidServicePageMode {
  registration(
    title: 'ثبت فاکتور',
    submitTitle: 'ثبت فاکتور',
    showServiceField: true,
    showDynamicSections: true,
    openInvoiceAfterSubmit: true,
  ),
  statementCorrection(
    title: 'اصلاح صورت وضعیت نماینده',
    submitTitle: 'ذخیره تغییرات',
    showServiceField: false,
    showDynamicSections: false,
    openInvoiceAfterSubmit: false,
  );

  const EvaluationAidServicePageMode({
    required this.title,
    required this.submitTitle,
    required this.showServiceField,
    required this.showDynamicSections,
    required this.openInvoiceAfterSubmit,
  });

  final String title;
  final String submitTitle;
  final bool showServiceField;
  final bool showDynamicSections;
  final bool openInvoiceAfterSubmit;
}
