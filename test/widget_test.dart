// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

import 'package:controlarpersonal_remoto/ui/pages/content/home_cord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:controlarpersonal_remoto/domain/models/report.dart';
import 'package:controlarpersonal_remoto/domain/use_case/reports_usecase.dart';
import 'package:controlarpersonal_remoto/ui/controller/Report_controller.dart';
import 'package:controlarpersonal_remoto/ui/pages/content/home_sup.dart';

void main() {
  group('HomePageSup Widget Tests', () {
    late ReportController reportController;

    setUp(() {
      // Inicializar el ReportController antes de cada prueba
      reportController = ReportController(reportUseCase: Get.find<IReports>());
      Get.put<ReportController>(reportController);
    });

    testWidgets('Show report dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomePageSup(
            loggedname: 'Test User',
            loggedEmail: 'test@test.com',
            loggedPassword: 'password',
          ),
        ),
      );

      // Verificar que el botón de enviar reporte está presente
      expect(find.byKey(Key('ButtonReport')), findsOneWidget);

      // Tocar el botón para abrir el diálogo de reporte
      await tester.tap(find.byKey(Key('ButtonReport')));
      await tester.pumpAndSettle();

      // Verificar que el diálogo de reporte está presente
      expect(find.byType(AlertDialog), findsOneWidget);

      // Simular el envío de un reporte
      final report = Report(
        usid: 1,
        correoSoporte: 'test@test.com',
        clienteID: 1,
        descripcion: 'Test description',
        duracion: 60,
        evaluacion: '5',
        horaInicio: DateTime.now(),
      );

      await tester.enterText(find.byType(TextFormField).at(0), '1'); // Ingresar usid
      await tester.enterText(find.byType(TextFormField).at(1), '1'); // Ingresar clienteID
      await tester.enterText(find.byType(TextFormField).at(2), 'Test description'); // Ingresar descripción
      await tester.enterText(find.byType(TextFormField).at(3), '60'); // Ingresar duración

      await tester.tap(find.text('Enviar'));
      await tester.pumpAndSettle();

      // Verificar que el reporte fue enviado correctamente
      expect(reportController.finReports.length, 1);
      expect(reportController.finReports[0].clienteID, report.clienteID);
    });
  });

  group('HomePageCord Widget Tests', () {
    late ReportController reportController;

    setUp(() {
      // Inicializar el ReportController antes de cada prueba
      reportController = ReportController(reportUseCase: Get.find<IReports>());
      Get.put<ReportController>(reportController);
    });

    testWidgets('Filter reports by client ID', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomePageCord(
            loggedEmail: 'test@test.com',
            loggedPassword: 'password',
          ),
        ),
      );

      // Verificar que se muestra la lista de reportes
      expect(find.byType(ListView), findsOneWidget);

      // Seleccionar un filtro por cliente
      await tester.tap(find.byKey(Key('dropdown')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('cli_1')); // Seleccionar cliente ID 1
      await tester.pumpAndSettle();

      // Verificar que solo se muestran reportes del cliente 1
      expect(find.text('Client: 1'), findsWidgets);

      // Verificar que la cantidad de reportes mostrados es correcta
      expect(find.byType(ListTile), findsNWidgets(1)); // Ajusta según la cantidad de reportes esperados
    });

    testWidgets('Evaluate report', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomePageCord(
            loggedEmail: 'test@test.com',
            loggedPassword: 'password',
          ),
        ),
      );

      // Verificar que se muestra la lista de reportes
      expect(find.byType(ListView), findsOneWidget);

      // Seleccionar un reporte para evaluar
      await tester.tap(find.text('Evaluate').first);
      await tester.pumpAndSettle();

      // Verificar que el diálogo de evaluación está presente
      expect(find.byType(AlertDialog), findsOneWidget);

      // Simular la evaluación del reporte
      await tester.tap(find.byType(RatingBar).last); // Tocar la última estrella
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verificar que el reporte fue evaluado correctamente
      expect(reportController.finReports[0].evaluacion, '5'); // Ajusta según la evaluación esperada
    });
  });
}
