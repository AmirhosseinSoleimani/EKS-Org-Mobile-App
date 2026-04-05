class ChangeTimeResponseModel {
  String? message;

  ChangeTimeResponseModel({this.message});

  factory ChangeTimeResponseModel.fromJson(json) {
    return ChangeTimeResponseModel(message: json['message']);
  }
}
