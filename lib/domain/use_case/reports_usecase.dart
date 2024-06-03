import 'package:get/get.dart';

import '../repositories/report_repository.dart';
import '../models/report.dart';

class IReports {
  final ReportRepository iRepository = Get.find();
  IReports(find);

  Future<void> agregarReportesi(reportss, statuss) async =>
      await iRepository.agregarReportesi(reportss, statuss);

  Future<List<Report>> obtenerReportesi() async =>
      await iRepository.obtenerReportesi();

  Future<void> eliminarReportesi(ids) async =>
      await iRepository.eliminarReportesi(ids);

  Future<void> evaluarReportesi(reportss) async => await iRepository.evaluarReportesi(reportss);
}
