enum EmdadVehicleActionType {
  tools,
  services,
  edit,
  delete,
  history,
}

class EmdadVehicleAction {
  final EmdadVehicleActionType type;
  final String code;
  final String title;

  const EmdadVehicleAction({
    required this.type,
    required this.code,
    required this.title,
  });
}

abstract final class EmdadVehicleActions {
  static const tools = EmdadVehicleAction(
    type: EmdadVehicleActionType.tools,
    code: 'tools',
    title: 'ابزارها',
  );

  static const services = EmdadVehicleAction(
    type: EmdadVehicleActionType.services,
    code: 'services',
    title: 'سرویس‌ها',
  );

  static const edit = EmdadVehicleAction(
    type: EmdadVehicleActionType.edit,
    code: 'edit',
    title: 'ویرایش',
  );

  static const delete = EmdadVehicleAction(
    type: EmdadVehicleActionType.delete,
    code: 'delete',
    title: 'حذف',
  );

  static const history = EmdadVehicleAction(
    type: EmdadVehicleActionType.history,
    code: 'history',
    title: 'تاریخچه',
  );

  static const values = <EmdadVehicleAction>[
    tools,
    services,
    edit,
    delete,
    history,
  ];
}
