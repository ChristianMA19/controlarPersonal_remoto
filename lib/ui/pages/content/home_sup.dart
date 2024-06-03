import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int queue = 0;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnection as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>;
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    } on PlatformException catch (e) {
      print('No se pudo verificar el estado de la conectividad: $e');
      return;
    }
    if (!mounted) {
      return;
    }
    return _updateConnection(result);
  }

  Future<void> _updateConnection(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });

    if (_connectionStatus != ConnectivityResult.none) {
      Report a = Report(
        clienteID: 1,
        descripcion: 'Test',
        duracion: 'Test',
        evaluacion: 0,
        horaInicio: DateTime.now(),
      );
      await reportController.agregarReportesi(a, 2);
      await reportController.obtenerReportesi();
      if (queue > 0) {
        Get.offAll(() => HomePageSup(
              loggedname: widget.loggedname,
              loggedEmail: widget.loggedEmail,
              loggedPassword: widget.loggedPassword,
            ));
        queue = 0;
      }
    }
  }

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
      body: SingleChildScrollView(
        child: Center(
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                          label: Flexible(child: Text('Cliente ID')),
                        ),
                        DataColumn(
                          label: Flexible(child: Text('Descripción')),
                        ),
                        DataColumn(
                          label: Flexible(child: Text('Duración')),
                        ),
                        DataColumn(
                          label: Flexible(child: Text('Evaluación')),
                        ),
                        DataColumn(
                          label: Flexible(child: Text('Hora de Inicio')),
                        ),
                      ],
                      rows: reportController.obtReports.map((report) {
                        return DataRow(cells: [
                          DataCell(Text(report.clienteID.toString())),
                          DataCell(Text(report.descripcion)),
                          DataCell(Text(report.duracion.toString())),
                          DataCell(Text(report.evaluacion.toString())),
                          DataCell(Text(report.horaInicio.toString())),
                        ]);
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          ),
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
            if (_formKey.currentState!.validate()) {
              final newReport = Report(
                clienteID: int.parse(_clienteIDController.text),
                descripcion: _descripcionController.text,
                duracion: _duracionController.text,
                evaluacion: int.parse(_evaluacionController.text),
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
