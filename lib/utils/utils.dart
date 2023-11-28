import 'package:cardmonix/helpers/state_manager.dart';
import 'package:get/get.dart';

class Auth {
  static AuthController auth() {
    return Get.put(AuthController());
  }
}
