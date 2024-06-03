import 'package:flutter/material.dart';
import '../../../domain/models/report.dart';

class ReportDialog extends StatelessWidget {
  final Function(Report) onReportSubmitted;

  ReportDialog({required this.onReportSubmitted});

  @override
  Widget build(BuildContext context) {
    TextEditingController usidController = TextEditingController();
    TextEditingController correoSoporteController = TextEditingController();
    TextEditingController clienteIDController = TextEditingController();
    TextEditingController descripcionController = TextEditingController();
    TextEditingController duracionController = TextEditingController();
    TextEditingController horaInicioController = TextEditingController();

    return AlertDialog(
      title: const Text('Enviar Reporte de Trabajo'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usidController,
              decoration: const InputDecoration(labelText: 'US ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: correoSoporteController,
              decoration: const InputDecoration(labelText: 'Correo Soporte'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: clienteIDController,
              decoration: const InputDecoration(labelText: 'Cliente ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: duracionController,
              decoration:
                  const InputDecoration(labelText: 'Duración (minutos)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: horaInicioController,
              decoration: const InputDecoration(labelText: 'Hora de Inicio'),
              keyboardType: TextInputType.datetime,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            int usid = int.parse(usidController.text);
            String correoSoporte = correoSoporteController.text;
            int clienteID = int.parse(clienteIDController.text);
            String descripcion = descripcionController.text;
            int duracion = int.parse(duracionController.text);
            DateTime horaInicio = DateTime.parse(horaInicioController.text);

            Report newReport = Report(
              usid: usid,
              correoSoporte: correoSoporte,
              clienteID: clienteID,
              descripcion: descripcion,
              duracion: duracion,
              evaluacion: "", // No se agrega evaluación en este punto
              horaInicio: horaInicio,
            );

            onReportSubmitted(newReport);

            Navigator.of(context).pop();
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
