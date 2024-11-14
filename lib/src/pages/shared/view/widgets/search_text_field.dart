import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? label;
  final String? hint;
  final bool showPrefix;
  final IconData prefixIcon;
  final void Function()? onPrefixTap;
  final void Function(String)? onChanged;

  const SearchTextField({
    this.controller,
    this.onChanged,
    this.label,
    this.hint,
    this.onPrefixTap,
    this.prefixIcon = Icons.settings_rounded,
    this.showPrefix = false,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => TextFormField(
        controller: controller,
        decoration: _decoration(context),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: onChanged,
        maxLines: 1,
      );

  InputDecoration _decoration(final BuildContext context) => InputDecoration(
        hintText: hint,
        label:  label,
        prefixIcon: showPrefix ? IconButton(
          onPressed: onPrefixTap,
          icon: Icon(
            prefixIcon,
          ),
        ) : null,
        suffixIcon: const Icon(Icons.search),
      );
}
