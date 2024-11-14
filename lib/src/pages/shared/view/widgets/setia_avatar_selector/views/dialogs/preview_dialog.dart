import 'package:flutter/material.dart';

import '../../../../../../../infrastructures/themes/custom_milky_theme.dart';

class PreviewDialog extends StatelessWidget {
  final String src;
  final Widget? previewTitle;

  const PreviewDialog({
    required this.src,
    this.previewTitle,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: CustomMilkyTheme.secondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: previewTitle,
        content: SizedBox(
          height: 300,
          width: 300,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: _image(),
          ),
        ),
      );

  Widget _image() => Image.network(
        src,
        fit: BoxFit.cover,
        frameBuilder: (final context, final child, final frame,
                final wasSynchronouslyLoaded) =>
            child,
        loadingBuilder: (final context, final widget, final event) =>
            event == null ? widget : _loading(),
        errorBuilder: (final context, final widget, final event) =>
            _emptyWidget(),
      );

  Widget _emptyWidget() =>  Icon(
        Icons.person,
        size: 60,
        color: CustomMilkyTheme.primaryColor,
      );

  Widget _loading() => const Center(
        child: CircularProgressIndicator(),
      );
}
