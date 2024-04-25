import 'dart:convert';
import 'package:controlarpersonal_remoto/ui/pages/content/Report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/login.dart';
import 'package:http/http.dart' as http;

class Report {
  final String problema;
  final String cliente;
  final int horaInicio;
  final int duracion;
  final int? evaluacion;

  Report({
    required this.problema,
    required this.cliente,
    required this.horaInicio,
    required this.duracion,
    this.evaluacion,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      problema: json['Problema'],
      cliente: json['Cliente'],
      horaInicio: json['Hora'],
      duracion: json['Duracion'],
      evaluacion: json['Evaluacion'],
    );
  }
}

class HomePageSup extends StatefulWidget {
  const HomePageSup({
    Key? key,
    required this.loggedEmail,
    required this.loggedPassword,
  }) : super(key: key);

  final String loggedEmail;
  final String loggedPassword;

  @override
  _HomePageSupState createState() => _HomePageSupState();
}

class _HomePageSupState extends State<HomePageSup> {
  List<Report> reports = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final response = await http.get(Uri.parse('https://retoolapi.dev/EpdEeL/data'));
      
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print(responseData);
        setState(() {
          reports = responseData.map((data) => Report.fromJson(data)).toList();
        });
      } else {
        throw Exception('Failed to fetch reports');
      }
    } catch (e) {
      print('Error fetching reports: $e');
    }
  }


  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportDialog(
          onReportSubmitted: (Report report) {
            setState(() {
              reports.add(report);
            });
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
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 15,
                  columns: const [
                    DataColumn(
                      label: Flexible(child: Text('Problema')),
                    ),
                    DataColumn(
                      label: Flexible(child: Text('Cliente')),
                    ),
                    DataColumn(
                      label: Flexible(child: Text('Hora')),
                    ),
                    DataColumn(
                      label: Flexible(child: Text('Duración')),
                    ),
                    DataColumn(
                      label: Flexible(child: Text('Evaluación')),
                    ),
                  ],
                  rows: reports.map((report) {
                    print(report.evaluacion);
                    return DataRow(cells: [
                      DataCell(Text(report.problema)),
                      DataCell(Text(report.cliente)),
                      DataCell(Text(report.horaInicio.toString())),
                      DataCell(Text(report.duracion.toString())),
                      DataCell(Text(report.evaluacion?.toString() ?? ''))
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
