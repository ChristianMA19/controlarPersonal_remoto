import 'package:controlarpersonal_remoto/domain/models/client.dart';
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
      await repository.deleteUser(userList2[userList2.length - 1].id!);
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
      final datos = await repository.getUsers();
      final userUpdated = await repository.updateUser(User(
        id: datos[datos.length - 1].id!,
        name: "Jose",
        email: "Jose@juan.com",
        password: "1231234",
      ));
      expect(userUpdated, isTrue);
    });

    test('Update user bad', () async {
      final userUpdated = await repository.updateUser(User(
        id: 1100,
        name: "Jose",
        email: "Jose@juan.com",
        password: "1231234",
      ));
      expect(userUpdated, isFalse);
    });

    test('Delete user', () async {
      final datos = await repository.getUsers();
      final userDeleted = await repository.deleteUser(datos[datos.length - 1].id!);
      expect(userDeleted, isTrue);
    });

    test('Delete user bad', () async {
      final userDeleted = await repository.deleteUser(1100);
      expect(userDeleted, isFalse);
    });

  });

  group('Authentication support', () {
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

    group('clients support', () {
    test('Get all clients', () async {
      final userList = await repository.getClients();
      await repository.addClient(Client(
        name: "Juan",
      ));
      final userList2 = await repository.getClients();
      expect(userList.length + 1, userList2.length);
      await repository.deleteUser(userList2[userList2.length - 1].id!);
    });
    test('Add clients', () async {
      final userAdded = await repository.addClient(Client(
        name: "Juan",
      ));
      expect(userAdded, isTrue);
    });

    test('Update clients', () async {
      final datos = await repository.getClients();
      final userUpdated = await repository.updateClient(Client(
        id: datos[datos.length - 1].id!,
        name: "Jose",
      ));
      expect(userUpdated, isTrue);
    });

    test('Update clients bad', () async {
      final userUpdated = await repository.updateClient(Client(
        id: 1100,
        name: "Jose",
      ));
      expect(userUpdated, isFalse);
    });

    test('Delete clients', () async {
      final datos = await repository.getClients();
      final userDeleted = await repository.deleteClient(datos[datos.length - 1].id!);
      expect(userDeleted, isTrue);
    });

    test('Delete clients bad', () async {
      final userDeleted = await repository.deleteClient(1100);
      expect(userDeleted, isFalse);
    });

  });
}
