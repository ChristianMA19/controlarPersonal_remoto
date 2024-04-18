import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarDatosPage extends StatelessWidget {
  final String id;
  final String nombre;
  final String correo;
  final String contrasena;

  EditarDatosPage({required this.id, required this.nombre, required this.correo, required this.contrasena, required Key key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Edit Data support $nombre'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right:200 , left: 200, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Edit Data Support' , style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: id),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: nombre),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: correo),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: contrasena),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              Get.back();
            }, child: const Text('Save changes')),
          ],
        ),
      ),
    );
  }
}
