
import '../../data/models/current_session_menu_model.dart';

class CurrentSessionMenuEntity {
  final String? code;
  final String? title;
  final String? url;
  final String? icon;
  final List<CurrentSessionMenuEntity>? children;

  const CurrentSessionMenuEntity({
    this.code,
    this.title,
    this.url,
    this.icon,
    this.children,
  });

  CurrentSessionMenuEntity copyWith({
    String? code,
    String? title,
    String? url,
    String? icon,
    List<CurrentSessionMenuEntity>? children,
  }) {
    return CurrentSessionMenuEntity(
      code: code ?? this.code,
      title: title ?? this.title,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      children: children ?? this.children,
    );
  }

  CurrentSessionMenuModel toModel() {
    return CurrentSessionMenuModel(
      code: code,
      title: title,
      url: url,
      icon: icon,
      children: children?.map((item) => item.toModel()).toList(),
    );
  }
}
