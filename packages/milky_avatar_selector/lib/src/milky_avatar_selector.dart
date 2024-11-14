import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';

//TODO: use Material Badge and remove the plugin
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MilkyAvatarSelector extends StatelessWidget {
  static const double _defaultAvatarSize = 50.0;
  static const double _defaultSelectorButtonSize = 12.0;

  final void Function(XFile avatar)? onImageSelected;
  final void Function()? onDelete;
  final void Function()? onImageTap;
  final double size;
  final double selectorButtonIconSize;
  final bool showLoading;
  final double borderRadios;
  final double? maxHeight;
  final double? maxWidth;
  final int? imageQuality;
  final Color? backgroundColor;
  final Color? emptyIconColor;
  final Color? selectButtonBackGroundColor;
  final Color? selectButtonIconColor;
  final Color? galleryButtonIconColor;
  final Color? cameraButtonIconColor;
  final Color? deleteButtonIconColor;
  final Color? buttonBorderColor;
  final TextStyle? bottomSheetLabelStyle;
  final IconData? emptyIcon;
  final bool selectorMode;
  final int? cacheWidth;
  final int? cacheHeight;
  final Widget? loadingWidget;
  final BoxFit? fit;

  const MilkyAvatarSelector({
    required this.image,
    this.showLoading = false,
    this.onDelete,
    this.galleryButtonIconColor,
    this.cameraButtonIconColor,
    this.deleteButtonIconColor,
    this.buttonBorderColor,
    this.bottomSheetLabelStyle,
    this.onImageSelected,
    this.loadingWidget,
    this.fit,
    this.selectButtonBackGroundColor,
    this.selectButtonIconColor,
    this.selectorMode = false,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.backgroundColor,
    this.borderRadios = 0,
    this.emptyIcon,
    this.emptyIconColor,
    this.size = _defaultAvatarSize,
    this.selectorButtonIconSize = _defaultSelectorButtonSize,
    this.cacheHeight,
    this.cacheWidth,
    this.onImageTap,
    final Key? key,
  }) : super(key: key);

  MilkyAvatarSelector.network({
    final String? src,
    this.showLoading = false,
    this.onDelete,
    this.loadingWidget,
    this.onImageSelected,
    this.galleryButtonIconColor,
    this.cameraButtonIconColor,
    this.deleteButtonIconColor,
    this.buttonBorderColor,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.bottomSheetLabelStyle,
    this.fit,
    final Widget? errorWidget,
    this.selectButtonBackGroundColor,
    this.selectButtonIconColor,
    this.selectorMode = false,
    this.backgroundColor,
    this.borderRadios = 0,
    this.emptyIcon,
    this.emptyIconColor,
    this.size = 50,
    this.selectorButtonIconSize = 12,
    this.cacheHeight,
    this.cacheWidth,
    this.onImageTap,
    final Map<String, String>? headers,
    final double scale = 1.0,
    final Key? key,
  })  : image = src == null
            ? null
            : Image.network(
                src,
                cacheWidth: cacheWidth,
                cacheHeight: cacheHeight,
                fit: fit,
                width: size,
                height: size,
                frameBuilder: (final context, final child, final frame,
                        final wasSynchronouslyLoaded) =>
                    child,
                loadingBuilder: loadingWidget != null
                    ? (final context, final widget, final event) =>
                        event == null ? widget : loadingWidget
                    : null,
                errorBuilder: (final context, final widget, final event) =>
                    errorWidget ??
                    Icon(
                      emptyIcon ?? Icons.person,
                      size: size / 100 * 30,
                      color: emptyIconColor ??
                          Theme.of(context).colorScheme.secondary,
                    ),
                scale: scale,
                headers: headers,
              ),
        super(key: key);

  final Image? image;

  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => GestureDetector(
        child: _badge(context),
      );

  Widget _badge(final BuildContext context) => Badge(
        position: _badgePosition(),
        badgeColor: Theme.of(context).colorScheme.primary,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 3,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        showBadge: selectorMode && image != null,
        badgeContent: _selectorIcon(context),
        child: _profileContainer(context),
      );

  BadgePosition _badgePosition() => BadgePosition(
        bottom: selectorButtonPosition(
            size: size,
            radios: borderRadios,
            selectorIconSize: selectorButtonIconSize),
        start: selectorButtonPosition(
            size: size,
            radios: borderRadios,
            selectorIconSize: selectorButtonIconSize),
      );

  GestureDetector _selectorIcon(final BuildContext context) => GestureDetector(
        onTap: () => Get.bottomSheet(
          _bottomSheet(context),
        ),
        child: Icon(
          Icons.edit,
          size: selectorButtonIconSize,
          color: emptyIconColor ?? Theme.of(context).colorScheme.secondary,
        ),
      );

  Widget _profileContainer(final BuildContext context) => GestureDetector(
        onTap: () => _onProfilePictureTap(context),
        child: Container(
          height: size,
          width: size,
          decoration: _decoration(context),
          child: showLoading
              ? _defaultLoading()
              : image == null
                  ? _emptyIcon(context)
                  : _avatarImage(),
        ),
      );

  Widget _defaultLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  BoxDecoration _decoration(final BuildContext context) => BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(1, 2),
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            borderRadios,
          ),
        ),
      );

  Widget _emptyIcon(final BuildContext context) => Icon(
        emptyIcon ?? Icons.person,
        size: size / 100 * 30,
        color: emptyIconColor ?? Theme.of(context).colorScheme.secondary,
      );

  double selectorButtonPosition(
      {required final double size,
      required final double radios,
      required final double selectorIconSize}) {
    if (size / 2 > radios) {
      return radios / 2 / 2 - selectorIconSize / 2;
    } else {
      return size / 2 / 2 / 2 - selectorIconSize / 2;
    }
  }

  Widget _avatarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadios),
      clipBehavior: Clip.hardEdge,
      child: image,
    );
  }

  void _onCameraTap() async {
    final imagePicker = ImagePicker();
    final selectedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      imageQuality: imageQuality,
    );
    if (selectedImage != null) {
      onImageSelected!.call(selectedImage);
      Get.back();
    }
  }

  void _onProfilePictureTap(final BuildContext context) {
    if (image != null) {
      onImageTap?.call();
    } else if (selectorMode) {
      Get.bottomSheet(
        _bottomSheet(context),
      );
    }
  }

  void _onGalleryTap() async {
    final imagePicker = ImagePicker();
    final selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      imageQuality: imageQuality,
    );
    if (selectedImage != null) {
      onImageSelected!.call(selectedImage);
      Get.back();
    }
  }

  Widget _bottomSheet(final BuildContext context) => BottomSheet(
        onClosing: () {},
        builder: _bottomSheetContent,
        backgroundColor: Theme.of(context).colorScheme.background,
      );

  Padding _bottomSheetContent(final BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _labelAndDelete(context),
            const SizedBox(
              height: 10,
            ),
            _buttons(context),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      );

  Widget _buttons(final BuildContext context) => Row(
        children: [
          _camera(context),
          _gallery(context),
        ],
      );

  Widget _gallery(final BuildContext context) => _bottomSheetButtons(
        context,
        icon: Icon(
          CupertinoIcons.photo,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: 'گالری',
        onTap: _onGalleryTap,
      );

  Widget _camera(final BuildContext context) => _bottomSheetButtons(
        context,
        icon: Icon(
          CupertinoIcons.camera_fill,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: 'دوربین',
        onTap: _onCameraTap,
      );

  Widget _labelAndDelete(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'تصویر نمایه',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (image != null) _deleteIcon(context),
        ],
      );

  Widget _deleteIcon(final BuildContext context) => IconButton(
        onPressed: () {
          onDelete?.call();
          Get.back();
        },
        icon: Icon(
          CupertinoIcons.delete_solid,
          color: deleteButtonIconColor ??
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
        padding: EdgeInsets.zero,
      );

  Widget _bottomSheetButtons(
    final BuildContext context, {
    required final Widget icon,
    required final String label,
    required final Function() onTap,
  }) =>
      Column(
        children: [
          _sourceButton(onTap, context, icon),
          _sourceButtonLabel(label),
        ],
      );

  Widget _sourceButton(
    final Function() onTap,
    final BuildContext context,
    final Widget icon,
  ) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          onTap: onTap,
          focusColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          highlightColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: _sourceButtonsContainer(context, icon),
        ),
      );

  Widget _sourceButtonLabel(final String label) => Text(
        label,
      );

  Widget _sourceButtonsContainer(
          final BuildContext context, final Widget icon) =>
      DecoratedBox(
        decoration: _sourceButtonsDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: icon,
        ),
      );

  BoxDecoration _sourceButtonsDecoration(final BuildContext context) =>
      BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: buttonBorderColor ?? Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      );
}
