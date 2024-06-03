import 'package:controlarpersonal_remoto/domain/models/client.dart';
import 'package:controlarpersonal_remoto/domain/models/user.dart';
import 'package:controlarpersonal_remoto/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Clientpageadmin extends StatefulWidget {
  const Clientpageadmin({super.key});

  @override
  State<Clientpageadmin> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<Clientpageadmin> {
  Client user = Get.arguments[0];
  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    controllerName.text = user.name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Edit Data Client ${user.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right:200 , left: 200, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Edit Data Client' , style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              await userController.updateClient(Client(
                id: user.id,
                name: controllerName.text
              ));
              Get.back();
            }, child: const Text('Save changes')),
          ],
        ),
      ),
    );
  }
}
