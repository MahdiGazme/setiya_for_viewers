import 'package:get/get.dart';

import '../controller/news_list_controller.dart';

class NewsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NewsListController.new);
  }
}
