import '../../role_management/setiya_role_enum.dart';

class SessionModel {
  final String id;
  final List<SetiyaRoleEnum> roles;
  final DateTime expireDate;

  SessionModel({
    required this.id,
    required this.roles,
    required this.expireDate,
  });

  factory SessionModel.fromJson(final Map<String, dynamic> json) {
    final List<SetiyaRoleEnum> roles = [];
    final jsonRoles = json['role'];
    if (jsonRoles is List) {
      roles.addAll(
        jsonRoles.map(
          (final e) => SetiyaRoleEnum.fromValue(
            e.toString(),
          ),
        ),
      );
    } else if (jsonRoles != null) {
      roles.add(
        SetiyaRoleEnum.fromValue(
          jsonRoles,
        ),
      );
    }

    return SessionModel(
        id: json['nameid'],
        roles: roles,
        expireDate:
            DateTime.fromMillisecondsSinceEpoch((json['exp'] as int) * 1000));
  }
}
