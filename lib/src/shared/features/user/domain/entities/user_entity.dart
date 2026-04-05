import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';

import 'car_info_entity.dart';
import 'color_entity.dart';
import 'cover_car_entity.dart';
import 'defect_entity.dart';
import 'degree_entity.dart';
import 'factory_entity.dart';
import 'meta_data_entity.dart';
import 'package_entity.dart';

class BaseUserInfoEntity {
  final String? guid;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? _mobileNumber;
  final String? nationalCode;
  final int? gender;
  final String? email;
  final int? jobId;
  final String? birthDate;
  final int? degreeType;
  final int? disability;
  final String? disabilityDescription;

  const BaseUserInfoEntity({
    this.guid,
    this.firstName,
    this.lastName,
    this.fullName,
    String? mobileNumber,
    this.nationalCode,
    this.gender,
    this.email,
    this.birthDate,
    this.degreeType,
    this.jobId,
    this.disability,
    this.disabilityDescription,
  }) : _mobileNumber = mobileNumber;

  String? get mobileNumber {
    if (_mobileNumber == null) return null;
    if (_mobileNumber.startsWith('+98')) {
      return _mobileNumber.replaceFirst('+98', '0');
    }
    return _mobileNumber;
  }

  BaseUserInfoModel toModel() {
    return BaseUserInfoModel(
      guid: guid,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      mobileNumber: mobileNumber,
      nationalCode: nationalCode,
      gender: gender,
      email: email,
      degreeType: degreeType,
      jobId: jobId,
      birthDate: birthDate,
      disability: disability,
      disabilityDescription: disabilityDescription,
    );
  }
}

class UserEntity {
  final BaseUserInfoEntity? baseInfo;
  final bool? active;
  final List<CarInfoEntity>? carList;
  final String? otpCode;
  final List<DefectEntity>? defectsList;
  final List<CoverCarEntity>? coverCarList;
  final List<PackageEntity>? packageList;
  final List<ColorEntity>? colorList;
  final List<DegreeEntity>? degreeList;
  final List<FactoryEntity>? automobileFactories;
  final MetaDataEntity? metaData;

  const UserEntity({
    this.baseInfo,
    this.active,
    this.carList,
    this.otpCode,
    this.defectsList,
    this.coverCarList,
    this.packageList,
    this.colorList,
    this.automobileFactories,
    this.metaData,
    this.degreeList,
  });

  UserModel toModel() {
    return UserModel(
      baseInfo: baseInfo?.toModel(),
      active: active,
      carList: carList?.map((e) => e.toModel()).toList(),
      otpCode: otpCode,
      defectsList: defectsList?.map((e) => e.toModel()).toList(),
      coverCarList: coverCarList?.map((e) => e.toModel()).toList(),
      packageList: packageList?.map((e) => e.toModel()).toList(),
      automobileFactories:
          automobileFactories?.map((e) => e.toModel()).toList(),
      degreeList: degreeList?.map((e) => e.toModel()).toList(),
      metaData: metaData?.toModel(),
    );
  }
}
