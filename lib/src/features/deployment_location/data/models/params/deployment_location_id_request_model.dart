class DeploymentLocationIdRequestModel {
  const DeploymentLocationIdRequestModel({required this.id});

  final int id;

  Map<String, dynamic> toGetJson() => {'Id': id};

  Map<String, dynamic> toDeleteJson() => {'id': id};
}
