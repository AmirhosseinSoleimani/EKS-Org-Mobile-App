import 'package:eks_sana_plus_org/src/features/services/domain/entities/post_follow_up_response_entity.dart';

class PostFollowUpResponseModel extends PostFollowUpResponseEntity {
  const PostFollowUpResponseModel({required super.createdId});

  factory PostFollowUpResponseModel.fromJson(dynamic json) {
    return PostFollowUpResponseModel(createdId: json);
  }
}
