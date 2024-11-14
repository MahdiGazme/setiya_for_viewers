import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../controllers/base_user_controller.dart';

class OrganizationInformationForm<T extends BaseUserController>
    extends GetView<T> {
  const OrganizationInformationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) =>
      _organizationInformationForm(context);

  Widget _organizationInformationForm(final BuildContext context) =>
      DecoratedBox(
        decoration: _fieldsDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              Text(
                'مشخصات سازمانی',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Utils.smallVerticalSpacer,
              _rateTextField(context),
              Utils.smallVerticalSpacer,
              _memberCodeTextField(context),
            ],
          ),
        ),
      );

  Widget _rateTextField(final BuildContext context) => TextFormField(
        controller: controller.rate,
        decoration: const InputDecoration(
          label: Text('امتیاز'),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      );

  Widget _memberCodeTextField(final BuildContext context) => TextFormField(
        controller: controller.memberCode,
        decoration: const InputDecoration(
          label: Text('کد عضویت'),
          counterText: '',
        ),
        maxLength: 5,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      );

  BoxDecoration _fieldsDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
        color: CustomMilkyTheme.primaryColor.shade200,
      );
}
