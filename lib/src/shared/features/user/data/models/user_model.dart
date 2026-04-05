import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';

import 'car_info_model.dart';
import 'color_model.dart';
import 'cover_car_model.dart';
import 'defect_model.dart';
import 'degree_model.dart';
import 'factory_model.dart';
import 'meta_data_model.dart';
import 'package_model.dart';

class BaseUserInfoModel extends BaseUserInfoEntity {
  const BaseUserInfoModel({
    super.guid,
    super.firstName,
    super.lastName,
    super.fullName,
    super.mobileNumber,
    super.nationalCode,
    super.gender,
    super.birthDate,
    super.degreeType,
    super.email,
    super.jobId,
    super.disability,
    super.disabilityDescription,
  });

  factory BaseUserInfoModel.fromJson(Map<String, dynamic> json) {
    return BaseUserInfoModel(
      guid: json['guid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
      nationalCode: json['nationalCode'],
      gender: json['gender'],
      jobId: json['jobId'],
      birthDate: json['birthDate'],
      degreeType: json['degreeType'],
      email: json['email'],
      disability: json['customerDisability'],
      disabilityDescription: json['customerDisabilityDesc'],
    );
  }

  Map<String, dynamic> toJson() => {
        'guid': guid,
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'mobileNumber': mobileNumber,
        'nationalCode': nationalCode,
        'gender': gender,
        'jobId': jobId,
        'birthDate': birthDate,
        'degreeType': degreeType,
        'email': email,
        'customerDisabilityDesc': disabilityDescription,
        'customerDisability': disability,
      };
}

class UserModel extends UserEntity {
  const UserModel({
    super.baseInfo,
    super.active,
    super.otpCode,
    super.carList,
    super.defectsList,
    super.coverCarList,
    super.packageList,
    super.colorList,
    super.automobileFactories,
    super.degreeList,
    super.metaData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      baseInfo: BaseUserInfoModel.fromJson(json),
      carList: (json['carInfos'] != null)
          ? (json['carInfos'] as List)
              .map((e) => CarInfoModel.fromJson(e))
              .toList()
          : null,
      otpCode: json['otpCode'],
      defectsList: (json['defects'] != null)
          ? (json['defects'] as List)
              .map((e) => DefectModel.fromJson(e))
              .toList()
          : null,
      coverCarList: (json['coverCars'] != null)
          ? (json['coverCars'] as List)
              .map((e) => CoverCarModel.fromJson(e))
              .toList()
          : null,
      packageList: (json['packages'] != null)
          ? (json['packages'] as List)
              .map((e) => PackageModel.fromJson(e))
              .toList()
          : null,
      colorList: (json['carColors'] != null)
          ? (json['carColors'] as List)
              .map((e) => ColorModel.fromJson(e))
              .toList()
          : null,
      automobileFactories: (json['automobileFactories'] != null)
          ? (json['automobileFactories'] as List)
              .map((e) => FactoryModel.fromJson(e))
              .toList()
          : null,
      metaData: (json['metaData'] != null)
          ? MetaDataModel.fromJson(json['metaData'])
          : null,
      degreeList: (json['degrees'] != null)
          ? (json['degrees'] as List)
              .map((e) => DegreeModel.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        ...?(baseInfo as BaseUserInfoModel?)?.toJson(),
        'carInfos': carList?.map((e) => (e as CarInfoModel).toJson()).toList(),
        'otpCode': otpCode,
        'defects':
            defectsList?.map((e) => (e as DefectModel).toJson()).toList(),
        'coverCars':
            coverCarList?.map((e) => (e as CoverCarModel).toJson()).toList(),
        'packages':
            packageList?.map((e) => (e as PackageModel).toJson()).toList(),
        'carColors': colorList?.map((e) => (e as ColorModel).toJson()).toList(),
        'automobileFactories': automobileFactories
            ?.map((e) => (e as FactoryModel).toJson())
            .toList(),
        'metaData': (metaData as MetaDataModel?)?.toJson(),
        'degrees': degreeList?.map((e) => (e as DegreeModel).toJson()).toList(),
      };
}
