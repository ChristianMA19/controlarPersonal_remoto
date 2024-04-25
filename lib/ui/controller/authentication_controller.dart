import 'package:controlarpersonal_remoto/domain/use_case/authentication_usecase.dart';
import 'package:get/get.dart';

import 'package:loggy/loggy.dart';

class AuthenticationController extends GetxController {
  final logged = false.obs;
  
  bool get isLogged => logged.value;

   Future<bool> login(String email, String password) async {
    final AuthenticationUseCase authentication = Get.find();
    try {
      logInfo('Controller Login');
      bool loggedIn = await authentication.login(email, password);
      logged.value = loggedIn;
      return loggedIn;
    } catch (e) {
      logError('Error during login: $e');
      return false;
    }
  }

  Future<void> logOut() async {
    logged.value = false;
  }
}