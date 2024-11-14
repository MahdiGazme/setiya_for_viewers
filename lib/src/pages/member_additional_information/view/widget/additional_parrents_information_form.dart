import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../infrastructures/utils/custom_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/required_text_field_label.dart';
import '../../controller/member_additional_information_controller.dart';

class AdditionalParentsInformationForm
    extends GetView<MemberAdditionalInformationController> {
  const AdditionalParentsInformationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _parentsInformationForm(context);

  Widget _parentsInformationForm(final BuildContext context) => DecoratedBox(
        decoration: _decoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              Text(
                'مشخصات والدین',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Utils.smallVerticalSpacer,
              _fatherNameTextField(),
              Utils.smallVerticalSpacer,
              _fatherJobTextField(),
              Utils.smallVerticalSpacer,
              _motherNameTextField(),
              Utils.smallVerticalSpacer,
              _motherMobileTextField()
            ],
          ),
        ),
      );

  Widget _fatherJobTextField() => TextFormField(
        controller: controller.fatherJob,
        decoration: const InputDecoration(
          label: Text('شغل پدر'),
          counterText: '',
        ),
        maxLength: 20,
      );

  Widget _fatherNameTextField() => TextFormField(
        controller: controller.fatherName,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'نام پدر',
          ),
          counterText: '',
        ),
        validator: (final value) => Utils.regularValidator(value!),
        maxLength: 20,
      );

  Widget _motherNameTextField() => TextFormField(
        controller: controller.motherName,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(
            label: 'نام مادر',
          ),
          counterText: '',
        ),
        validator: (final value) => Utils.regularValidator(value!),
        maxLength: 20,
      );

  Widget _motherMobileTextField() => TextFormField(
        controller: controller.motherMobileNumber,
        decoration: const InputDecoration(
          label: Text('تلفن مادر'),
          counterText: '',
          hintText: 'همراه با صفر یا بدون صفر',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 11,
        validator: (final value) {
          if (value!.isNotEmpty) {
            return CustomUtils.mobileNumberValidator(
              value,
              'شماره تلفن معتبر نمی باشد',
            );
          }
          return null;
        },
      );

  BoxDecoration _decoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
        color: CustomMilkyTheme.primaryColor.shade200,
      );
}
