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
      await userUseCase.deleteUser(userList2[userList2.length - 1].id!);
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
      final datos = await userUseCase.getUsers();
      final userUpdated = await userUseCase.updateUser(User(
        id: datos[datos.length - 1].id!,
        name: "Jose",
        email: "Jose@juan.com",
        password: "123123",
      ));
      expect(userUpdated, isTrue);
    });

    test('Update user bad', () async {
      final userUpdated = await userUseCase.updateUser(User(
        id: 1100,
        name: "Jose",
        email: "Jose@juan.com",
        password: "1231234",
      ));
      expect(userUpdated, isFalse);
    });

    test('Delete users', () async {
      final datos = await userUseCase.getUsers();
      final userDeleted = await userUseCase.deleteUser(datos[datos.length - 1].id!);
      expect(userDeleted, isTrue);
    });

    test('Delete user bad', () async {
      final userDeleted = await userUseCase.deleteUser(1100);
      expect(userDeleted, isFalse);
    });
  });

  group('Clients support', () {
    test('Get all clients', () async {
      // Get initial list of clients
      final userList = await userUseCase.getClients();

      // Add a new client
      await userUseCase.addClient(Client(
        name: "Juan",
      ));

      // Get updated list of clients
      final userList2 = await userUseCase.getClients();

      // Check that the new client has been added
      expect(userList.length + 1, userList2.length);

      // Delete the newly added client
      final newClientId = userList2[userList2.length - 1].id!;
      await userUseCase.deleteClient(newClientId);

      // Verify the client has been deleted
      final userList3 = await userUseCase.getClients();
      expect(userList.length, userList3.length);
    });

    test('Add clients', () async {
      final userAdded = await userUseCase.addClient(Client(
        name: "Juan",
      ));
      expect(userAdded, isTrue);
    });

    test('Update clients', () async {
      final datos = await userUseCase.getClients();

      final userUpdated = await userUseCase.updateClient(Client(
        id: datos[datos.length - 1].id!,
        name: "Jose",
      ));
      expect(userUpdated, isTrue);
    });

    test('Update clients bad', () async {
      final userUpdated = await userUseCase.updateClient(Client(
        id: 1100,
        name: "Jose",
      ));
      expect(userUpdated, isFalse);
    });

    test('Delete clients', () async {
      final datos = await userUseCase.getClients();
      final userDeleted = await userUseCase.deleteClient(datos[0].id!);
      expect(userDeleted, isTrue);
    });

    test('Delete clients bad', () async {
      final userDeleted = await userUseCase.deleteClient(1100);
      expect(userDeleted, isFalse);
    });
  });
}
