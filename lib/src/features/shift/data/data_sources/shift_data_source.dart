import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_model.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class ShiftDataSource {
  Future<BaseSingleResponse<ShiftPageModel>> getByFilter(ShiftFilterRequestModel request);

  Future<BaseSingleResponse<ShiftModel>> getById(int id);

  Future<BaseSingleResponse<ShiftModel>> create(Map<String, dynamic> body);

  Future<BaseSingleResponse<ShiftModel>> update(Map<String, dynamic> body);

  Future<BaseResponse> deleteById(int id);
}
