class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  int? id;
  String name;
  String email;
  String password;

  String get emailAddress => email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["Name"] ?? "someName",
        email: json["Email"] ?? "someemail",
        password: json["Password"] ?? "123456",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Email": email,
        "Password": password,
      };
}
