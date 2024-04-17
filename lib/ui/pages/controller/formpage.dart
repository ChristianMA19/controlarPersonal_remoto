import 'package:flutter/material.dart';

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
        title: Text('Editar Datos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ID: $id'),
            Text('Nombre: $nombre'),
            Text('Correo: $correo'),
            Text('Contraseña: $contrasena'),
            // Aquí puedes agregar campos de edición para modificar los datos
          ],
        ),
      ),
    );
  }
}
