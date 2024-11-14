import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../infrastructures/themes/custom_milky_theme.dart';
import '../../shared/view/widgets/page_state.dart';
import '../../shared/view/widgets/scaffold_body_container.dart';
import '../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/public_profile_controller.dart';
import 'widgets/authorized_profile_content.dart';
import 'widgets/not_authorized_widget.dart';

class PublicProfile extends GetView<PublicProfileController> {
  const PublicProfile({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          page: () => controller.profileData == null
              ? NotAuthorizedWidget(
                  onAuthorizeButtonTap: controller.onAuthorizeButtonTap,
                )
              : const AuthorizedProfileContent(),
          onRetry: controller.getProfileData,
        ),
      );

  SecondaryAppBar _appBar() => const SecondaryAppBar(
        title: Text('نمایه کاربر'),
      );
}
