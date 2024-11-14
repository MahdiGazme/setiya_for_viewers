import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../../../../shared/view/dialogs/setiya_alert_dialog.dart';
import '../../../../../shared/view/widgets/asset_icon.dart';

class MemberEventSubmitAwaitDialog extends StatelessWidget {
  const MemberEventSubmitAwaitDialog({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => SetiyaAlertDialog(
        icon: const Align(
          child: AssetIcon(
            path: 'lib/assets/menu_icons/warning.png',
            size: 50,
          ),
        ),
        title: _title(),
        content: _content(),
      );

  Widget _content() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _coloredBox(),
          Utils.smallVerticalSpacer,
          _button(),
        ],
      );

  Widget _button() => ElevatedButton(
        onPressed: Get.back,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            CustomMilkyTheme.warningColor,
          ),
        ),
        child: const Text('متوجه شدم'),
      );

  Widget _coloredBox() => DecoratedBox(
        decoration: _decoration(),
        child: _description(),
      );

  Widget _description() => const Padding(
        padding: Utils.smallPadding,
        child: Text(
          'این رویداد نیاز به'
          ' تایید مدیر دارد. درخواست ثبت نام شما برای مدیر ارسال شد. در صورت '
          'تایید این رویداد در پنل مدیریت رویدادها قابل مشاهده خواهد بود. لطفا'
          ' پیش از شرکت در رویداد از تایید شدن'
          ' درخواست خود اطمینان حاصل نمایید.',
        ),
      );

  BoxDecoration _decoration() => BoxDecoration(
        color: CustomMilkyTheme.warningColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  Widget _title() => const Text('توجه !!!');
}
