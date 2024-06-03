import 'package:loggy/loggy.dart';
import '../../domain/models/report.dart';
import '../../domain/repositories/ireport_repository.dart';
import '../../data/datasources/remote/report_datasource.dart';

class ReportRepository implements IReportRepository {
  late ReportDatasource iReportDatasource;

  ReportRepository() {
    logInfo("Starting ReportRepository");
    iReportDatasource = ReportDatasource();
  }

  @override
  Future<bool> agregarReportesi(Report report, int status) async {
    try{
      await iReportDatasource.agregarReportesi(report, status);
      return true;
    } catch (error) {
      logError('Error al agregar el reporte al repositorio: $error');
      return false;
    }
  }

  @override
  Future<void> eliminarReportesi(String id) async {
    try {
      await iReportDatasource.eliminarReportesi(id);
    } catch (error) {
      logError('Error al eliminar el reporte en el repositorio: $error');
    }
  }

  @override
  Future<void> evaluarReportesi(Report report) async {
    try{
      await iReportDatasource.evaluarReportesi(report);
    } catch (error) {
      logError('Error al actualizar el reporte en el repositorio: $error');
    }
  }

  @override
  Future<List<Report>> obtenerReportesi() async {
    try {
      return await iReportDatasource.obtenerReportesi();
    } catch (error) {
      logError('Error al obtener los reportes en el repositorio: $error');
      return [];
    }
  }
}
