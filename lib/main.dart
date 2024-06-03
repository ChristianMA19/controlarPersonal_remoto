import 'package:controlarpersonal_remoto/domain/repositories/report_repository.dart';
import 'package:controlarpersonal_remoto/domain/repositories/repository.dart';
import 'package:controlarpersonal_remoto/domain/use_case/authentication_usecase.dart';
import 'package:controlarpersonal_remoto/domain/use_case/reports_usecase.dart';
import 'package:controlarpersonal_remoto/domain/use_case/user_usecase.dart';
import 'package:controlarpersonal_remoto/ui/controller/Report_controller.dart';
import 'package:controlarpersonal_remoto/ui/controller/authentication_controller.dart';
import 'package:controlarpersonal_remoto/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'ui/pages/authentication/login.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put(Repository());
  Get.put(ReportRepository());
  Get.put(IReports(Get.put(ReportRepository())));
  Get.put<ReportController>(
      ReportController(reportUseCase: Get.find<IReports>()));
  Get.put(AuthenticationUseCase());
  Get.put(UserUseCase());
  Get.put(AuthenticationController());
  Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'TextFields & Forms',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(
          key: Key('LoginScreen'),
        ));
  }
}
