import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/widgets/required_text_field_label.dart';
import '../../controllers/base_event_controller.dart';

class EventFormRates<T extends BaseEventController> extends GetView<T> {
  const EventFormRates({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: _containersDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              Utils.smallVerticalSpacer,
              _minimumRate(),
              Utils.smallVerticalSpacer,
              _giftRate(),
            ],
          ),
        ),
      );

  Widget _giftRate() => TextFormField(
        controller: controller.giftRate,
        validator: (final value) => Utils.regularValidator(value!),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'امتیاز تشویقی',
          ),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      );

  Widget _minimumRate() => TextFormField(
        controller: controller.minimumRate,
        keyboardType: TextInputType.number,
        validator: (final value) => Utils.regularValidator(value!),
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'حداقل امتیاز مورد نیاز',
          ),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      );

  Widget _title(final BuildContext context) => Text(
        'امتیاز:',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  BoxDecoration _containersDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
