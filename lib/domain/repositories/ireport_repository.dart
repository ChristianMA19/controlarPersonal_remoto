import '../models/report.dart';

abstract class IReportRepository {
  Future<bool> agregarReportesi(Report report, int status);
  Future<List<Report>> obtenerReportesi();
  Future<void> eliminarReportesi(String id);
  Future<void> evaluarReportesi(Report report);
}
