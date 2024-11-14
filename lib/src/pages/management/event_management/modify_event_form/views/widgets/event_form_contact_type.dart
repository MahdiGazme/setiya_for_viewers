import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/models/enums/events_contact_type_enum.dart';
import '../../controllers/base_event_controller.dart';

class EventFormContactType<T extends BaseEventController> extends GetView<T> {
  const EventFormContactType({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: _containersDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('نوع مخاطب:'),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _justMembers(),
                    _membersWithMother(),
                    _justMothers(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _justMothers() => _contactTypeRadioWidget(
        EventContactTypEnum.justMothers,
      );

  Widget _membersWithMother() => _contactTypeRadioWidget(
        EventContactTypEnum.membersWithMother,
      );

  Widget _justMembers() => _contactTypeRadioWidget(
        EventContactTypEnum.justMembers,
      );

  Widget _contactTypeRadioWidget(
    final EventContactTypEnum value,
  ) =>
      Row(
        children: [
          Text(value.name),
          Radio<EventContactTypEnum>(
            value: value,
            groupValue: controller.contactType.value,
            onChanged: (final value) => controller.onContactTypeChanged(
              value!,
            ),
          ),
        ],
      );

  BoxDecoration _containersDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
