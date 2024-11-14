import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/required_text_field_label.dart';
import '../../controllers/base_event_controller.dart';

class EventFormBaseInformation<T extends BaseEventController>
    extends GetView<T> {
  const EventFormBaseInformation({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: _containersDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(context),
              Utils.smallVerticalSpacer,
              _title(),
              Utils.smallVerticalSpacer,
              _description(),
              Utils.smallVerticalSpacer,
              _address(),
            ],
          ),
        ),
      );

  Widget _address() => TextFormField(
        controller: controller.address,
        validator: (final value) => Utils.regularValidator(value!),
        maxLines: 3,
        maxLength: 100,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'آدرس',
          ),
          counterText: '',
        ),
      );

  Widget _description() => TextFormField(
        controller: controller.description,
        validator: (final value) => Utils.regularValidator(value!),
        maxLines: 7,
        maxLength: 500,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'توضیحات',
          ),
          counterText: '',
        ),
      );

  Widget _title() => TextFormField(
        controller: controller.title,
        validator: (final value) => Utils.regularValidator(value!),
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'عنوان',
          ),
          counterText: '',
        ),
        maxLength: 70,
      );

  Text _label(final BuildContext context) => Text(
        'مشخصات:',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  BoxDecoration _containersDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
