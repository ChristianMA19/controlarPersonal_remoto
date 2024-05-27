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

  group('Users support', () {
    test('Get all users', () async {
      final userList = await repository.getUsers();
      await repository.addUser(User(
        name: "Juan",
        email: "Juan@Juan.com",
        password: "123456789101112",
      ));
      final userList2 = await repository.getUsers();
      expect(userList.length + 1, userList2.length);
      await repository.deleteUser(11);
    });
    test('Add user', () async {
      final userAdded = await repository.addUser(User(
        name: "Juan",
        email: "Juan@Juan.com",
        password: "123456789101112",
      ));
      expect(userAdded, isTrue);
    });

    test('Update user', () async {
      final userUpdated = await repository.updateUser(User(
        id: 11,
        name: "Jose",
        email: "Jose@juan.com",
        password: "1231234",
      ));
      expect(userUpdated, isTrue);
    });

    test('Update user bad', () async {
      final userUpdated = await repository.updateUser(User(
        id: 110,
        name: "Jose",
        email: "Jose@juan.com",
        password: "1231234",
      ));
      expect(userUpdated, isFalse);
    });

    test('Delete user', () async {
      final userDeleted = await repository.deleteUser(11);
      expect(userDeleted, isTrue);
    });

    test('Delete user bad', () async {
      final userDeleted = await repository.deleteUser(110);
      expect(userDeleted, isFalse);
    });


    test('Login user', () async {
      final userlogedin =
          await repository.login("preuba@sa.com", "16d45s32das");
      expect(userlogedin, isTrue);
    });
    test('Login user bad', () async {
      final userlogedin =
          await repository.login("preuba@saaaaaa.com", "16d45s32das");
      expect(userlogedin, isFalse);
    });
  });
}
