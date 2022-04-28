class CustomUser {
  String? name;
  final String email;
  String? password;
  String? uid;
  String? rollNo;

  CustomUser(
      {required this.name,
      required this.email,
      required this.password,
      required this.uid,
      required this.rollNo});

  CustomUser fromJSON(Map<String, dynamic> json) {
    return CustomUser(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      uid: json['uid'] as String,
      rollNo: json['rollNo'] as String,
    );
  }

  @override
  String toString() {
    return "CustomUser { name: $name, email: $email, uid: $uid, rollNo: $rollNo}";
  }
}
