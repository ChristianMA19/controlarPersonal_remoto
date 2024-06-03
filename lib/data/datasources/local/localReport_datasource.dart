import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../../domain/models/report.dart';
import 'localFuncReport_datasource.dart';

class IDataBase implements FuncLocalReportDatasource {
  static Database? idataBase;
  static final IDataBase instancedb = IDataBase.internali();

  IDataBase.internali();

  factory IDataBase() {
    return instancedb;
  }

  Future<Database> get database async {
    if (idataBase != null) return idataBase!;
    idataBase = await iniciardataBase();
    return idataBase!;
  }

  Future<Database> iniciardataBase() async {
    Directory directorioDocumentos = await getApplicationDocumentsDirectory();
    String path = join(directorioDocumentos.path, 'reports.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreatei,
    );
  }

  Future onCreatei(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reports (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        correoSoporte TEXT,
        clienteID TEXT,
        descripcion TEXT,
        duracion INTEGER,
        evaluacion TEXT,
        horaInicio DateTime,
      )
      ''');
  }

  @override
  Future<int> ingresarReporte(Report report) async {
    Database db = await database;
    return await db.insert('reports', report.toJson());
  }

  @override
  Future<List<Report>> obtenerReportes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('reports');
    return List.generate(maps.length, (i) {
      return Report.fromJson(maps[i]);
    });
  }

  @override
  Future<int> actualizarReportes(Report report) async {
    Database db = await database;
    return await db.update(
      'reports',
      report.toJson(),
      where: 'id = ?',
      whereArgs: [report.id],
    );
  }

@override
  Future<int> eliminarReportes(int id) async {
    Database db = await database;
    return await db.delete(
      'reports',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
