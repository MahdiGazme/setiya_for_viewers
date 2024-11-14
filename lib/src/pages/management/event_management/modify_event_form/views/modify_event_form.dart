import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/multi_image_selector/multi_image_selector.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controllers/add_event_controller.dart';
import '../controllers/base_event_controller.dart';
import 'widgets/event_form_base_information.dart';
import 'widgets/event_form_capacity_and_price.dart';
import 'widgets/event_form_contact_type.dart';
import 'widgets/event_form_date_and_time.dart';
import 'widgets/event_form_need_to_accept_chec_box.dart';
import 'widgets/event_form_rates.dart';

class ModifyEventForm<T extends BaseEventController> extends GetView<T> {
  const ModifyEventForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(),
        backgroundColor: CustomMilkyTheme.primaryColor,
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          page: () => _content(context),
          onRetry: controller.onRetryButtonTap,
          state: controller.state,
        ),
      );

  Widget _content(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _form(context),
          Utils.smallVerticalSpacer,
          _button(),
        ],
      );

  Widget _button() => Obx(
        () => SetiyaElevatedButton(
          onPressed: controller.onReleaseButtonTap,
          showLoading: controller.isLoading.value,
          child: Text(
            T == AddEventController ? 'ثبت' : 'ویرایش',
          ),
        ),
      );

  Widget _form(final BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: Utils.smallPadding,
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    _hint(context),
                    Utils.smallVerticalSpacer,
                    _imageSelector(),
                    Utils.mediumVerticalSpacer,
                    EventFormBaseInformation<T>(),
                    Utils.smallVerticalSpacer,
                    EventFormDateAndTime<T>(),
                    Utils.smallVerticalSpacer,
                    EventFormRates<T>(),
                    Utils.smallVerticalSpacer,
                    EventFormNeedToAcceptCheckBox<T>(),
                    Utils.smallVerticalSpacer,
                    EventFormContactType<T>(),
                    Utils.smallVerticalSpacer,
                    EventFormCapacityAndPrice<T>(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _imageSelector() => MultiImageSelector(
        imageIds: controller.imageIds,
        mainPictureId: controller.mainImageId.value,
        onImagesSelected: controller.onPhotoPickerButtonTap,
        onDeleteImageTap: controller.onDeleteImageTap,
        onMakeMainImageTap: controller.onMakeMainImageTap,
        isLoading: controller.isImageUploading.value,
        title: 'تصویر رویداد:',
        limit: 1,
      );

  Widget _hint(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.accentColor,
          ),
          Utils.smallHorizontalSpacer,
          _hintText(context),
        ],
      );

  Widget _hintText(final BuildContext context) => Expanded(
        child: Text(
          'برای نمایش بهتر عکس ها از '
          'تصاویری'
          ' که با حالت افقی تصویر برداری شده اند استفاده کنید.',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: CustomMilkyTheme.infoColor,
              ),
        ),
      );

  SecondaryAppBar _appBar() => SecondaryAppBar(
        title: Text(
          T == AddEventController ? 'رویداد جدید' : 'ویرایش رویداد',
        ),
      );
}
