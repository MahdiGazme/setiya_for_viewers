import '../../../setia_module.dart';
import 'custom_access_keys.dart';
import 'setiya_role_enum.dart';

class SetiyaAccessMap {
  static final Map<String, List<String>> roleManagementMap = {
    SetiaModuleRouteNames.management: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mediaManager.value,
    ],
    SetiaModuleRouteNames.publicProfile: [
      SetiyaRoleEnum.guest.value,
      SetiyaRoleEnum.setiyaMember.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mediaManager.value,
    ],
    SetiaCustomAccessKeys.notAuthorizeWidgetInProfile: [
      SetiyaRoleEnum.guest.value,
    ],
    SetiaCustomAccessKeys.editMembershipRequestMenuItemInProfile: [
      SetiyaRoleEnum.guest.value,
    ],
    SetiaModuleRouteNames.memberAdditionalInformation: [
      SetiyaRoleEnum.setiyaMember.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mediaManager.value,
    ],
    SetiaCustomAccessKeys.authorizeRequestReminderInMainMenu: [
      SetiyaRoleEnum.guest.value,
    ],
    SetiaModuleRouteNames.members: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.authorizeRequestList: [
      SetiyaRoleEnum.superAdmin.value,
    ],
    SetiaModuleRouteNames.authorizeRequest: [
      SetiyaRoleEnum.superAdmin.value,
    ],
    SetiaModuleRouteNames.managementUserProfile: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.addUser: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.editUser: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.managementNewsList: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.mediaManager.value,
    ],
    SetiaModuleRouteNames.addNews: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.mediaManager.value,
    ],
    SetiaModuleRouteNames.editNews: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.mediaManager.value,
    ],
    SetiaModuleRouteNames.membersEventsList: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.setiyaMember.value,
      SetiyaRoleEnum.mother.value,
    ],
    SetiaModuleRouteNames.membersEventDetails: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.setiyaMember.value,
      SetiyaRoleEnum.mother.value,
    ],
    SetiaModuleRouteNames.qrcode: [
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.setiyaMember.value,
      SetiyaRoleEnum.mother.value,
    ],
    SetiaModuleRouteNames.activeEvents: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.submitEventAttendance: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.qrcodeScanner: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.managementEventsList: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.managementEventDetails: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.addEvent: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.editEvent: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.eventParticipantsAttendance: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.manageEventParticipants: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
    ],
    SetiaModuleRouteNames.memberEventsHistoryList: [
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.setiyaMember.value,
    ],
    SetiaModuleRouteNames.memberEventsHistoryDetails: [
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.setiyaMember.value,
    ],
    SetiaModuleRouteNames.membersEventSurveyList: [
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.setiyaMember.value,
    ],
    SetiaModuleRouteNames.membersEventSurveyForm: [
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.setiyaMember.value,
    ],
    SetiaCustomAccessKeys.editMemberRoleInManagementUserProfile: [
      SetiyaRoleEnum.superAdmin.value,
    ],
    SetiaModuleRouteNames.childrenList: [
      SetiyaRoleEnum.mother.value,
    ],
    SetiaModuleRouteNames.childrenEventHistoryList: [
      SetiyaRoleEnum.mother.value,
    ],
    SetiaModuleRouteNames.childrenEventHistoryDetails: [
      SetiyaRoleEnum.mother.value,
    ],
    SetiaModuleRouteNames.contactUs: [
      SetiyaRoleEnum.superAdmin.value,
      SetiyaRoleEnum.mediaManager.value,
      SetiyaRoleEnum.directorOfPublicRelations.value,
      SetiyaRoleEnum.setiyaMember.value,
      SetiyaRoleEnum.mother.value,
      SetiyaRoleEnum.guest.value,
    ],
  };
}
