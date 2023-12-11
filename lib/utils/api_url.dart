import 'package:cardmonix/Helpers/constants.dart';

class AppUrl {
  static String baseUrl = Constants.getBackendUrl();

  static String login = baseUrl + '/api/v1/Signup';
  static String register = baseUrl + '/registration';
  static String forgotPassword = baseUrl + '/forgot_password';
}
