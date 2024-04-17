import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
import 'package:controlarpersonal_remoto/ui/pages/controller/formpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/login.dart';

class adminSup extends StatelessWidget {
  const adminSup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Support Administrator"),
          actions: [],
        ),
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Define el color del borde
        borderRadius: BorderRadius.circular(10), // Define la forma del borde
      ),
      child: ListView.builder(
        itemCount: 20, // Número de elementos en la lista
        itemBuilder: (context, index) {
          // Aquí deberías obtener los datos reales para cada índice
          // Por ahora, simplemente usaremos datos ficticios
          String id = "ID_$index";
          String nombre = "Nombre_$index";
          String correo = "correo_$index@example.com";

          return ListTile(
            title: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 80.0),
                  child: Text('ID: $id'),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 80.0),
                  child: Text('Nombre: $nombre'),
                ),
                Text('Correo: $correo'),
              ],
            ),
            onTap: () {
              Get.to(() => EditarDatosPage(
                    key: const Key('EditarDatosPage'),
                    id: 'ID: $index',
                    nombre: 'Nombre: $index',
                    correo: 'Correo: $index',
                    contrasena: 'Contraseña: $index',
                  ));
            },
          );
        },
      ),
    );
  }
}
