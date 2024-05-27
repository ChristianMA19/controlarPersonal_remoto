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
  UserUseCase userUseCase = Get.put(UserUseCase());

  group('Users support', () {
    test('Get all users', () async {
      final userList = await userUseCase.getUsers();
      await userUseCase.addUser(User(
        name: "Juan",
        email: "Juan@Juan.com",
        password: "123456789101112",
      ));
      final userList2 = await userUseCase.getUsers();
      expect(userList.length + 1, userList2.length);
      await userUseCase.deleteUser(11);
    });

    test('Add users', () async {
      final userAdded = await userUseCase.addUser(User(
        name: "Juan",
        email: "Juan@Juan.com",
        password: "123456789101112",
      ));
      expect(userAdded, isTrue);
    });

    test('Update users', () async {
      final userUpdated = await userUseCase.updateUser(User(
        id: 11,
        name: "Jose",
        email: "Jose@juan.com",
        password: "123123",
      ));
      expect(userUpdated, isTrue);
    });

    test('Update user bad', () async {
      final userUpdated = await userUseCase.updateUser(User(
        id: 110,
        name: "Jose",
        email: "Jose@juan.com",
        password: "1231234",
      ));
      expect(userUpdated, isFalse);
    });

    test('Delete users', () async {
      final userDeleted = await userUseCase.deleteUser(11);
      expect(userDeleted, isTrue);
    });

    test('Delete user bad', () async {
      final userDeleted = await userUseCase.deleteUser(110);
      expect(userDeleted, isFalse);
    });
    
  });
}
