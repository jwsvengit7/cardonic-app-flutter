import 'package:cardmonix/dto/response/User.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  void setUser(User newUser) {
    user.value = newUser;
  }

  void logout() {
    user.value = null;
  }
}
