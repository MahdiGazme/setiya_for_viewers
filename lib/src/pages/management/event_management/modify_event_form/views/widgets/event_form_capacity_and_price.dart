import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../controllers/base_event_controller.dart';

class EventFormCapacityAndPrice<T extends BaseEventController>
    extends GetView<T> {
  const EventFormCapacityAndPrice({final Key? key}) : super(key: key);

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
              _maxCapacity(),
              Utils.smallVerticalSpacer,
              _price(),
            ],
          ),
        ),
      );

  Widget _price() => TextFormField(
        controller: controller.price,
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
            label: Text(
              'هزینه ثبت نام',
            ),
            counterText: ''),
        maxLength: 9,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      );

  Widget _maxCapacity() => TextFormField(
        controller: controller.maxCapacity,
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
            label: Text(
              'ظرفیت ثبت نام',
            ),
            counterText: ''),
        maxLength: 4,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      );

  Widget _title(final BuildContext context) => Text(
        'اختیاری:',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  BoxDecoration _containersDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
