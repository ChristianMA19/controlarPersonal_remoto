import 'package:controlarpersonal_remoto/domain/models/report.dart';
import 'package:controlarpersonal_remoto/ui/controller/Report_controller.dart';
import 'package:controlarpersonal_remoto/ui/pages/authentication/signup.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/admin_client.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/admin_sup.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/listus_form.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:loggy/loggy.dart';
import '../authentication/login.dart';

class HomePageCord extends StatefulWidget {
  const HomePageCord({
    Key? key,
    required this.loggedEmail,
    required this.loggedPassword,
  }) : super(key: key);

  final String loggedEmail;
  final String loggedPassword;

  @override
  _HomePageCordState createState() => _HomePageCordState();
}

class _HomePageCordState extends State<HomePageCord> {
  String _selectedFilter = ''; // Initialize with empty string
  ReportController reportController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Home"),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Get.to(() => const listusform(key: Key('listusform')));
                },
                child: const Text("US List"),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Get.to(() => const adminSup(key: Key('adminSup')));
                },
                child: const Text("Admin Supports"),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Get.to(() => const adminClient(key: Key('adminClient')));
                },
                child: const Text("Admin Clients"),
              ),
              IconButton(
                key: const Key('ButtonHomeLogOff'),
                onPressed: () {
                  Get.off(() => const LoginScreen(
                        key: Key('LoginScreen'),
                      ));
                },
                icon: const Icon(Icons.logout),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('ButtonHomeAdd'),
        onPressed: () {
          Get.to(() => const SignUpPage(
                key: Key('SignUpPage'),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 200, right: 200, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Forms sent by support",
              style: TextStyle(fontSize: 24),
            ),
            Row(
              children: [
                const Text("Filter: "),
                DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: '',
                      child: const Text('All'),
                    ),
                    ...reportController.finReports
                        .map((report) => report.clienteID)
                        .toSet()
                        .map((clientID) {
                      return DropdownMenuItem(
                        value: 'cli_$clientID',
                        child: Text('cli_$clientID'),
                      );
                    }),
                    ...reportController.finReports
                        .map((report) => report.clienteID)
                        .toSet()
                        .map((clientID) {
                      return DropdownMenuItem(
                        value: 'sup_$clientID',
                        child: Text('sup_$clientID'),
                      );
                    }),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _getXlistView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getXlistView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: reportController.finReports.length,
        itemBuilder: (context, index) {
          Report report = reportController.finReports[index];
          final String id = _selectedFilter.isNotEmpty ? _selectedFilter : '';
          final bool shouldShow = id.isEmpty ||
              id == 'cli_${report.clienteID}' ||
              id == 'sup_${report.clienteID}';
          if (!shouldShow) {
            return SizedBox.shrink();
          }
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('form ID: ${report.id}'),
                      const SizedBox(width: 20),
                      Text('Client: ${report.clienteID}'),
                      const SizedBox(width: 20),
                      Text('Support: ${report.clienteID}'),
                      const SizedBox(width: 20),
                      Text('Date: ${report.horaInicio}'),
                      const SizedBox(width: 20),
                      Text('Evaluation: ${report.evaluacion}'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showEvaluationDialog(context, report);
                  },
                  child: const Text('Evaluate'),
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
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  report.evaluacion = _rating.toString();
                });
                logInfo(
                    "ReportController -> ActualizarUsuario -> ${report.id}");
                await reportController.evaluarReportesi(report);
                Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
