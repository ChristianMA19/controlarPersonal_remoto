import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final ReportController reportController = Get.find();
  bool showAllReports = false; // Estado para mostrar todos los reportes

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(
          onReportSubmitted: (Report report) async {
            await reportController.agregarReportesi(
                report, 'status'); // Ajustar el status según sea necesario
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    DataTable(
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                          label: Text('Cliente ID'),
                        ),
                        DataColumn(
                          label: Text('Descripción'),
                        ),
                        DataColumn(
                          label: Text('Duración'),
                        ),
                        DataColumn(
                          label: Text('Evaluación'),
                        ),
                        DataColumn(
                          label: Text('Hora de Inicio'),
                        ),
                      ],
                      rows: showAllReports
                          ? reportController.obtReports
                              .map((report) {
                                return DataRow(cells: [
                                  DataCell(Text(report.clienteID.toString())),
                                  DataCell(Text(report.descripcion)),
                                  DataCell(Text(report.duracion.toString())),
                                  DataCell(Text(report.evaluacion.toString())),
                                  DataCell(Text(report.horaInicio.toString())),
                                ]);
                              })
                              .toList()
                          : reportController.obtReports
                              .take(5) // Mostrar solo los primeros 5 reportes
                              .map((report) {
                                return DataRow(cells: [
                                  DataCell(Text(report.clienteID.toString())),
                                  DataCell(Text(report.descripcion)),
                                  DataCell(Text(report.duracion.toString())),
                                  DataCell(Text(report.evaluacion.toString())),
                                  DataCell(Text(report.horaInicio.toString())),
                                ]);
                              })
                              .toList(),
                    ),
                    if (reportController.obtReports.length > 5)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showAllReports = !showAllReports;
                          });
                        },
                        child: Text(showAllReports ? 'Mostrar menos' : 'Mostrar más'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDialog extends StatefulWidget {
  final Function(Report) onReportSubmitted;

  ReportDialog({required this.onReportSubmitted});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final _formKey = GlobalKey<FormState>();
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
              TextFormField(
                controller: _evaluacionController,
                decoration: InputDecoration(labelText: 'Evaluación'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la evaluación';
                  }
                  return null;
                },
              ),
              ElevatedButton(
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
                clienteID: _clienteIDController.text,
                descripcion: _descripcionController.text,
                duracion: int.parse(_duracionController.text),
                evaluacion: _evaluacionController.text,
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
