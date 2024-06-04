class Report {
  Report({
    this.id,
    required this.usid,
    required this.correoSoporte,
    required this.clienteID,
    required this.descripcion,
    required this.duracion,
    required this.evaluacion,
    required this.horaInicio,
  });

  int? id;
  late int usid; // Cambiar a entero
  String correoSoporte;
  late int clienteID; // Cambiar a entero
  String descripcion;
  late int duracion; // Cambiar a entero
  String evaluacion;
  late DateTime horaInicio;

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      usid: json['usid'],
      correoSoporte: json['correoSoporte'],
      clienteID: json['clienteID'],
      descripcion: json['descripcion'],
      duracion: json['duracion'],
      evaluacion: json['evaluacion'],
      horaInicio: DateTime.parse(json['horaInicio']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'usid': usid,
      'correoSoporte': correoSoporte,
      'clienteID': clienteID,
      'descripcion': descripcion,
      'duracion': duracion,
      'evaluacion': evaluacion,
      'horaInicio': horaInicio.toString(),
    };
    return data;
  }
}
