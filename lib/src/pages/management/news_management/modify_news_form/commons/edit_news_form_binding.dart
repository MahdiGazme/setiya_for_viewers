import 'package:get/get.dart';

import '../controllers/edit_news_form_controller.dart';

class EditNewsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditNewsFormController.new);
  }
}
