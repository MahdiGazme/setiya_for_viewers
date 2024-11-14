import '../../../setia_module.dart';

class RepositoryUrls {
  const RepositoryUrls._();

  static final String fullBaseUrl = SetiaModuleParameters.fullBaseUrl;

  // ----------> documents <-----------
  static String downloadDocumentUrl(final String id) =>
      '$fullBaseUrl/storages/$id';

  static const String uploadDocumentUrl = '/storages';

  // ----------> identity <-----------
  static const String login = '/identities/login';

  static const String logout = '/identities/logout';

  static const String changePassword = '/identities/password';

  static const String signup = '/membership-requests/sign-up';

  static String changeRole(final String memberId) =>
      '/identities/$memberId/role';

  static String getCurrentRole(final String memberId) =>
      '/identities/$memberId/role';

  // ----------> members information <-----------

  static const String getMemberInformationForMainMenu = '';

  // ----------> management members <-----------
  static const String postMember = '/members';

  static String getAllMembers(final String? query) => '/members/by-roles$query';

  static String patchMember(final String id) => '/members/$id';

  static String deleteMember(final String id) => '/members/$id';

  static String resetPassword(final String id) =>
      '/identities/$id/reset-password';

  static String getMemberDetails(final String id) => '/members/$id/detail';

  static const String downloadMembersInformationUrl = '/members/to-excel';

  static String getAllAssignableChildren(final String query) =>
      '/members/for-add-children$query';

// ----------> news <-----------
  static const String getLastNews = '/announcements/latest';

  static const String deleteNews = '/announcements';

  static const String postNews = '/announcements';

  static String editNews(final String id) => '/announcements/$id';

  static String getManagementsNewsDetails(final String id) =>
      '/announcements/$id/detail-for-manage';

  static String getNewsDetails(final String id) =>
      '/announcements/$id/detail-for-public';

  static String getAllNews(final String query) =>
      '/announcements/all-in-public$query';

  static String getAllNewsManagement(final String query) =>
      '/announcements/all-for-manage$query';

// ----------> public profile <-----------
  static const String getPublicProfileData = '/members/profile';

  static const String changeAvatar = '/members/avatar';

  static const String deleteAvatar = '/members/avatar';

// ----------> membership request <-----------
  static const String postMembershipRequest = '/membership-requests/complete';

  static const String updateMembershipRequest = '/membership-requests/complete';

  static const String getOldMembershipRequestDetails =
      '/membership-requests/detail';

  static String checkChildIsAvailable(
    final String nationalCode,
  ) =>
      '/members/$nationalCode/is-available-for-add-child';

// ----------> additional information <-----------
  static const String getLastMemberAdditionalInformation =
      '/members/additional-information';

  static const String updateMemberAdditionalInformation =
      '/members/additional-information';

// ----------> authorize request <-----------
  static String getAllAuthorizeRequests(final String query) =>
      '/membership-requests$query';

  static String getAuthorizeRequest(final String requestId) =>
      '/membership-requests/$requestId/detail';

  static String postAuthorizeRequestAnswer(final String requestId) =>
      '/membership-requests/$requestId/desicion';

  static const String authorizeRequestStatus =
      '/membership-requests/is-completed';

  // ----------> members events <-----------

  static String getAllMembersEvent(final String query) =>
      '/events/for-members$query';

  static String getMembersEventDetails(final String id) =>
      '/events/$id/details-for-member';

  static String membersEventSubmitRequest(final String eventId) =>
      '/events/$eventId/register-request';

  static String getAllMemberEventsHistory(final String query) =>
      '/events/history-for-members$query';

  static String getMemberEventHistoryDetails(final String eventId) =>
      '/events/$eventId/details-history-for-member';

  static String cancelMemberEvent(final String eventId) =>
      '/events/$eventId/cancel';

// ----------> management active events <-----------

  static String getAllActiveEvents(final String query) =>
      '/events/for-add-entrance$query';

  // ----------> management event attendance <-----------

  static String getEventMemberById(
    final String id,
    final String eventId,
  ) =>
      '/members/$id/detail-for-submit-entrance-by-id?eventId=$eventId';

  static String getEventMemberByMembershipCode(
    final String membershipCode,
    final String eventId,
  ) =>
      '/members/$membershipCode/detail-for-submit-entrance-by-code?eventId=$eventId';

  static String submitEventAttendance(
    final String eventId,
    final String memberId,
  ) =>
      '/events/$eventId/members/$memberId/entrance';

// ----------> management events <-----------

  static String getAllManagementEvents(final String query) =>
      '/events/for-manage$query';

  static String getManagementEventDetails(final String eventId) =>
      '/events/$eventId/detail-for-manage';

  static String deleteEvent(final String eventId) => '/events/$eventId';

  static const String postNewEvent = '/events';

  static String editEvent(final String eventId) => '/events/$eventId';

  static String getEventParticipantsAttendance(
    final String eventId,
    final String query,
  ) =>
      '/events/$eventId/members-for-check-entrance$query';

  static String getEventParticipantsForManage(
    final String eventId,
    final String query,
  ) =>
      '/events/$eventId/members-for-manage$query';

  static String addMemberToEvent(
    final String eventId,
    final String memberId,
  ) =>
      '/events/$eventId/members/$memberId';

  static String deleteMemberFromEvent(
    final String eventId,
    final String memberId,
  ) =>
      '/events/$eventId/members/$memberId';

  static String acceptMemberRequestForEvent(
    final String eventId,
    final String memberId,
  ) =>
      '/events/$eventId/members/$memberId/accept-request';

  static String getMembersToAddToEvent(
    final String eventId,
    final String query,
  ) =>
      '/events/$eventId/members$query';

  // ----------> management events survey<-----------

  static String getAllEventCommentsForManagement(
    final String eventId,
    final String query,
  ) =>
      '/events/$eventId/comments$query';

  static String getEventMemberCommentDetailsForManagement(
          final String commentId) =>
      '/comments/$commentId';

  // ----------> members events survey<-----------

  static String getAllAvailableEventsForSurvey(final String query) =>
      '/events/for-survey$query';

  static String getEventDetailsForSurvey(
    final String eventId,
  ) =>
      '/events/$eventId/short-info-for-survey';

  static String postMemberCommentForEvent(
    final String eventId,
  ) =>
      '/events/$eventId/comment';

// ----------> Children management by mother <-----------

  static String getAllChildren(final String? query) =>
      '/members/children$query';

  static String getAllChildrenEventsHistory(
    final String query,
    final String childId,
  ) =>
      '/events/$childId/history-for-mothers$query';

  static String getChildEventHistoryDetails(
    final String eventId,
    final String childId,
  ) =>
      '/events/$eventId/details-history-for-child/$childId';
}
