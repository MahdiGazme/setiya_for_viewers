import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/custom_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/required_text_field_label.dart';
import '../../controller/member_additional_information_controller.dart';

class AdditionalHomeInformationForm
    extends GetView<MemberAdditionalInformationController> {
  const AdditionalHomeInformationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _homeInformationForm(context);

  Widget _homeInformationForm(final BuildContext context) => DecoratedBox(
        decoration: _fieldsDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              Text(
                'مشخصات محل سکونت',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Utils.smallVerticalSpacer,
              _telephoneTextField(),
              Utils.smallVerticalSpacer,
              _address(),
            ],
          ),
        ),
      );

  Widget _address() => TextFormField(
        controller: controller.address,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'آدرس',
          ),
          counterText: '',
        ),
        validator: (final value) => Utils.regularValidator(value!),
        maxLines: 3,
      );

  Widget _telephoneTextField() => TextFormField(
      controller: controller.telephone,
      decoration: const InputDecoration(
        label: Text('تلفن محل سکونت'),
        hintText: 'همراه با کد استان با صفر یا بدون صفر',
        counterText: '',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 11,
      validator: (final value) {
        if (value!.isNotEmpty) {
          return CustomUtils.telephoneNumberValidator(
            value,
            'شماره تلفن معتبر نمی باشد',
          );
        }
        return null;
      });

  BoxDecoration _fieldsDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,
          ),
        ),
        color: CustomMilkyTheme.primaryColor.shade200,
      );
}
