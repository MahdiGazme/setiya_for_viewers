import 'package:flutter/material.dart';

class UsersInformationWidget extends StatelessWidget {
  final String label;
  final String? value;

  const UsersInformationWidget({
    required this.label,
    this.value,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: Text(
              value == null || value!.isEmpty ? 'ثبت نشده' : value!,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
}
