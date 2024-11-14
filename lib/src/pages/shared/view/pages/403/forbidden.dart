import 'package:flutter/material.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../widgets/no_content_widget.dart';
import '../../widgets/scaffold_body_container.dart';
import '../../widgets/secondary_app_bar.dart';

class Forbidden extends StatelessWidget {
  const Forbidden({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: const SecondaryAppBar(
          title: Text('محدودیت دسترسی'),
        ),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: const ScaffoldBodyContainer(
          child: Center(
            child: NoContentWidget(
              message: 'دسترسی شما به صفحه مورد نظر محدود شده است',
            ),
          ),
        ),
      );
}
