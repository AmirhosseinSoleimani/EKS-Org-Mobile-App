class NavganIdRequestModel {
  const NavganIdRequestModel({required this.id});

  final int id;

  Map<String, dynamic> toJson() => {'Id': id};

  Map<String, dynamic> toDeleteJson() => {'id': id};
}
