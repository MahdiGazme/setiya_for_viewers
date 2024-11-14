import 'package:get/get.dart';

import '../controllers/add_news_form_controller.dart';

class AddNewsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AddNewsFormController.new);
  }

}