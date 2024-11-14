import 'package:flutter/material.dart';

import '../../../../../../infrastructures/commons/repository_urls.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';

class MembersEventSurveyFormImageWidget extends StatelessWidget {
  final String? imageId;

  const MembersEventSurveyFormImageWidget({
    required this.imageId,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.width <
                Utils.defaultResponsiveMaxWidth
            ? 9 *
                (MediaQuery.of(context).size.width - Utils.smallSpace * 4) /
                16
            : 9 * (Utils.defaultResponsiveMaxWidth - Utils.smallSpace * 4) / 16,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: CustomMilkyTheme.primaryColor.shade300,
          child: imageId != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    CustomMilkyTheme.borderRadiusSemiRound,
                  ),
                  child: Image.network(
                    RepositoryUrls.downloadDocumentUrl(
                      imageId!,
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: Image.asset(
                    'lib/assets/images/logo_secondary.png',
                    package: 'setia_module',
                    height: 70,
                  ),
                ),
        ),
      );
}
