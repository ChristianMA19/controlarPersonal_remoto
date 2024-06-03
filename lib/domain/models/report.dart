class Report {
  Report({
    this.id,
    required this.clienteID,
    required this.descripcion,
    required this.duracion,
    required this.evaluacion,
    required this.horaInicio,
  });

  int? id;
  int clienteID;
  String descripcion;
  int duracion;
  int evaluacion;
  DateTime horaInicio;

  factory Report.fromJson(Map<String, dynamic> json) {
    Report us = Report(
      id: json['id'],
      clienteID: json['clienteID'],
      descripcion: json['descripcion'],
      duracion: json['duracion'],
      evaluacion: json['evaluacion'],
      horaInicio: DateTime.parse(json['horaInicio']),
    );
    return us;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'clienteID': clienteID,
      'descripcion': descripcion,
      'duracion': duracion,
      'evaluacion': evaluacion,
      'horaInicio': horaInicio.toString(),
    };
    return data;
  }
}
