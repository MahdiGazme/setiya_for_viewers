import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/page_state.dart';
import '../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../shared/view/widgets/search_text_field.dart';
import '../../../shared/view/widgets/secondary_app_bar.dart';
import '../controller/authorize_request_list_controller.dart';
import 'widget/requests_list.dart';

class AuthorizeRequestList extends GetView<AuthorizeRequestListController> {
  const AuthorizeRequestList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: SecondaryAppBar(
          title: Text(
            LocaleKeys
                .setia_module_pages_management_authorize_request_list_title.tr,
          ),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: ScaffoldBodyContainer(
          child: PageStateProvider(
            state: controller.state,
            onRetry: controller.onRetry,
            page: _content,
          ),
        ),
      );

  Column _content() => Column(
        children: [
          SearchTextField(
            controller: controller.searchText,
            onChanged: controller.onSearchTextChanged,
            label: Text(
              LocaleKeys.setia_module_shared_commons_search.tr,
            ),
          ),
          Utils.smallVerticalSpacer,
          const Expanded(
            child: RequestList(),
          ),
        ],
      );
}
