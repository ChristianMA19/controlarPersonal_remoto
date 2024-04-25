import 'dart:math';

import 'package:controlarpersonal_remoto/domain/models/user.dart';
import 'package:controlarpersonal_remoto/ui/controller/user_controller.dart';
import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/suppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class adminSup extends StatefulWidget {
  const adminSup({super.key});

  @override
  State<adminSup> createState() => _UserListPageState();
}

class _UserListPageState extends State<adminSup> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Support Administrator"),
          actions: [],
        ),
        // ignore: unnecessary_null_comparison
        floatingActionButton: Icons.add == null
            ? null
            : FloatingActionButton(
                key: const Key('ButtonHomeAdd'),
                onPressed: () {
                  Get.to(() => const SignUpPage(
                        key: Key('SignUpPage'),
                      ));
                },
                child: const Icon(Icons.add),
              ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Active supporters", style: TextStyle(fontSize: 24)),
              const SizedBox(
                  height: 20), // Espacio entre el texto y el ListView
              Expanded(
                child: _getXlistView(),
              ),
            ],
          ),
        ));
  }

Widget _getXlistView() {
  return Obx(() => ListView.builder(
    itemCount: userController.users.length,
    itemBuilder: (context, index) {
      User user = userController.users[index];

      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Deleting",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onDismissed: (direction) {
          userController.deleteUser(user.id!);
        },
        child: Card(
          child: ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () {
              Get.to(() => const EditarDatosPage(),
                arguments: [user, user.id]);
            },
          ),
        ),
      );
    },
  ));
}


  
}
