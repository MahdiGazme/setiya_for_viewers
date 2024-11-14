import 'role_names.dart';

enum SetiyaRoleEnum {
  superAdmin(
    'مدیر ستیا',
    SetiyaRoleNames.superAdmin,
  ),
  directorOfPublicRelations(
    'کادر روابط عمومی',
    SetiyaRoleNames.directorOfPublicRelations,
  ),
  mediaManager(
    'کادر رسانه',
    SetiyaRoleNames.mediaManager,
  ),
  mother(
    'مادر',
    SetiyaRoleNames.mother,
  ),
  setiyaMember(
    'عضو ستیا',
    SetiyaRoleNames.setiyaMember,
  ),
  guest(
    'مهمان',
    SetiyaRoleNames.guest,
  );

  final String name;
  final String value;

  const SetiyaRoleEnum(this.name, this.value);

  factory SetiyaRoleEnum.fromValue(final String value) {
    switch (value) {
      case SetiyaRoleNames.superAdmin:
        return SetiyaRoleEnum.superAdmin;
      case SetiyaRoleNames.mediaManager:
        return SetiyaRoleEnum.mediaManager;
      case SetiyaRoleNames.directorOfPublicRelations:
        return SetiyaRoleEnum.directorOfPublicRelations;
      case SetiyaRoleNames.mother:
        return SetiyaRoleEnum.mother;
      case SetiyaRoleNames.setiyaMember:
        return SetiyaRoleEnum.setiyaMember;
      case SetiyaRoleNames.guest:
        return SetiyaRoleEnum.guest;
      default:
        return SetiyaRoleEnum.guest;
    }
  }
}
