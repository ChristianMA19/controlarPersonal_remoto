import '../../../domain/models/report.dart';

abstract class FuncLocalReportDatasource {
  Future<int> ingresarReporte(Report report);
  Future<int> actualizarReportes(Report report);
  Future<int> eliminarReportes(int id);
  Future<List<Report>> obtenerReportes();

}