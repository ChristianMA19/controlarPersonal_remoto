class Client {
  Client({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"] ?? "someName",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
