import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
import 'package:controlarpersonal_remoto/ui/pages/controller/suppage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: $id'),
                      const SizedBox(width: 20),
                      Text('Nombre: $nombre'),
                      const SizedBox(width: 20),
                      Text('Correo: $correo'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => EditarDatosPage(
                      key: const Key('EditarDatosPage'),
                      id: '$index',
                      nombre: '$index',
                      correo: '$index',
                      contrasena: '$index',
                    ));
                  },
                  child: Text('Editar'),
                ),
                TextButton(
                  onPressed: () {
                    // Agrega aquí la lógica para eliminar
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red, // Establece el color del texto en rojo
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.to(() => EditarDatosPage(
                    key: const Key('EditarDatosPage'),
                    id: '$index',
                    nombre: '$index',
                    correo: '$index',
                    contrasena: '$index',
                  ));
            },
          );
        },
      ),
    );
  }
}
