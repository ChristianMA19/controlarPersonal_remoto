import 'package:controlarpersonal_remoto/ui/pages/content/home_sup.dart';
import '../../../domain/models/report.dart';
import 'package:flutter/material.dart';

class ReportDialog extends StatelessWidget {
  final Function(Report) onReportSubmitted;

  ReportDialog({required this.onReportSubmitted});
  @override
  Widget build(BuildContext context) {
    TextEditingController problemaController = TextEditingController();
    TextEditingController clienteController = TextEditingController();
    TextEditingController horaInicioController = TextEditingController();
    TextEditingController duracionController = TextEditingController();
    TextEditingController evaluacionController = TextEditingController();

    return AlertDialog(
      title: const Text('Enviar Reporte de Trabajo'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: problemaController,
              decoration:
                  const InputDecoration(labelText: 'Problema Solucionado'),
            ),
            TextField(
              controller: clienteController,
              decoration: const InputDecoration(labelText: 'Cliente Atendido'),
            ),
            TextField(
              controller: horaInicioController,
              decoration: const InputDecoration(labelText: 'Hora de Inicio'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: duracionController,
              decoration:
                  const InputDecoration(labelText: 'Tiempo de Duración'),
              keyboardType: TextInputType.number,
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
            String problema = problemaController.text;
            String cliente = clienteController.text;
            int horaInicio = int.parse(horaInicioController.text);
            int duracion = int.parse(duracionController.text);
            int evaluacion = int.parse(evaluacionController.text);

            Report newReport = Report(
              problema: problema,
              cliente: cliente,
              horaInicio: horaInicio,
              duracion: duracion,
              evaluacion: evaluacion,
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
