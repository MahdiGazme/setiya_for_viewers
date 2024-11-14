import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../infrastructures/utils/utils.dart';
import '../../../../shared/view/widgets/page_state.dart';
import '../../../../shared/view/widgets/scaffold_body_container.dart';
import '../../../../shared/view/widgets/secondary_app_bar.dart';
import '../../../../shared/view/widgets/setiya_elevated_button.dart';
import '../controller/members_event_survey_form_controller.dart';
import 'widget/members_event_survey_form_image_widget.dart';

class MembersEventSurveyForm extends GetView<MembersEventSurveyFormController> {
  const MembersEventSurveyForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        appBar: _appBar(),
        body: _body(context),
        backgroundColor: CustomMilkyTheme.primaryColor,
      );

  SecondaryAppBar _appBar() => const SecondaryAppBar(
        title: Text(
          'بازخورد رویداد',
        ),
      );

  Widget _body(final BuildContext context) => ScaffoldBodyContainer(
        child: PageStateProvider(
          state: controller.state,
          onRetry: controller.getEventDetails,
          page: () => _bodyContent(context),
        ),
      );

  Widget _bodyContent(final BuildContext context) => SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: Utils.smallPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hint(context),
                Utils.smallVerticalSpacer,
                MembersEventSurveyFormImageWidget(
                  imageId: controller.eventDetails.imageId,
                ),
                Utils.smallVerticalSpacer,
                _eventTitle(context),
                Utils.mediumVerticalSpacer,
                _ratingBar(),
                Utils.mediumVerticalSpacer,
                _commentTextField(),
                Utils.largeVerticalSpacer,
                _button()
              ],
            ),
          ),
        ),
      );

  Widget _button() => Center(
        child: Obx(
          () => SetiyaElevatedButton(
            onPressed: controller.onSubmitCommentTap,
            showLoading: controller.isLoading.value,
            child: const Text(
              'ثبت بازخورد',
            ),
          ),
        ),
      );

  Widget _commentTextField() => TextFormField(
        controller: controller.comment,
        decoration: const InputDecoration(
          label: Text('توضیحات اختیاری'),
        ),
        maxLines: 5,
        maxLength: 250,
      );

  Widget _ratingBar() => Center(
        child: RatingBar.builder(
          direction: Axis.horizontal,
          minRating: 1,
          itemCount: 5,
          itemSize: 50,
          tapOnlyMode: true,
          wrapAlignment: WrapAlignment.center,
          unratedColor: CustomMilkyTheme.accentColor.withOpacity(0.4),
          itemBuilder: (final context, final index) => Icon(
            Icons.star_rate_rounded,
            color: CustomMilkyTheme.primaryColor,
          ),
          onRatingUpdate: (final value) => controller.rate = value,
        ),
      );

  Widget _eventTitle(final BuildContext context) => Text(
        controller.eventDetails.title,
        style: Theme.of(context).textTheme.titleSmall,
      );

  Widget _hint(final BuildContext context) => DecoratedBox(
        decoration: _hintDecoration(),
        child: Padding(
          padding: Utils.smallPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: CustomMilkyTheme.accentColor,
              ),
              Utils.smallHorizontalSpacer,
              _hintText(context)
            ],
          ),
        ),
      );

  Widget _hintText(final BuildContext context) => Expanded(
              child: Text(
                'با ثبت بازخورد خود به ستیا برای'
                ' بالا بردن کیفیت رویداد ها '
                'کمک می کنید و از ۵ امتیاز'
                ' تشویقی بهره مند می شوید',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );

  BoxDecoration _hintDecoration() => BoxDecoration(
        color: CustomMilkyTheme.warningColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );
}
