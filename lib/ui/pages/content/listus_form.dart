//import 'package:controlarpersonal_remoto/ui/pages/controller/clientpage.dart';
import 'package:controlarpersonal_remoto/domain/models/report.dart';
import 'package:controlarpersonal_remoto/ui/controller/Report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class listusform extends StatelessWidget {
  const listusform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("List of US with number of reports and average grade"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildSupportReportsList(),
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildSupportReportsList() {
    ReportController reportController = Get.find();

    // Agrupar los reportes por correo del soporte
    Map<String, List<Report>> reportsBySupport = {};

    reportController.finReports.forEach((report) {
      if (reportsBySupport.containsKey(report.correoSoporte)) {
        reportsBySupport[report.correoSoporte]!.add(report);
      } else {
        reportsBySupport[report.correoSoporte] = [report];
      }
    });

    // Calcular la cantidad de reportes y el promedio de evaluación por soporte
    List<Widget> supportReportsWidgets = [];
    reportsBySupport.forEach((supportEmail, reports) {
      int totalReports = reports.length;
      double averageGrade = reports.isNotEmpty
          ? reports.map((report) => int.parse(report.evaluacion)).reduce((a, b) => a + b) / totalReports
          : 0;

      supportReportsWidgets.add(
        ListTile(
          title: Text("Support Email: $supportEmail"),
          subtitle: Text("Total Reports: $totalReports | Average Grade: ${averageGrade.toStringAsFixed(2)}"),
        ),
      );
    });

    // Retornar la lista de widgets
    return ListView(
      children: supportReportsWidgets,
    );
  }
}
