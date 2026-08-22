import '../../domain/entities/evaluation_history_item_entity.dart';

class EvaluationHistoryItemModel extends EvaluationHistoryItemEntity {
  const EvaluationHistoryItemModel({
    super.id,
    super.firstName,
    super.lastName,
    super.insertUserName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.defectInfoTitle,
    super.emdadServiceCategoryTitle,
    super.distanceToCustomer,
    super.distanceHamlCustomer,
    super.isAccepted,
    super.stopTime,
    super.useDakal,
    super.payAvarezi,
    super.emdadgarNavganTypeTitle,
    super.arriveDateTime,
    super.arriveDateTimeJalali,
    super.endWorkDateTime,
    super.endWorkDateTimeJalali,
    super.assignTrackerName,
    super.arriveTrackerName,
    super.endWorkTrackerName,
    super.invoiceId,
    super.statusTitle,
    super.hasImage,
    super.description,
    super.cancelReasonTitle,
    super.cancelReasonDetailTitle,
  });

  factory EvaluationHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return EvaluationHistoryItemModel(
      id: _asInt(_read(json, 'id')),
      firstName: _asString(_read(json, 'firstName')),
      lastName: _asString(_read(json, 'lastName')),
      insertUserName: _asString(_read(json, 'insertUserName')),
      insertDateTime: _asString(_read(json, 'insertDateTime')),
      insertDateTimeJalali: _asString(_read(json, 'insertDateTimeJalali')),
      defectInfoTitle: _asString(_read(json, 'defectInfoTitle')),
      emdadServiceCategoryTitle:
          _asString(_read(json, 'emdadServiceCategoryTitle')),
      distanceToCustomer: _asDouble(_read(json, 'distanceToCustomer')),
      distanceHamlCustomer: _asDouble(_read(json, 'distanceHamlCustomer')),
      isAccepted: _asBool(_read(json, 'isAccepted')),
      stopTime: _asInt(_read(json, 'stopTime')),
      useDakal: _asBool(_read(json, 'useDakal')),
      payAvarezi: _asBool(_read(json, 'payAvarezi')),
      emdadgarNavganTypeTitle:
          _asString(_read(json, 'emdadgarNavganTypeTitle')),
      arriveDateTime: _asString(_read(json, 'arriveDateTime')),
      arriveDateTimeJalali:
          _asString(_read(json, 'arriveDateTimeJalali')),
      endWorkDateTime: _asString(_read(json, 'endWorkDateTime')),
      endWorkDateTimeJalali:
          _asString(_read(json, 'endWorkDateTimeJalali')),
      assignTrackerName: _asString(_read(json, 'assignTrackerName')),
      arriveTrackerName: _asString(_read(json, 'arriveTrackerName')),
      endWorkTrackerName: _asString(_read(json, 'endWorkTrackerName')),
      invoiceId: _asInt(_read(json, 'invoiceId')),
      statusTitle: _asString(_read(json, 'statusTitle')),
      hasImage: _asBool(_read(json, 'hasImage')),
      description: _asString(_read(json, 'description')),
      cancelReasonTitle: _asString(_read(json, 'cancelReasonTitle')),
      cancelReasonDetailTitle: _asString(
        json['cancelReasonDetailTitle'] ??
            json['CancelReasonDetailTitle'] ??
            json['cancelreasondetailtitle'],
      ),
    );
  }

  static dynamic _read(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) return json[key];

    final pascalKey = key[0].toUpperCase() + key.substring(1);
    return json[pascalKey];
  }

  static String? _asString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static double? _asDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static bool? _asBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;

    switch (value.toString().trim().toLowerCase()) {
      case 'true':
      case '1':
        return true;
      case 'false':
      case '0':
        return false;
      default:
        return null;
    }
  }
}
