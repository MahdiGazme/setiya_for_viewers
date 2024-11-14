import 'package:get/get.dart';

import '../controller/management_news_list_controller.dart';

class ManagementNewsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ManagementNewsListController.new);
  }
}