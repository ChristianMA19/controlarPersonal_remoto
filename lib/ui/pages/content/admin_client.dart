import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
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
                Container(
                  margin: const EdgeInsets.only(right: 80.0),
                  child: Text('ID: $id'),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 80.0),
                  child: Text('Nombre: $nombre'),
                ),
              ],
            ),
            onTap: () {
              // Acción al hacer clic en un elemento
            },
          );
        },
      ),
    );
  }


}
