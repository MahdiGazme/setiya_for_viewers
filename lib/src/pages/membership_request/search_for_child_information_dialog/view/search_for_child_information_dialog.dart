import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../infrastructures/utils/custom_utils.dart';
import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/dialogs/getx_view.dart';
import '../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../shared/view/widgets/asset_icon.dart';
import '../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/search_for_child_information_dialog_controller.dart';

class SearchForChildInformationDialog
    extends GetxView<SearchForChildInformationDialogController> {
  const SearchForChildInformationDialog(
    super.controller, {
    super.key,
  });

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: _icon(),
        title: _title(),
        content: _content(),
      );

  Widget _title() => const Text('کد ملی فرزند خود را وارد کنید');

  Widget _content() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _form(),
          Utils.mediumVerticalSpacer,
          _buttons(),
        ],
      );

  Widget _form() => Form(
        key: controller.formKey,
        child: TextFormField(
          controller: controller.controller,
          decoration: const InputDecoration(
            label: Text('کد ملی'),
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
        ),
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _backButton(),
          Utils.smallHorizontalSpacer,
          _searchButton(),
        ],
      );

  Widget _searchButton() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onSearchButtonTap,
          showLoading: controller.isLoading.value,
          child: const Text('جست و جو'),
        ),
      );

  Widget _backButton() => OutlinedButton(
        onPressed: Get.back,
        child: const Text('بازگشت'),
      );

  Widget _icon() => const Align(
        child: AssetIcon(
          path: 'lib/assets/menu_icons/authorize.png',
          size: 50,
        ),
      );
}
