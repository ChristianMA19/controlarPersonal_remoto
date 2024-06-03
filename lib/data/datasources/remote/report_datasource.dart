import 'dart:async';
import 'package:controlarpersonal_remoto/data/datasources/local/localReport_datasource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/report.dart';
import '../remote/func_report_datasource.dart';

class ReportDatasource implements FuncReportDatasource {
  final String baseURL = 'https://retoolapi.dev/G7bm5J/data';

  @override
  Future<void> agregarReportesi(Report report, int status) async {
    try {
      if (status == 0) {
        await guardarRegistrosi(report);
        print('status 0');
      } else if (status == 1) {
        await cargarAPIi(report);
        print('status 1');
      } else {
        await cargarRegistrosi();
        print('status 2');
      }
    } catch (error) {
      print('Error al añadir un reporte: $error');
      throw Exception('Error al añadir un reporte: $error');
    }
  }

  @override
  Future<List<Report>> obtenerReportesi() async {
    try {
      final response = await http.get(Uri.parse('$baseURL'));

      logInfo('GET Reports Response Status Code: ${response.statusCode}');
      logInfo('GET Reports Response Body: ${response.body}');

      if (response.statusCode == 200) {
        logInfo("Retornando obtenerReportes de la data local");
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Report> reportList =
            jsonResponse.map((data) => Report.fromJson(data)).toList();
        logInfo('GET Reports Decoded Report List: $reportList');
        return reportList;
      } else {
        throw Exception(
            'Fallo al cargar los reportes. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Error al obtener todos los reportes: $error');
      throw Exception('Error al obtener todos los reportes: $error');
    }
  }

  @override
  Future<void> eliminarReportesi(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseURL/$id'));

      if (response.statusCode != 200) {
        throw Exception(
            'Fallo al eliminar el reporte. Status code: ${response.statusCode}');
      }
    } catch (error) {
      logError('Error al eliminar el reporte: $error');
      throw Exception('Error al eliminar el reporte: $error');
    }
  }

  @override
  Future<void> evaluarReportesi(Report report) async {
    try {
      final response = await http.put(
        Uri.parse('$baseURL/${report.id}'),
        body: jsonEncode(report.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Fallo al actualizar el reporte. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      logError('Fallo al actualizar el reporte: $error');
      throw Exception('Fallo al actualizar el reporte: $error');
    }
  }

  @override
  Future<void> cargarAPIi(Report report) async {
    try {
      final response = await http.post(
        Uri.parse(baseURL),
        body: jsonEncode(report.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logInfo("Agregando reporte a la data Local");
      } else {
        throw Exception(
            'Fallo al agregar el reporte. status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      print('Error al subir el reporte: $error');
      throw Exception('Error al subir el reporte: $error');
    }
  }

  @override
  Future<void> guardarRegistrosi(Report report) async {
    try {
      final dbHelper = IDataBase();
      await dbHelper.ingresarReporte(
          report); // Insertar el informe en la base de datos SQLite
    } catch (e) {
      // Manejar errores, si es necesario
      print('Error saving Report in db: $e');
    }
  }

  @override
  Future<void> cargarRegistrosi() async {
    try {
      final dbHelper = IDataBase();
      List<Report> pendingReports = await dbHelper.obtenerReportes();
      if (pendingReports.isNotEmpty) {
        for (var report in pendingReports) {
          await cargarAPIi(report);
          await dbHelper.eliminarReportes(report.id!);
        }
      }
    } catch (e) {
      // Manejar errores, si es necesario
      print('Error al cargar reporte: $e');
    }
  }
}
