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
import '../controllers/add_news_form_controller.dart';
import '../controllers/base_new_form_controller.dart';
import 'widget/news_form_expire_date.dart';

class ModifyNewsForm<T extends BaseNewsFormController> extends GetView<T> {
  const ModifyNewsForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        backgroundColor: CustomMilkyTheme.primaryColor,
        appBar: _appBar(),
        body: _body(context),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          page: () => _content(context),
          onRetry: controller.getOldNews,
        ),
      );

  Widget _content(final BuildContext context) => Column(
        children: [
          _form(context),
          Utils.mediumVerticalSpacer,
          _releaseButton()
        ],
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
                    _title(),
                    Utils.smallVerticalSpacer,
                    _newsContent(),
                    Utils.mediumVerticalSpacer,
                    NewsFormExpireDate<T>(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _imageSelector() => MultiImageSelector(
        title: 'عکس های خبر:',
        isLoading: controller.isPicturesUploading.value,
        imageIds: controller.pictureIds(),
        onDeleteImageTap: controller.onDeletePictureTap,
        onMakeMainImageTap: controller.onMakeMainPictureTap,
        onImagesSelected: controller.onAddPictureTap,
        limit: 5,
        mainPictureId: controller.mainPictureId.value,
      );

  Widget _newsContent() => TextFormField(
        controller: controller.content,
        validator: (final value) => Utils.regularValidator(value!),
        decoration: const InputDecoration(
          label: Text('متن خبر'),
        ),
        maxLines: 10,
      );

  Widget _title() => TextFormField(
        controller: controller.title,
        validator: (final value) => Utils.regularValidator(value!),
        decoration: const InputDecoration(
          label: Text('عنوان خبر'),
        ),
      );

  Widget _hint(final BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: CustomMilkyTheme.infoColor,
            size: 20,
          ),
          Utils.smallHorizontalSpacer,
          Expanded(
            child: Text(
              'توضیحات: \n۱. لطفا در انتخاب عکس اصلی دقت فرمایید،'
              ' عکس ستاره دار به عنوان عکس اصلی خبر در صفحه اصلی و '
              'لیست اخبار نمایش داده میشود.\n۲. برای نمایش بهتر عکس ها از'
              ' تصاویری که با حالت افقی و نسبت 16:9 تصویر برداری شده'
              ' اند استفاده کنید',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CustomMilkyTheme.infoColor,
                  ),
            ),
          )
        ],
      );

  SecondaryAppBar _appBar() => SecondaryAppBar(
        title: Text(
          T == AddNewsFormController ? 'افزودن خبر' : 'ویرایش خبر',
        ),
      );

  Widget _releaseButton() => Obx(
        () => SetiyaElevatedButton(
          showLoading: controller.isUploading.value,
          onPressed: controller.onButtonTap,
          child: Text(
            T == AddNewsFormController ? 'انتشار خبر' : 'ویرایش خبر',
          ),
        ),
      );
}
