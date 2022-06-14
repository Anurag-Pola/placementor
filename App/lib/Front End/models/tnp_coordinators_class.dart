class TnPCoordinator {
  String? name;
  String? email;
  String? password;
  String? uid;
  String? department;
  String? phone;
  String? employeeId;

  TnPCoordinator(
      {this.name,
      this.email,
      this.password,
      this.uid,
      this.department,
      this.phone,
      this.employeeId});

  TnPCoordinator.fromJSON(Map<String, dynamic> json)
      : this(
          name: json['name'] as String,
          email: json['email'] as String,
          password: json['password'] as String,
          uid: json['uid'] as String,
          department: json['department'] as String,
          phone: json['phoneNo'] as String,
          employeeId: json['employeeId'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'department': department,
      'phoneNo': phone,
      'employeeId': employeeId,
    };
  }

  @override
  String toString() {
    return "CustomUser { name: $name, email: $email, uid: $uid, department: $department, phoneNo: $phone, employeeId: $employeeId}";
  }
}
