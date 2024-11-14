import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PreviewDialog extends StatelessWidget {
  final Widget child;
  final Widget? previewTitle;
  final Color? backGroundColor;

  const PreviewDialog({
    required this.child,
    this.backGroundColor,
    this.previewTitle,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: backGroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: previewTitle,
        content: SizedBox(
          height: 300,
          width: 300,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                PhotoView.customChild(
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  disableGestures: true,
                  customSize: const Size(300, 300),
                  tightMode: true,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      );
}
