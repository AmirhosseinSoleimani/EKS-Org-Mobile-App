enum EvaluationAidServicePageMode {
  registration(
    title: 'ثبت فاکتور',
    submitTitle: 'ثبت فاکتور',
    showServiceField: true,
    showDynamicSections: true,
    openInvoiceAfterSubmit: true,
  ),
  customerInvoiceCorrection(
    title: 'اصلاح فاکتور مشتری',
    submitTitle: 'ادامه',
    showServiceField: true,
    showDynamicSections: true,
    openInvoiceAfterSubmit: false,
  ),
  statementCorrection(
    title: 'اصلاح صورت وضعیت نماینده',
    submitTitle: 'ذخیره تغییرات',
    showServiceField: false,
    showDynamicSections: true,
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

enum EvaluationAidServiceSubmitFlow {
  standard,
  customerCorrection,
  emdadgarCorrection,
  hesabdari,
  daraei,
}

class EvaluationAidServicePageArgs {
  const EvaluationAidServicePageArgs({
    this.mode = EvaluationAidServicePageMode.registration,
    this.submitFlow = EvaluationAidServiceSubmitFlow.standard,
    this.editInvoiceBaseForm = true,
    this.editKilometer = true,
    this.editLaborAndPart = true,
  });

  final EvaluationAidServicePageMode mode;
  final EvaluationAidServiceSubmitFlow submitFlow;
  final bool editInvoiceBaseForm;
  final bool editKilometer;
  final bool editLaborAndPart;
}
