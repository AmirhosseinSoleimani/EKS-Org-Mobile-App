import 'package:eks_sana_plus_org/src/features/services/data/models/post_follow_up_response_model.dart';

class PostFollowUpResponseEntity {
  final String? createdId;

  const PostFollowUpResponseEntity({ this.createdId});

  PostFollowUpResponseEntity copyWith({String? createdId}) {
    return PostFollowUpResponseEntity(createdId: createdId ?? this.createdId);
  }

  PostFollowUpResponseModel toModel() =>
      PostFollowUpResponseModel(createdId: createdId);
}
