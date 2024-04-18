import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarDatosPageForm extends StatelessWidget {
  final String id;
  final String descripcion;
  final String cliente;
  final String hora;
  final String duracion;
  final String support;

  EditarDatosPageForm({
    required this.id,
    required this.descripcion,
    required this.cliente,
    required this.hora,
    required this.duracion,
    required this.support,
    required Key key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Form $id'),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Form Evaluation ',
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        Text('ID: $id', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Descripcion: $descripcion',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Cliente: $cliente', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Hora: $hora', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Duracion: $duracion',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          width: 200,
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Evaluation',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Save Grade'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
