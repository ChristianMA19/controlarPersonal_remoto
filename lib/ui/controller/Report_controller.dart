import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/models/report.dart';
import '../../domain/use_case/reports_usecase.dart';

class ReportController extends GetxController {
  final RxList<Report> obtReports = <Report>[].obs;
  final IReports reportUseCase;
  ReportController({required this.reportUseCase});

  List<Report> get finReports => obtReports;

  @override
  onInit() {
    super.onInit();
    obtenerReportesi();
  }

  Future<void> agregarReportesi(report, status) async {
    logInfo("ReportController -> Agregar Reporte");
    await reportUseCase.agregarReportesi(report, status);
    await obtenerReportesi();
  }

  Future<void> obtenerReportesi() async {
    var list = await reportUseCase.obtenerReportesi();
    obtReports.value = list;
    obtReports.refresh();
  }

  Future<void> eliminarReportesi(id) async {
    logInfo("ReportController -> Eliminar Reporte $id");
    await reportUseCase.eliminarReportesi(id);
    await obtenerReportesi();
  }

  Future<void> evaluarReportesi(report) async {
    logInfo("ReportController -> ActualizarUsuario -> ${report.id}");
    await reportUseCase.evaluarReportesi(report);
    await obtenerReportesi();
  }
}
