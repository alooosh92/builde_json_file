import 'package:builde_json_file/controller_home.dart';
import 'package:get/get.dart';

class BindingDef implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
