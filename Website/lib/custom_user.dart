class CustomUser {
  String? name;
  final String email;
  String? password;
  String? uid;

  CustomUser(
      {required this.name,
      required this.email,
      required this.password,
      required this.uid});

  CustomUser fromJSON(Map<String, dynamic> json) {
    return CustomUser(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      uid: json['uid'] as String,
    );
  }

  @override
  String toString() {
    return "CustomUser { name: $name, email: $email, uid: $uid, }";
  }
}
