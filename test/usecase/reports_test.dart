import 'package:controlarpersonal_remoto/domain/models/client.dart';
import 'package:controlarpersonal_remoto/domain/models/report.dart';
import 'package:controlarpersonal_remoto/domain/use_case/reports_usecase.dart';
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
  IReports reports = Get.put(IReports(repository));

  group('Reports', () {
    test('Get all Reports', () async {
      final userList = await reports.obtenerReportesi();
      await reports.agregarReportesi(Report(
        usid: 1,
        correoSoporte: 'campeon@a.com',
        clienteID: 10,
        descripcion: 'Prueba',
        duracion: 45,
        evaluacion: '0',
        horaInicio: DateTime.parse("2024-06-03 22:52:02.565"),
      ),0);
    
      final userList2 = await reports.obtenerReportesi();
      expect(userList.length + 1, userList2.length);
      await reports.eliminarReportesi(userList2[userList2.length - 1].id!);
    });

    // test('Add users', () async {
    //   final userAdded = await reports.addUser(User(
    //     name: "Juan",
    //     email: "Juan@Juan.com",
    //     password: "123456789101112",
    //   ));
    //   expect(userAdded, isTrue);
    // });

    // test('Update users', () async {
    //   final datos = await reports.getUsers();
    //   final userUpdated = await reports.updateUser(User(
    //     id: datos[datos.length - 1].id!,
    //     name: "Jose",
    //     email: "Jose@juan.com",
    //     password: "123123",
    //   ));
    //   expect(userUpdated, isTrue);
    // });

    // test('Update user bad', () async {
    //   final userUpdated = await reports.updateUser(User(
    //     id: 1100,
    //     name: "Jose",
    //     email: "Jose@juan.com",
    //     password: "1231234",
    //   ));
    //   expect(userUpdated, isFalse);
    // });

    // test('Delete users', () async {
    //   final datos = await reports.getUsers();
    //   final userDeleted = await reports.deleteUser(datos[datos.length - 1].id!);
    //   expect(userDeleted, isTrue);
    // });

    // test('Delete user bad', () async {
    //   final userDeleted = await reports.deleteUser(1100);
    //   expect(userDeleted, isFalse);
    // });
  });
}
