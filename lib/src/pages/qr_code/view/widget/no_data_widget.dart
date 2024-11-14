import 'package:flutter/material.dart';

import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/no_content_widget.dart';

class NoDataWidget extends StatelessWidget {
  final void Function() onLoginButtonTap;

  const NoDataWidget({
    required this.onLoginButtonTap,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NoContentWidget(
            message: 'مشخصات هویتی شما در دسترس نیست '
                'لطفا یکبار وارد حساب کاربری خود شوید',
          ),
          Utils.largeVerticalSpacer,
          TextButton(
            onPressed: onLoginButtonTap,
            child: const Text(
              'ورود به حساب کاربری',
            ),
          ),
        ],
      );
}
