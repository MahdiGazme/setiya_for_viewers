import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import 'package:milky_avatar_selector/milky_avatar_selector.dart';
import 'package:milky_http_client/milky_http_client.dart';

import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';
import '../../loading_indicator.dart';
import '../controllers/setia_avatar_selector_controller.dart';
import 'dialogs/preview_dialog.dart';

class SetiaAvatarSelector extends StatelessWidget {
  final void Function(String avatarId)? onUploadDone;
  final void Function()? onDelete;
  final double size;
  final double? selectorIconSize;
  final double borderRadios;
  final bool selectorMode;
  final String? memberName;
  final BoxFit? fit = BoxFit.cover;

  final SetiaAvatarSelectorController _controller;

  SetiaAvatarSelector({
    required this.selectorMode,
    this.onDelete,
    this.memberName,
    this.onUploadDone,
    final String? avatarId,
    this.size = 50,
    this.selectorIconSize = 12,
    this.borderRadios = 0,
    final Key? key,
  })  : _controller = SetiaAvatarSelectorController(avatarId: avatarId),
        super(key: key);

  @override
  Widget build(final BuildContext context) => Obx(
        () => MilkyAvatarSelector.network(
          src: _controller.src,
          headers: Utils.avatarHeader,
          onDelete: onDelete,
          size: size,
          fit: fit,
          maxWidth: 836,
          maxHeight: 675,
          imageQuality: 25,
          showLoading: _controller.showLoading.value,
          loadingWidget: const PageLoadingIndicator(),
          selectorButtonIconSize: selectorIconSize!,
          cameraButtonIconColor: CustomMilkyTheme.primaryColor,
          backgroundColor: CustomMilkyTheme.primaryColor.shade300,
          emptyIconColor: CustomMilkyTheme.secondaryColor,
          buttonBorderColor: CustomMilkyTheme.accentColor,
          onImageTap: () => Get.dialog(
            _previewDialog(context),
          ),
          galleryButtonIconColor: CustomMilkyTheme.primaryColor,
          deleteButtonIconColor: CustomMilkyTheme.accentColor.withOpacity(0.7),
          selectorMode: selectorMode,
          borderRadios: borderRadios,
          onImageSelected: (final image) async {
            final bytes = await image.readAsBytes();
            final MultipartFile multipartFile =
                MultipartFile.fromBytes(bytes, filename: image.name);
            final formData = FormData.fromMap({
              'file': multipartFile,
            });

            final avatarId = await _controller.uploadAvatar(formData);

            if (avatarId != null) {
              onUploadDone?.call(avatarId);
            }
          },
        ),
      );

  Widget _previewDialog(final BuildContext context) => PreviewDialog(
        previewTitle: memberName != null ? _memberNameWidget(context) : null,
        src: _controller.src!,
      );

  Widget _memberNameWidget(final BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Image.asset(
              'lib/assets/images/logo_secondary.png',
              package: 'setia_module',
              fit: BoxFit.cover,
              width: 40,
              color: CustomMilkyTheme.primaryColor,
            ),
            Utils.mediumHorizontalSpacer,
            Expanded(
              child: Text(
                memberName!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: CustomMilkyTheme.primaryColor,
                    ),
              ),
            ),
          ],
        ),
      );
}
