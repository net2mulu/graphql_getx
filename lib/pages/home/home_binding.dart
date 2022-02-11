import 'package:get/get.dart';
import 'package:qgl_get_rewrite/pages/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
} 