import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:controlarpersonal_remoto/domain/models/user.dart';
import 'package:controlarpersonal_remoto/domain/repositories/repository.dart';
import 'package:controlarpersonal_remoto/domain/use_case/authentication_usecase.dart';
import 'package:controlarpersonal_remoto/domain/use_case/user_usecase.dart';
import 'package:controlarpersonal_remoto/ui/controller/authentication_controller.dart';

void main() {
  Repository repository = Get.put(Repository());
  AuthenticationUseCase authenticationUseCase =
      Get.put(AuthenticationUseCase());
  
  group('Users support login', () {
    test('Login user', () async {
      final userlogedin =
          await repository.login("preuba@sa.com", "123456");
      expect(userlogedin, isTrue);
    });

    test('Login user bad', () async {
      final userlogedin =
          await repository.login("preuba@saaaaaa.com", "16d45s32das");
      expect(userlogedin, isFalse);
    });

  });

}
