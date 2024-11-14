import 'package:get/get.dart';

import '../controller/news_preview_controller.dart';

class NewsPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NewsPreviewController.new);
  }
}
