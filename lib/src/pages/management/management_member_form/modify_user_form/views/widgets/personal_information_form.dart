import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/custom_utils.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/models/enums/member_marriage_status_enum.dart';
import '../../../../../shared/view/widgets/date_picker/setia_date_time_picker.dart';
import '../../../../../shared/view/widgets/required_text_field_label.dart';
import '../../controllers/base_user_controller.dart';

class PersonalInformationForm<T extends BaseUserController> extends GetView<T> {
  const PersonalInformationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => _personalInformationForm(context);

  Widget _personalInformationForm(final BuildContext context) => DecoratedBox(
        decoration: _decoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            children: [
              Text(
                'مشخصات شخصی',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Utils.smallVerticalSpacer,
              _firstNameTextField(context),
              Utils.smallVerticalSpacer,
              _lastNameTextField(context),
              Utils.smallVerticalSpacer,
              _nationalCodeTextField(context),
              Utils.smallVerticalSpacer,
              _mobileNumberTextField(context),
              Utils.smallVerticalSpacer,
              _birthDateDatePicker(),
              Utils.smallVerticalSpacer,
              _marriageField(),
            ],
          ),
        ),
      );

  Widget _birthDateDatePicker() => Obx(
        () => SetiaDateTimePicker(
          initialDate: controller.birthDate.value,
          label: const RequiredTextFieldLabel(label: 'تاریخ تولد'),
          startDate: Jalali(
            1300,
            01,
            01,
          ),
          validator: (final value) => Utils.regularValidator(value!),
          endDate: Jalali.now(),
          onDatePicked: (final date) => controller.birthDate.value = date,
        ),
      );

  Widget _marriageField() => DecoratedBox(
        decoration: _marriageStatusDecoration(),
        child: Padding(
          padding: Utils.tinyPadding,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('وضعیت تاهل :'),
                _singleRadio(),
                _marriedRadio(),
              ],
            ),
          ),
        ),
      );

  Widget _marriedRadio() => Row(
        children: [
          const Text('متاهل'),
          Radio<MemberMarriageStatusEnum>(
            value: MemberMarriageStatusEnum.married,
            groupValue: controller.marriageStatus.value,
            onChanged: (final value) =>
                controller.marriageStatus.value = value!,
          ),
        ],
      );

  Widget _singleRadio() => Row(
        children: [
          const Text('مجرد'),
          Radio<MemberMarriageStatusEnum>(
            value: MemberMarriageStatusEnum.single,
            groupValue: controller.marriageStatus.value,
            onChanged: (final value) =>
                controller.marriageStatus.value = value!,
          ),
        ],
      );

  BoxDecoration _marriageStatusDecoration() => BoxDecoration(
        color: CustomMilkyTheme.secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      );

  Widget _firstNameTextField(final BuildContext context) => TextFormField(
        controller: controller.firstName,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(label: 'نام'),
          counterText: '',
        ),
        maxLength: 20,
        validator: (final value) => Utils.regularValidator(value!),
      );

  Widget _mobileNumberTextField(final BuildContext context) => TextFormField(
        controller: controller.mobileNumber,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(label: 'شماره موبایل'),
          counterText: '',
          hintText: 'همراه با صفر یا بدون صفر',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 11,
        validator: (final value) => CustomUtils.mobileNumberValidator(
          value!,
          'شماره موبایل معتبر نمی باشد',
        ),
      );

  Widget _nationalCodeTextField(final BuildContext context) => TextFormField(
        controller: controller.nationalCode,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(label: 'کد ملی'),
          counterText: '',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 10,
        validator: (final value) => CustomUtils.nationalCodeValidator(
          value!,
          'کد ملی معتبر نمی باشد',
        ),
      );

  Widget _lastNameTextField(final BuildContext context) => TextFormField(
        controller: controller.lastName,
        decoration: const InputDecoration(
          label: RequiredTextFieldLabel(label: 'نام خانوادگی'),
          counterText: '',
        ),
        maxLength: 20,
        validator: (final value) => Utils.regularValidator(value!),
      );

  BoxDecoration _decoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            CustomMilkyTheme.borderRadiusSemiRound,          ),
        ),
        color: CustomMilkyTheme.primaryColor.shade200,
      );
}
