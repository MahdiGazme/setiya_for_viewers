import 'package:flutter/material.dart';

import '../../../../infrastructures/utils/utils.dart';
import '../../../shared/view/widgets/no_content_widget.dart';

class NotAuthorizedWidget extends StatelessWidget {
  final void Function() onAuthorizeButtonTap;

  const NotAuthorizedWidget(
      {required this.onAuthorizeButtonTap, final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: Utils.mediumPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NoContentWidget(
              message: 'برای دسترسی به پروفایل و بقیه امکانات احراز'
                  ' هویت خود را تکمیل کنید',
            ),
            Utils.giantVerticalSpacer,
            OutlinedButton(
                onPressed: onAuthorizeButtonTap,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_search_outlined,
                    ),
                    Utils.tinyHorizontalSpacer,
                    Text('احراز هویت'),
                  ],
                ))
          ],
        ),
      );
}
