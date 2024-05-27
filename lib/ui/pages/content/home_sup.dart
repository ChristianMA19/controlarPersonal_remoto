import 'package:controlarpersonal_remoto/ui/pages/content/Report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/mock/http_request_mock.dart';
import '../authentication/login.dart';
import '../../../domain/models/report.dart';
import '../../../domain/repositories/report_repository.dart';

class HomePageSup extends StatefulWidget {
  const HomePageSup({
    Key? key,
    required this.loggedname,
    required this.loggedEmail,
    required this.loggedPassword, 
    //required MockClient client,
  }) : super(key: key);
  final String loggedname;
  final String loggedEmail;
  final String loggedPassword;

  @override
  _HomePageSupState createState() => _HomePageSupState();
}

class _HomePageSupState extends State<HomePageSup> {
  final ReportRepository reportRepository = ReportRepository();
  List<Report> reports = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final fetchedReports = await reportRepository.fetchReports();
      setState(() {
        reports = fetchedReports;
      });
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 15,
                    columns: const [
                      DataColumn(
                        label: Flexible(child: Text('Problema Solucionado')),
                      ),
                      DataColumn(
                        label: Flexible(child: Text('Cliente Atendido')),
                      ),
                      DataColumn(
                        label: Flexible(child: Text('Hora de Inicio')),
                      ),
                      DataColumn(
                        label: Flexible(child: Text('Tiempo de Duración')),
                      ),
                      DataColumn(
                        label: Flexible(child: Text('Evaluación')),
                      ),
                    ],
                    rows: reports.map((report) {
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
      ),
    );
  }
}
