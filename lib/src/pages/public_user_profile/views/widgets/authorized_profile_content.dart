import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructures/role_management/custom_access_keys.dart';
import '../../../../infrastructures/role_management/setiya_user_access.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../controller/public_profile_controller.dart';
import 'in_authorized_process_widget.dart';
import 'profile_element.dart';
import 'profile_options.dart';


class AuthorizedProfileContent extends GetView<PublicProfileController> {
  const AuthorizedProfileContent({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            if (SetiaUserAccess.hasUserAccess(
              SetiaCustomAccessKeys.notAuthorizeWidgetInProfile,
            ))
              const InAuthorizeProcessWidget(),
            Utils.smallVerticalSpacer,
            const ProfileElement(),
            Utils.smallVerticalSpacer,
            const ProfileOptions(),
          ],
        ),
      );
}
