import 'package:controlarpersonal_remoto/domain/models/report.dart';

abstract class FuncReportDatasource {
  Future<void> agregarReportesi(Report report, int status);
  Future<List<Report>> obtenerReportesi();
  Future<void> eliminarReportesi(String id);
  Future<void> evaluarReportesi(Report report);
  Future<void> guardarRegistrosi(Report report);
  Future<void> cargarAPIi(Report report);
  Future<void> cargarRegistrosi();
}
