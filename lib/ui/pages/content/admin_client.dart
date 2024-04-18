import 'package:controlarpersonal_remoto/ui/pages/controller/clientpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class adminClient extends StatelessWidget {
  const adminClient(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Client Administrator"),
        
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Clients in database", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20), // Espacio entre el texto y el ListView
            Expanded(
              child: _getXlistView(),
            ),
          ],
        ),
      )

      
    );
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

          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: $id'),
                      const SizedBox(width: 20.0),
                      Text('Nombre: $nombre'),
                    ],
                ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => EditarDatosPageClient(
                      key: const Key('EditarDatosPageClient'),
                      id: '$index',
                      nombre: '$index',
                    ));
                  },
                  child: Text('Editar'),
                ),
              ],
            ),
            onTap: () {
              Get.to(() => EditarDatosPageClient(
                      key: const Key('EditarDatosPageClient'),
                      id: '$index',
                      nombre: '$index',
                    ));
              // Acción al hacer clic en un elemento
            },
          );
        },
      ),
    );
  }


}
