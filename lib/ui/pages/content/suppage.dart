import 'package:controlarpersonal_remoto/domain/models/user.dart';
import 'package:controlarpersonal_remoto/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarDatosPage extends StatefulWidget {
  const EditarDatosPage({super.key});

  @override
  State<EditarDatosPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditarDatosPage> {
  User user = Get.arguments[0];
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    controllerName.text = user.name;
    controllerEmail.text = user.email;
    controllerPassword.text = user.password;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Edit Data support ${user.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right:200 , left: 200, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Edit Data Support' , style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
              controller: controllerEmail,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              controller: controllerPassword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              await userController.updateUser(User(
                id: user.id,
                name: controllerName.text,
                email: controllerEmail.text,
                password: controllerPassword.text,
              ));
              Get.back();
            }, child: const Text('Save changes')),
          ],
        ),
      ),
    );
  }
}
