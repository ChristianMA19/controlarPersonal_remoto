import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:controlarpersonal_remoto/domain/models/report.dart';
import 'package:controlarpersonal_remoto/domain/repositories/report_repository.dart';
import 'package:controlarpersonal_remoto/domain/use_case/reports_usecase.dart';

class TestReportRepository extends ReportRepository {
  final List<Report> _reports = [];

  @override
  Future<bool> agregarReportesi(Report reports, int status) async {
    _reports.add(reports);
    return true;
  }

  @override
  Future<List<Report>> obtenerReportesi() async {
    return _reports;
  }

  @override
  Future<void> eliminarReportesi(String id) async {
    _reports.removeWhere((report) => report.id == id);
  }

  @override
  Future<void> evaluarReportesi(Report report) async {
    final index = _reports.indexWhere((r) => r.id == report.id);
    if (index != -1) {
      _reports[index] = report;
    }
  }
}

void main() {
  // Inicializa el ReportRepository de prueba
  final testReportRepository = TestReportRepository();
  Get.put<ReportRepository>(testReportRepository);
  final IReports reportUseCase = IReports(testReportRepository);

  group('Reports use case tests', () {
    test('Agregar reportes', () async {
      // Crea un reporte de ejemplo
      final Report report = Report(
        usid: 1,
        correoSoporte: 'test@test.com',
        clienteID: 1,
        descripcion: 'Test description',
        duracion: 60,
        evaluacion: '5',
        horaInicio: DateTime.now(),
      );

      // Llama al método use case
      await reportUseCase.agregarReportesi(report, 0);

      // Verifica que el reporte fue agregado
      final reports = await reportUseCase.obtenerReportesi();
      expect(reports.length, 1);
      expect(reports[0].usid, report.usid);
    });

    test('Obtener reportes', () async {
      // Verifica que inicialmente no hay reportes
      final initialReports = await reportUseCase.obtenerReportesi();
      expect(initialReports.length, 0);

      // Agrega un reporte
      final Report report = Report(
        usid: 2,
        correoSoporte: 'test2@test.com',
        clienteID: 2,
        descripcion: 'Another test description',
        duracion: 30,
        evaluacion: '4',
        horaInicio: DateTime.now(),
      );
      await reportUseCase.agregarReportesi(report, 0);

      // Verifica que el reporte fue agregado
      final reports = await reportUseCase.obtenerReportesi();
      expect(reports.length, 1);
      expect(reports[0].usid, report.usid);
    });

    test('Eliminar reportes', () async {
      // Agrega un reporte
      final Report report = Report(
        usid: 3,
        correoSoporte: 'test3@test.com',
        clienteID: 3,
        descripcion: 'Yet another test description',
        duracion: 45,
        evaluacion: '3',
        horaInicio: DateTime.now(),
      );
      await reportUseCase.agregarReportesi(report, 0);

      // Verifica que el reporte fue agregado
      var reports = await reportUseCase.obtenerReportesi();
      expect(reports.length, 1);

      // Elimina el reporte
      await reportUseCase.eliminarReportesi(report.id!);

      // Verifica que el reporte fue eliminado
      reports = await reportUseCase.obtenerReportesi();
      expect(reports.length, 0);
    });

    test('Evaluar reportes', () async {
      // Agrega un reporte
      final Report report = Report(
        usid: 4,
        correoSoporte: 'test4@test.com',
        clienteID: 4,
        descripcion: 'Another description to test',
        duracion: 50,
        evaluacion: '3',
        horaInicio: DateTime.now(),
      );
      await reportUseCase.agregarReportesi(report, 0);

      // Actualiza la evaluación del reporte
      final updatedReport = Report(
        id: report.id,
        usid: report.usid,
        correoSoporte: report.correoSoporte,
        clienteID: report.clienteID,
        descripcion: report.descripcion,
        duracion: report.duracion,
        evaluacion: '5',
        horaInicio: report.horaInicio,
      );
      await reportUseCase.evaluarReportesi(updatedReport);

      // Verifica que la evaluación fue actualizada
      final reports = await reportUseCase.obtenerReportesi();
      expect(reports.length, 1);
      expect(reports[0].evaluacion, '5');
    });
  });
}
