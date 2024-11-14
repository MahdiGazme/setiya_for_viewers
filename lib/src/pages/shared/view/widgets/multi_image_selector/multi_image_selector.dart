import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../logo.dart';
import 'multi_image_selector_image_component.dart';

class MultiImageSelector extends StatefulWidget {
  final List<String> imageIds;
  final bool isLoading;
  final void Function(List<XFile> selectedImages) onImagesSelected;
  final void Function(String imageId) onMakeMainImageTap;
  final void Function(String imageId) onDeleteImageTap;
  final String? mainPictureId;
  final int limit;
  final String title;

  const MultiImageSelector({
    required this.imageIds,
    required this.onImagesSelected,
    required this.onDeleteImageTap,
    required this.onMakeMainImageTap,
    required this.isLoading,
    required this.title,
    this.mainPictureId,
    this.limit = 5,
    final Key? key,
  }) : super(key: key);

  @override
  State<MultiImageSelector> createState() => _MultiImageSelectorState();
}

class _MultiImageSelectorState extends State<MultiImageSelector> {
  @override
  Widget build(final BuildContext context) => _body(context);

  Widget _body(final BuildContext context) => DecoratedBox(
        decoration: _containerDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              Utils.smallVerticalSpacer,
              if (widget.imageIds.isNotEmpty)
                _imagesComponent()
              else
                _emptyWidget(),
              Utils.mediumVerticalSpacer,
              _addImageButtonAndImagesCount(context),
            ],
          ),
        ),
      );

  Widget _imagesComponent() => MultiImageSelectorImageComponent(
        imageIds: widget.imageIds,
        mainPictureId: widget.mainPictureId!,
        onMainPictureChanged: widget.onMakeMainImageTap,
        onPictureDeleted: widget.onDeleteImageTap,
      );

  Widget _emptyWidget() => Center(
        child: SetiaLogo(
          size: 110,
          color: CustomMilkyTheme.accentColor.withOpacity(
            0.3,
          ),
        ),
      );

  Widget _title() => Text(widget.title);

  BoxDecoration _containerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
        color: Colors.transparent,
        border: _imageFieldBorder(),
      );

  Widget _addImageButtonAndImagesCount(final BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _counter(context),
          _addButton(),
        ],
      );

  Widget _addButton() => OutlinedButton(
        onPressed: !widget.isLoading && widget.imageIds.length < widget.limit
            ? onSelectButtonTap
            : null,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
            ),
            Utils.smallHorizontalSpacer,
            Text('عکس جدید')
          ],
        ),
      );

  Widget _counter(final BuildContext context) => Expanded(
        child: Text(
          'مجموع عکس ها: ${widget.limit}/${widget.imageIds.length}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );

  Border _imageFieldBorder() => Border.all(
        color: CustomMilkyTheme.primaryColor.shade300,
        width: 2,
        strokeAlign: BorderSide.strokeAlignOutside,
      );

  Future<void> onSelectButtonTap() async {
    final selectedImages = await _selectImages();
    widget.onImagesSelected.call(selectedImages);
  }

  Future<List<XFile>> _selectImages() async {
    final imagePicker = ImagePicker();
    final selectedImage = await imagePicker.pickMultiImage(
      maxWidth: 836,
      maxHeight: 675,
      imageQuality: 25,
    );
    return selectedImage;
  }
}
