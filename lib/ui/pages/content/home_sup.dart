import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../authentication/login.dart';
import '../../controller/Report_controller.dart';
import '../../../domain/models/report.dart';

class HomePageSup extends StatefulWidget {
  const HomePageSup({
    Key? key,
    required this.loggedname,
    required this.loggedEmail,
    required this.loggedPassword,
  }) : super(key: key);
  final String loggedname;
  final String loggedEmail;
  final String loggedPassword;

  @override
  State<HomePageSup> createState() => _HomePageSupState();
}

class _HomePageSupState extends State<HomePageSup> {
  ReportController reportController = Get.find();
  bool showAllReports = false; // Estado para mostrar todos los reportes

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(
          loggedEmail: widget.loggedEmail,
          onReportSubmitted: (Report report) async {
            Loggy('Reporte enviado: $report');
            int status = await reportController.checkConnectivity() ? 0 : 1;
            Loggy('Status: $status');
            await reportController.agregarReportesi(
                report, status); // Ajustar el status según sea necesario
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            key: const Key('ButtonHomeLogOff'),
            onPressed: () {
              Get.off(
                () => LoginScreen(
                  key: const Key('LoginScreen'),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            key: const Key('ButtonReport'),
            onPressed: () {
              _showReportDialog(context);
            },
            child: const Text('Enviar Reporte de Trabajo'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Reportes enviados:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Borde gris
                borderRadius: BorderRadius.circular(10),
              ),
              child: _getXlistView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getXlistView() {
    // Filtrar los reportes por correoSoporte igual a loggedEmail
    List<Report> filteredReports = reportController.finReports
        .where((report) => report.correoSoporte == widget.loggedEmail)
        .toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: filteredReports.length,
        itemBuilder: (context, index) {
          Report report = filteredReports[index];
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('form ID: ${report.id}'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Client: ${report.clienteID}'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Date: ${report.horaInicio}'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Evaluation: ${report.evaluacion}'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showEvaluationDialog(context, report);
                  },
                  child: const Text('See'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEvaluationDialog(BuildContext context, Report report) {
    double _rating = report.evaluacion != null
        ? double.tryParse(report.evaluacion!) ?? 0
        : 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Evaluate Form ID: ${report.id}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${report.id}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Description: ${report.descripcion}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Client: ${report.clienteID}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Start Time: ${report.horaInicio}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Duration: ${report.duracion}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            )
          ],
        );
      },
    );
  }
}

class ReportDialog extends StatefulWidget {
  final Function(Report) onReportSubmitted;
  final String loggedEmail;

  ReportDialog({required this.onReportSubmitted, required this.loggedEmail});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final _formKey = GlobalKey<FormState>();
  final _usidController = TextEditingController();
  final _clienteIDController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _duracionController = TextEditingController();
  final _evaluacionController = TextEditingController();
  DateTime _horaInicio = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enviar Reporte de Trabajo'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Correo Soporte: ${widget.loggedEmail}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: _clienteIDController,
                decoration: InputDecoration(labelText: 'Cliente ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del cliente';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _duracionController,
                decoration: InputDecoration(labelText: 'Duración (minutos)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la duración';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _horaInicio,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _horaInicio = selectedDate;
                      });
                    }
                  },
                  child: Text('Seleccionar Fecha de Inicio'),
                ),
              ),
              Text('Fecha seleccionada: ${_horaInicio.toLocal()}'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newReport = Report(
                usid: int.parse(_usidController.text),
                correoSoporte: widget.loggedEmail,
                clienteID: int.parse(_clienteIDController.text),
                descripcion: _descripcionController.text,
                duracion: int.parse(_duracionController.text),
                evaluacion: "0",
                horaInicio: _horaInicio,
              );
              widget.onReportSubmitted(newReport);
              Navigator.of(context).pop();
            }
          },
          child: Text('Enviar'),
        ),
      ],
    );
  }
}
