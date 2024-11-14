

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../controller/management_event_details_controller.dart';

class ManagementEventDetailsOptions
    extends GetView<ManagementEventDetailsController> {
  const ManagementEventDetailsOptions({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _options();

  Widget _options() => Card(
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              _eventOptionItem(
                icon: Icons.comment_rounded,
                title: 'لیست نظرسنجی',
                onTap: controller.onEventMembersSurveyListButtonTap,
              ),
              Utils.smallVerticalSpacer,
              _eventOptionItem(
                icon: Icons.person_search,
                title: 'لیست شرکت کنندگان',
                onTap: controller.onEventMembersButtonTap,
              ),
              if (!controller.eventDetails.isExecuted) _editAndDelete()
            ],
          ),
        ),
      );

  Column _editAndDelete() => Column(
        children: [
          Utils.smallVerticalSpacer,
          _eventOptionItem(
            icon: Icons.edit,
            title: 'ویرایش',
            onTap: controller.onEditEventTap,
          ),
          Utils.smallVerticalSpacer,
          _eventOptionItem(
            icon: Icons.delete,
            title: 'حذف',
            onTap: controller.onDeleteEventTap,
          ),
        ],
      );

  Widget _eventOptionItem({
    required final IconData icon,
    required final String title,
    required final void Function() onTap,
  }) =>
      InkWell(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusRound,
        ),
        onTap: onTap,
        child: Padding(
          padding: Utils.tinyPadding,
          child: Row(
            children: [
              Icon(
                icon,
                color: CustomMilkyTheme.accentColor,
              ),
              Utils.smallHorizontalSpacer,
              Text(
                title,
              ),
            ],
          ),
        ),
      );
}
