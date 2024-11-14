import 'package:get/get.dart';

import '../../../setia_module.dart';

import '../../pages/contact_us/commons/contact_us_binding.dart';
import '../../pages/contact_us/view/contact_us.dart';
import '../../pages/login/commons/login_page_binding.dart';
import '../../pages/login/view/login_page.dart';
import '../../pages/main_menu/commons/main_menu_binding.dart';
import '../../pages/main_menu/views/main_menu.dart';
import '../../pages/management/authorize_request/commons/authorize_request_binding.dart';
import '../../pages/management/authorize_request/view/authorize_request.dart';
import '../../pages/management/authorize_request_list/common/authorize_request_list_binding.dart';
import '../../pages/management/authorize_request_list/view/authorize_request_list.dart';
import '../../pages/management/event_management/event_attendance/active_events/commons/active_events_binding.dart';
import '../../pages/management/event_management/event_attendance/active_events/views/active_events.dart';
import '../../pages/management/event_management/event_attendance/qrcode_scanner/view/qrcode_scanner.dart';
import '../../pages/management/event_management/event_attendance/submit_event_attendance/commons/submit_event_attendance_binding.dart';
import '../../pages/management/event_management/event_attendance/submit_event_attendance/views/submit_event_attendance.dart';
import '../../pages/management/event_management/event_attendance_list/common/event_participants_attendance_binding.dart';
import '../../pages/management/event_management/event_attendance_list/view/event_participants_attendance.dart';
import '../../pages/management/event_management/event_member_comment_details/commons/event_member_comment_details_binding.dart';
import '../../pages/management/event_management/event_member_comment_details/views/event_member_comment_details.dart';
import '../../pages/management/event_management/event_members_survey_list/commons/management_event_members_survey_list_binding.dart';
import '../../pages/management/event_management/event_members_survey_list/view/management_event_members_survey_list.dart';
import '../../pages/management/event_management/event_participants_list/commons/manage_event_participants_binding.dart';
import '../../pages/management/event_management/event_participants_list/view/manage_event_participants.dart';
import '../../pages/management/event_management/management_event_details/commons/management_event_details_binding.dart';
import '../../pages/management/event_management/management_event_details/view/management_event_details.dart';
import '../../pages/management/event_management/management_events_list/commons/management_events_list_binding.dart';
import '../../pages/management/event_management/management_events_list/views/management_events_list.dart';
import '../../pages/management/event_management/modify_event_form/commons/add_event_binding.dart';
import '../../pages/management/event_management/modify_event_form/commons/edit_event_binding.dart';
import '../../pages/management/event_management/modify_event_form/controllers/add_event_controller.dart';
import '../../pages/management/event_management/modify_event_form/controllers/edit_event_controller.dart';
import '../../pages/management/event_management/modify_event_form/views/modify_event_form.dart';
import '../../pages/management/main/commons/management_binding.dart';
import '../../pages/management/main/views/management.dart';
import '../../pages/management/management_member_form/modify_user_form/commons/add_user_binding.dart';
import '../../pages/management/management_member_form/modify_user_form/commons/edit_user_binding.dart';
import '../../pages/management/management_member_form/modify_user_form/controllers/add_user_controller.dart';
import '../../pages/management/management_member_form/modify_user_form/controllers/edit_user_controller.dart';
import '../../pages/management/management_member_form/modify_user_form/views/modify_user_form.dart';
import '../../pages/management/management_user_profile/commons/management_user_profile_binding.dart';
import '../../pages/management/management_user_profile/view/management_user_profile.dart';
import '../../pages/management/members/commons/members_binding.dart';
import '../../pages/management/members/view/members.dart';
import '../../pages/management/news_management/management_news_list/commons/management_news_list_binding.dart';
import '../../pages/management/news_management/management_news_list/views/management_news_list.dart';
import '../../pages/management/news_management/modify_news_form/commons/add_news_form_binding.dart';
import '../../pages/management/news_management/modify_news_form/commons/edit_news_form_binding.dart';
import '../../pages/management/news_management/modify_news_form/controllers/add_news_form_controller.dart';
import '../../pages/management/news_management/modify_news_form/controllers/edit_news_form_controller.dart';
import '../../pages/management/news_management/modify_news_form/views/modify_news_form.dart';
import '../../pages/member_additional_information/common/member_additional_information_binding.dart';
import '../../pages/member_additional_information/view/member_additional_information.dart';
import '../../pages/members_events/member_event_history/member_event_history_details/common/members_event_history_details_binding.dart';
import '../../pages/members_events/member_event_history/member_event_history_details/views/members_event_history_details.dart';
import '../../pages/members_events/member_event_history/member_event_history_list/common/member_event_history_list_binding.dart';
import '../../pages/members_events/member_event_history/member_event_history_list/views/member_event_history_list.dart';
import '../../pages/members_events/members_event_details/common/members_event_details_binding.dart';
import '../../pages/members_events/members_event_details/view/members_event_details.dart';
import '../../pages/members_events/members_event_survey/members_event_survey_form/common/members_event_survey_form_binding.dart';
import '../../pages/members_events/members_event_survey/members_event_survey_form/views/members_event_survey_form.dart';
import '../../pages/members_events/members_event_survey/members_event_survey_list/common/members_event_survey_list_binding.dart';
import '../../pages/members_events/members_event_survey/members_event_survey_list/views/members_event_survey_list.dart';
import '../../pages/members_events/members_events_list/commons/members_events_list_binding.dart';
import '../../pages/members_events/members_events_list/views/members_events_list.dart';
import '../../pages/membership_request/modify_membership_request/commons/membership_request_add_binding.dart';
import '../../pages/membership_request/modify_membership_request/commons/membership_request_edit_binding.dart';
import '../../pages/membership_request/modify_membership_request/controllers/membership_request_add_controller.dart';
import '../../pages/membership_request/modify_membership_request/controllers/membership_request_edit_controller.dart';
import '../../pages/membership_request/modify_membership_request/views/modify_membership_request.dart';
import '../../pages/mothers/children_event_history_details/commons/children_event_history_details_binding.dart';
import '../../pages/mothers/children_event_history_details/view/children_event_history_details.dart';
import '../../pages/mothers/children_event_history_list/common/children_event_history_list_binding.dart';
import '../../pages/mothers/children_event_history_list/view/children_event_history_list.dart';
import '../../pages/mothers/children_list/commons/children_list_binding.dart';
import '../../pages/mothers/children_list/view/children_list.dart';
import '../../pages/news/news_list/commons/news_list_binding.dart';
import '../../pages/news/news_list/view/news_list.dart';
import '../../pages/news/news_preview/commons/news_preview_binding.dart';
import '../../pages/news/news_preview/views/news_preview.dart';
import '../../pages/public_user_profile/commons/public_profile_binding.dart';
import '../../pages/public_user_profile/views/public_profile.dart';
import '../../pages/qr_code/commons/qr_code_binding.dart';
import '../../pages/qr_code/view/qr_code.dart';
import '../../pages/rules_and_conditions/view/rules_and_conditions.dart';
import '../../pages/shared/commons/route_gourd_middleware/route_gourd_middleware.dart';
import '../../pages/shared/view/pages/403/forbidden.dart';
import '../../pages/signup/commons/signup_binding.dart';
import '../../pages/signup/view/signup.dart';
import '../../pages/splash/commons/splash_binding.dart';
import '../../pages/splash/view/splash.dart';

class SetiaModuleRoutePages {
  SetiaModuleRoutePages._();

  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: SetiaModuleRouteNames.splash,
      page: Splash.new,
      binding: SplashBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.logIn,
      page: () => const LoginPage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.signup,
      page: () => const Signup(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.mainMenu,
      page: MainMenu.new,
      binding: MainMenuBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.qrcode,
      page: Qrcode.new,
      binding: QrcodeBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.childrenList,
      page: ChildrenList.new,
      binding: ChildrenListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.childrenEventHistoryList,
      page: ChildrenEventHistoryList.new,
      binding: ChildrenEventHistoryListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.childrenEventHistoryDetails,
      page: ChildrenEventHistoryDetails.new,
      binding: ChildrenEventHistoryDetailsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.management,
      page: Management.new,
      binding: ManagementBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.memberEventsHistoryList,
      page: MemberEventsHistoryList.new,
      binding: MemberEventHistoryListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.memberEventsHistoryDetails,
      page: MembersEventHistoryDetails.new,
      binding: MembersEventHistoryDetailsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.eventParticipantsAttendance,
      page: EventParticipantsAttendance.new,
      binding: EventParticipantsAttendanceBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.manageEventParticipants,
      page: ManageEventParticipants.new,
      binding: ManageEventParticipantsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.managementEventsList,
      page: ManagementEventsList.new,
      binding: ManagementEventsListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.managementEventDetails,
      page: ManagementEventDetails.new,
      binding: ManagementEventDetailsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.editEvent,
      page: ModifyEventForm<EditEventController>.new,
      binding: EditEventBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.addEvent,
      page: ModifyEventForm<AddEventController>.new,
      binding: AddEventBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.managementEventMembersSurveyList,
      page: ManagementEventMembersSurveyList.new,
      binding: MembersEventMembersSurveyListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.eventMemberCommentDetails,
      page: EventMemberCommentDetails.new,
      binding: EventMemberCommentDetailsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.activeEvents,
      page: ActiveEventsList.new,
      binding: ActiveEventsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.submitEventAttendance,
      page: SubmitEventAttendance.new,
      binding: SubmitEventAttendanceBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.qrcodeScanner,
      page: QrcodeScanner.new,
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.membersEventsList,
      page: MembersEventsList.new,
      binding: MembersEventsListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.membersEventDetails,
      page: MembersEventDetails.new,
      binding: MembersEventDetailsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.membersEventSurveyList,
      page: () => const MembersEventSurveyList(),
      binding: MembersEventSurveyListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.membersEventSurveyForm,
      page: () => const MembersEventSurveyForm(),
      binding: MembersEventSurveyFormBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.publicProfile,
      page: PublicProfile.new,
      binding: PublicProfileBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.memberAdditionalInformation,
      page: MemberAdditionalInformation.new,
      binding: MemberAdditionalInformationBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.addMembershipRequest,
      page: () =>
          const ModifyMembershipRequest<MembershipRequestAddController>(),
      binding: MembershipRequestAddBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.editMembershipRequest,
      page: () =>
          const ModifyMembershipRequest<MembershipRequestEditController>(),
      binding: MembershipRequestEditBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.authorizeRequestList,
      page: AuthorizeRequestList.new,
      binding: AuthorizeRequestListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.authorizeRequest,
      page: AuthorizeRequest.new,
      binding: AuthorizeRequestBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.managementNewsList,
      page: ManagementNewsList.new,
      binding: ManagementNewsListBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.addNews,
      page: ModifyNewsForm<AddNewsFormController>.new,
      binding: AddNewsFormBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.editNews,
      page: ModifyNewsForm<EditNewsFormController>.new,
      binding: EditNewsFormBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.newsList,
      page: NewsList.new,
      binding: NewsListBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.newsPreview,
      page: NewsPreview.new,
      binding: NewsPreviewBinding(),
    ),
    GetPage(
      name: SetiaModuleRouteNames.managementUserProfile,
      page: ManagementUserProfile.new,
      binding: ManagementUserProfileBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.members,
      page: () => const Members(),
      binding: MembersBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.addUser,
      page: () => const ModifyUserForm<AddUserController>(),
      binding: AddUserBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.editUser,
      page: () => const ModifyUserForm<EditUserController>(),
      binding: EditUserBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.contactUs,
      page: ContactUs.new,
      binding: ContactUsBinding(),
      middlewares: [
        RouteGourdMiddleware(),
      ],
    ),
    GetPage(
      name: SetiaModuleRouteNames.rulesAndConditions,
      page: RulesAndConditions.new,
    ),
    GetPage(
      name: SetiaModuleRouteNames.forbidden,
      page: Forbidden.new,
    ),
  ];
}
