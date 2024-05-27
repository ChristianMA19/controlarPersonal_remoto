class Report {
  final String problema;
  final String cliente;
  final int horaInicio;
  final int duracion;
  final int? evaluacion;

  Report({
    required this.problema,
    required this.cliente,
    required this.horaInicio,
    required this.duracion,
    this.evaluacion,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      problema: json['Problema Solucionado'],
      cliente: json['Cliente Atendido'],
      horaInicio: json['Hora de Inicio'],
      duracion: json['Tiempo de Duración'],
      evaluacion: json['Evaluación'],
    );
  }
}
