//import 'package:controlarpersonal_remoto/ui/pages/controller/clientpage.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';


class listusform extends StatelessWidget {
  const listusform(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("List of US with number of reports and average grade"),
        
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
        String reports = "Reports_$index";
        String average = "Average_$index";

        return Column(
          children: [
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$index)'),
                  const SizedBox(width: 20.0),
                  Text('ID: $id'),
                  const SizedBox(width: 20.0),
                  Text('Nombre: $nombre'),
                  const SizedBox(width: 20.0),
                  Text('Number of reports: $reports'),
                  const SizedBox(width: 20.0),
                  Text('average grade: $average'),
                ],
              ),
            ),
            const Divider( // Agrega una línea entre cada elemento de la lista
              color: Colors.grey,
              height: 1, // Altura de la línea
              thickness: 1, // Grosor de la línea
            ),
          ],
        );
      },
    ),
  );
}



}
