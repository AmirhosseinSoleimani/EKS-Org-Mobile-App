import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';

class GeneralContentModel extends GeneralContentEntity {
  const GeneralContentModel({
    super.id,
    super.title,
    super.description,
    super.contentType,
    super.contentTypeText,
    super.receiverType,
    super.receiverTypeText,
    super.applyDate,
    super.applyDateJalali,
    super.startDate,
    super.startDateJalali,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.updateDateTime,
    super.updateDateTimeJalali,
    super.isActive,
  });

  factory GeneralContentModel.fromJson(Map<String, dynamic> json) {
    return GeneralContentModel(
      id: GeneralContentJsonHelper.integer(json['id'] ?? json['Id']),
      title: GeneralContentJsonHelper.string(json['title'] ?? json['Title']),
      description: GeneralContentJsonHelper.string(
        json['description'] ?? json['Description'],
      ),
      contentType: GeneralContentJsonHelper.integer(
        json['contentType'] ?? json['ContentType'],
      ),
      contentTypeText: GeneralContentJsonHelper.string(
        json['contentTypeText'] ?? json['ContentTypeText'],
      ),
      receiverType: GeneralContentJsonHelper.integer(
        json['receiverType'] ?? json['ReceiverType'],
      ),
      receiverTypeText: GeneralContentJsonHelper.string(
        json['receiverTypeText'] ?? json['ReceiverTypeText'],
      ),
      applyDate: GeneralContentJsonHelper.string(
        json['applyDate'] ?? json['ApplyDate'],
      ),
      applyDateJalali: GeneralContentJsonHelper.string(
        json['applyDateJalali'] ?? json['ApplyDateJalali'],
      ),
      startDate: GeneralContentJsonHelper.string(
        json['startDate'] ?? json['StartDate'],
      ),
      startDateJalali: GeneralContentJsonHelper.string(
        json['startDateJalali'] ?? json['StartDateJalali'],
      ),
      insertUserFullName: GeneralContentJsonHelper.string(
        json['insertUserFullName'] ?? json['InsertUserFullName'],
      ),
      updateUserFullName: GeneralContentJsonHelper.string(
        json['updateUserFullName'] ?? json['UpdateUserFullName'],
      ),
      insertDateTime: GeneralContentJsonHelper.string(
        json['insertDateTime'] ?? json['InsertDateTime'],
      ),
      insertDateTimeJalali: GeneralContentJsonHelper.string(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      updateDateTime: GeneralContentJsonHelper.string(
        json['updateDateTime'] ?? json['UpdateDateTime'],
      ),
      updateDateTimeJalali: GeneralContentJsonHelper.string(
        json['updateDateTimeJalali'] ?? json['UpdateDateTimeJalali'],
      ),
      isActive: GeneralContentJsonHelper.boolean(
        json['isActive'] ?? json['IsActive'],
      ),
    );
  }
}
