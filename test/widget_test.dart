// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:controlarpersonal_remoto/domain/models/user.dart';
import 'package:controlarpersonal_remoto/domain/repositories/repository.dart';
import 'package:controlarpersonal_remoto/domain/use_case/authentication_usecase.dart';
import 'package:controlarpersonal_remoto/domain/use_case/user_usecase.dart';
import 'package:controlarpersonal_remoto/ui/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:controlarpersonal_remoto/ui/controller/user_controller.dart';


import 'package:controlarpersonal_remoto/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loggy/loggy.dart';

void main() {
  Get.put(Repository());
  Get.put(AuthenticationUseCase());
  Get.put(UserUseCase());
  Get.put(AuthenticationController());
  UserController userController = Get.put(UserController());;

  

  var esperado = [
  {
    "id": 2,
    "Name": "Christian",
    "Email": "a@c.com",
    "Password": "abcdef123"
  },
  {
    "id": 4,
    "Name": "sebaxe",
    "Email": "sebax@a.com",
    "Password": "48561f2d3sf"
  },
  {
    "id": 5,
    "Name": "pruebas",
    "Email": "preuba@sa.com",
    "Password": "16d45s32das"
  },
  {
    "id": 6,
    "Name": "locura",
    "Email": "loc@a.com",
    "Password": "dsdasdasd"
  },
  {
    "id": 7,
    "Name": "aaaa",
    "Email": "aaa@aaaa.com",
    "Password": "561sd85sdasd"
  },
  {
    "id": 8,
    "Name": "chris",
    "Email": "ccj@a.com",
    "Password": "6854128594516"
  },
  {
    "id": 9,
    "Name": "augusto salazar",
    "Email": "augus@a.com",
    "Password": "865489546"
  },
  {
    "id": 10,
    "Name": "Juan",
    "Email": "campeon@a.com",
    "Password": "123456789"
  }
];
  group('Users support', () {
    test('Get all users', () async {
      print('Fetching users');
      await userController.getUers();
      final users = userController.users.map((e) => e.toJson()).toList();
      expect(users, esperado);
});

    test('Add users', () async {
      final userAdded = await userController.addUser(User(
        name: "Juan",
        email: "Juan@Juan.com",
        password: "123456789101112",
      ));

      print('User added: $userAdded');
      print('Last user: ${userController.users.last}');
      
    });

    test('Update users', () => {
        // expect(1, 1);});
    });

    test('Delete users', () async {
        final userDel = await userController.deleteUser(11);
        print(userDel.toString());
        expect(userDel., matcher)
    });

  });
}
