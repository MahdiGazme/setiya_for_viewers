import 'package:flutter/material.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../models/enums/events_contact_type_enum.dart';

class EventContactTypeWidget extends StatelessWidget {
  final EventContactTypEnum contactType;

  const EventContactTypeWidget({
    required this.contactType,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _decoration(),
        child: Padding(
          padding: Utils.tinyPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                contactType.name,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CustomMilkyTheme.primaryColor.shade500,
                    fontSize: 10),
              ),
              Icon(
                Icons.done,
                size: 13,
                color: CustomMilkyTheme.primaryColor.shade500,
              ),
            ],
          ),
        ),
      );

  BoxDecoration _decoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: CustomMilkyTheme.primaryColor.shade500,
        ),
      );
}
