import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_page_entity.dart';

class NavganPageModel extends NavganPageEntity {
  const NavganPageModel({
    super.records,
    super.count,
  });

  factory NavganPageModel.fromJson(Map<String, dynamic> json) {
    final records = NavganJsonHelper.pageRecords(json)
        .map(NavganModel.fromJson)
        .where((item) => item.id != null)
        .toList();

    return NavganPageModel(
      records: records,
      count: NavganJsonHelper.pageCount(json),
    );
  }
}
