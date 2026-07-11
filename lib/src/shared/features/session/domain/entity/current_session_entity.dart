
import '../../data/models/current_session_model.dart';
import 'current_session_enums_entity.dart';
import 'current_session_menu_entity.dart';
import 'current_session_misc_entity.dart';
import 'current_session_role_entity.dart';

class CurrentSessionEntity {
  final String? guid;
  final int? authenticationType;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? nationalCode;
  final String? mobileNo;
  final String? email;
  final String? userName;
  final int? language;
  final List<CurrentSessionRoleEntity>? roles;
  final List<String>? authorizations;
  final List<CurrentSessionMenuEntity>? menus;
  final CurrentSessionMiscEntity? misc;
  final CurrentSessionEnumsEntity? enums;

  const CurrentSessionEntity({
    this.guid,
    this.authenticationType,
    this.firstName,
    this.lastName,
    this.fullName,
    this.nationalCode,
    this.mobileNo,
    this.email,
    this.userName,
    this.language,
    this.roles,
    this.authorizations,
    this.menus,
    this.misc,
    this.enums,
  });

  Set<String> get authorizationSet {
    return (authorizations ?? const <String>[]).toSet();
  }

  Set<String> get roleCodeSet {
    return (roles ?? const <CurrentSessionRoleEntity>[])
        .map((role) => role.code)
        .whereType<String>()
        .toSet();
  }

  bool hasAuthorization(String code) {
    return authorizationSet.contains(code);
  }

  bool hasAnyAuthorization(Iterable<String> codes) {
    final auths = authorizationSet;
    return codes.any(auths.contains);
  }

  bool hasAllAuthorizations(Iterable<String> codes) {
    final auths = authorizationSet;
    return codes.every(auths.contains);
  }

  bool hasRole(String roleCode) {
    return roleCodeSet.contains(roleCode);
  }

  bool hasAnyRole(Iterable<String> roleCodes) {
    final roles = roleCodeSet;
    return roleCodes.any(roles.contains);
  }

  bool hasMenu(String menuCode) {
    return _containsMenuCode(menus, menuCode);
  }

  bool canShowMenu(String menuCode) {
    return hasMenu(menuCode) || hasAuthorization(menuCode);
  }

  bool canShowByAuthorization(String authorizationCode) {
    return hasAuthorization(authorizationCode);
  }

  bool canShowByAnyAuthorization(Iterable<String> authorizationCodes) {
    return hasAnyAuthorization(authorizationCodes);
  }

  List<CurrentSessionMenuEntity> flattenMenus() {
    final result = <CurrentSessionMenuEntity>[];

    void visit(List<CurrentSessionMenuEntity>? items) {
      for (final item in items ?? const <CurrentSessionMenuEntity>[]) {
        result.add(item);
        visit(item.children);
      }
    }

    visit(menus);
    return result;
  }

  CurrentSessionEntity copyWith({
    String? guid,
    int? authenticationType,
    String? firstName,
    String? lastName,
    String? fullName,
    String? nationalCode,
    String? mobileNo,
    String? email,
    String? userName,
    int? language,
    List<CurrentSessionRoleEntity>? roles,
    List<String>? authorizations,
    List<CurrentSessionMenuEntity>? menus,
    CurrentSessionMiscEntity? misc,
    CurrentSessionEnumsEntity? enums,
  }) {
    return CurrentSessionEntity(
      guid: guid ?? this.guid,
      authenticationType: authenticationType ?? this.authenticationType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      nationalCode: nationalCode ?? this.nationalCode,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      language: language ?? this.language,
      roles: roles ?? this.roles,
      authorizations: authorizations ?? this.authorizations,
      menus: menus ?? this.menus,
      misc: misc ?? this.misc,
      enums: enums ?? this.enums,
    );
  }

  CurrentSessionModel toModel() {
    return CurrentSessionModel(
      guid: guid,
      authenticationType: authenticationType,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      nationalCode: nationalCode,
      mobileNo: mobileNo,
      email: email,
      userName: userName,
      language: language,
      roles: roles?.map((item) => item.toModel()).toList(),
      authorizations: authorizations,
      menus: menus?.map((item) => item.toModel()).toList(),
      misc: misc?.toModel(),
      enums: enums?.toModel(),
    );
  }

  static bool _containsMenuCode(
    List<CurrentSessionMenuEntity>? menus,
    String code,
  ) {
    for (final menu in menus ?? const <CurrentSessionMenuEntity>[]) {
      if (menu.code == code) return true;
      if (_containsMenuCode(menu.children, code)) return true;
    }

    return false;
  }
}
