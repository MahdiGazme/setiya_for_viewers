import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../../infrastructures/utils/utils.dart';
import '../../../../../../shared/view/dialogs/setiya_alert_dialog.dart';

class AttendanceByMembershipCodeDialog extends StatelessWidget {
  final controller = TextEditingController();
  final GlobalKey<FormState> formKey;
  final void Function(String membershipCode) onTap;

  AttendanceByMembershipCodeDialog({
    required this.formKey,
    required this.onTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => SetiyaAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _title(context),
            Utils.smallVerticalSpacer,
            _container(),
            Utils.mediumVerticalSpacer,
            _buttons(),
          ],
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: Get.back,
            child: const Text('بازگشت'),
          ),
          Utils.smallHorizontalSpacer,
          ElevatedButton(
            onPressed: () => onTap.call(controller.text),
            child: const Text('جست و جو'),
          ),
        ],
      );

  Widget _container() => DecoratedBox(
        decoration: _containerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: _textField(),
        ),
      );

  Widget _textField() => Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
            label: Text(
              'کد عضویت',
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (final value) => Utils.regularValidator(
            value!,
          ),
        ),
      );

  BoxDecoration _containerDecoration() => BoxDecoration(
        color: CustomMilkyTheme.primaryColor.shade300,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Text _title(final BuildContext context) => Text(
        'کد عضویت را وارد کنید',
        style: Theme.of(context).textTheme.titleSmall,
      );
}
